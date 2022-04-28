----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2022 02:03:08 PM
-- Design Name: 
-- Module Name: switch_handler - Behavioral
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

entity switch_handler is
    Port ( 
           clk: in std_logic;
           sw : in STD_LOGIC_VECTOR (15 downto 0); --switches
           desired_freq : out STD_LOGIC_VECTOR (15 downto 0):= X"2974"; --default is C4
           data0_i : out  std_logic_vector(4 - 1 downto 0):= X"0"; -- for numbers on 7seg
           data1_i : out  std_logic_vector(4 - 1 downto 0):= X"0" -- for letters on 7seg
           );
end switch_handler;

architecture Behavioral of switch_handler is

   
begin

     p_switch_main: process(clk)
        begin
            if rising_edge(clk) then
                if (sw(7) = '1') then
                    desired_freq <= x"14bb"; --C5
                    data1_i <= X"0"; --0 je C
                    data0_i <= x"5";
                elsif (sw(6) = '1') then
                    desired_freq <= x"15f6"; --B4
                    data1_i <= X"6";
                    data0_i <= x"4";
                elsif (sw(5) = '1') then
                    desired_freq <= x"18a7"; --A4
                    data1_i <= X"5";
                    data0_i <= x"4";
                elsif (sw(4) = '1') then
                    desired_freq <= x"1bac"; --G4
                    data1_i <= X"4";
                    data0_i <= x"4";
                elsif (sw(3) = '1') then
                    desired_freq <= x"1f0f"; --F4
                    data1_i <= X"3";
                elsif (sw(2) = '1') then
                    desired_freq <= x"20f2"; --E4
                    data1_i <= X"2";
                    data0_i <= x"4";
                elsif (sw(1) = '1') then
                    desired_freq <= x"24f0"; --D4
                    data1_i <= X"1";
                    data0_i <= x"4";
                elsif (sw(0) = '1') then
                    desired_freq <= x"2974"; --C4
                    data1_i <= X"0";
                    data0_i <= x"4";
                end if;
            end if;
         end process;

end Behavioral;
