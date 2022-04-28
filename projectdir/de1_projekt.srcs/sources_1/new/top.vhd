----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2022 10:16:03 AM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
  Port ( CLK100MHZ: in STD_LOGIC;
         AUD_PWM: out STD_LOGIC;
         AUD_SD: out STD_LOGIC;
         JA: out STD_LOGIC;
         SW: in std_logic_vector(15 downto 0);
         BTNC : in STD_LOGIC;
         --7seg display
          CA : out STD_LOGIC;
          CB : out STD_LOGIC;
          CC : out STD_LOGIC;
          CD : out STD_LOGIC;
          CE : out STD_LOGIC;
          CF : out STD_LOGIC;
          CG : out STD_LOGIC;
          DP : out STD_LOGIC;
          AN : out STD_LOGIC_VECTOR (7 downto 0)
         );
end top;

architecture Behavioral of top is

   signal s_duty_for_pwm: std_logic_vector(7 downto 0); --set by sin_gen to tell pwm_gen what duty to generate
   signal s_out: std_logic; -- direct output of pwm_gen, pwm values should resemble sin signal
   signal s_desired_freq: std_logic_vector(15 downto 0); -- desired frequency (musical notes) set from switches
   
   signal s_data0: std_logic_vector(4 - 1 downto 0); -- cislo oktavy (v nasom pripade 4 a 5) na zobrazenie
   signal s_data1: std_logic_vector(4 - 1 downto 0); -- noty (C,D,E,F,G,A,B) na zobrazenie
   
begin

    sw_handler: entity work.switch_handler
        port map(
           clk => CLK100MHZ,
           sw => SW, --switches
           desired_freq => s_desired_freq,
           data0_i => s_data0,
           data1_i => s_data1
           );
            
    sin_gen: entity work.sin_generator
        port map(
            CLK => CLK100MHZ,
            FREQ => s_desired_freq,
            OUTPUT_SIN => s_duty_for_pwm,
            RST => BTNC);
            
    pwm_gen: entity work.pwm_generator
        port map(
            duty_in => s_duty_for_pwm,
            pwm_signal_out => s_out,
            RST => BTNC,
            CLK => CLK100MHZ);
    
     driver_seg_4 : entity work.driver_7seg_4digits
      port map(
          clk        => CLK100MHZ,
          reset      => BTNC,
          data0_i(3) => s_data0(3),
          data0_i(2) => s_data0(2),
          data0_i(1) => s_data0(1),
          data0_i(0) => s_data0(0),
          
          data1_i(3) => s_data1(3),
          data1_i(2) => s_data1(2),
          data1_i(1) => s_data1(1),
          data1_i(0) => s_data1(0),
          
          data2_i(3) => '0',
          data2_i(2) => '0',
          data2_i(1) => '0',
          data2_i(0) => '0',
          
          data3_i(3) => '0',
          data3_i(2) => '0',
          data3_i(1) => '0',
          data3_i(0) => '0',
          
          dp_i => "1110", --data3 is number. data2, data1, data0 are letters
          
          
          dp_o => DP,
          seg_o(6) => CA,
          seg_o(5) => CB,
          seg_o(4) => CC,
          seg_o(3) => CD,
          seg_o(2) => CE,
          seg_o(1) => CF,
          seg_o(0) => CG,
          
          dig_o(0) => AN(0),
          dig_o(1) => AN(1),
          dig_o(2) => AN(2),
          dig_o(3) => AN(3)
      );
      
      
     AUD_PWM <= s_out;
     JA <= s_out;
     AUD_SD <= '1';
     
     -- PERIOD DISPLAY in HEX
     
    

      -- Disconnect the top four digits of the 7-segment display
     AN(7 downto 4) <= b"1111";
     
end Behavioral;
