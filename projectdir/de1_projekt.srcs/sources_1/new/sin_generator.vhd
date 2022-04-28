library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity sin_generator is
    Port ( clk : in STD_LOGIC;
           freq : in STD_LOGIC_VECTOR (15 downto 0);
           output_sin : out STD_LOGIC_VECTOR (7 downto 0);
           rst : in STD_LOGIC);
end sin_generator;

-- clk_freq = 100 000 000 Hz (100MHz)
-- period = 36 ticks of CLK
-- MAX FREQ = 2 777 777,77777777777777777777777777777777777777777777777777777777777777778 Hz
-- MAX VALUE = 2^14


architecture behav of sin_generator is
    signal s_cnt : STD_LOGIC_VECTOR(15 downto 0) := X"0000"; -- counter for freqency variations
    signal s_data_cnt : STD_LOGIC_VECTOR(5 downto 0) := "000000"; -- counter to determine part of sine wave
    signal s_threshold : STD_LOGIC_VECTOR(15 downto 0) := X"0000"; -- period of one pwm pulse



begin

PWM_PROC : process(clk)
 begin
  
        if rising_edge(clk) then
            
            if rst = '1' then
                OUTPUT_SIN <= "00000000";
                s_cnt <= X"0000";
            else
                s_threshold <= FREQ;
                s_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned( s_cnt )) + 1, 16));
                if(s_cnt = s_threshold) then
                    if(s_data_cnt = "100011") then
                        s_data_cnt <= "000000";
                    else
                    s_data_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned( s_data_cnt )) + 1, 6));
                    end if;
                    s_cnt <= X"0000";
                end if;
                    case s_data_cnt is 
                        when "000000" => --0
                            OUTPUT_SIN <= X"80";
                        when "000001" => --1
                            OUTPUT_SIN <= X"96";
                        when "000010" => --2
                            OUTPUT_SIN <= X"AC";
                        when "000011" => --3
                            OUTPUT_SIN <= X"C0";
                        when "000100" => --4
                            OUTPUT_SIN <= X"D2";
                        when "000101" => --5
                            OUTPUT_SIN <= X"E2";
                        when "000110" => --6
                            OUTPUT_SIN <= X"EF";
                        when "000111" => --7
                            OUTPUT_SIN <= X"F8";
                        when "001000" => --8
                            OUTPUT_SIN <= X"FE";
                        when "001001" => --9
                            OUTPUT_SIN <= X"FF";
                        when "001010" => --10
                            OUTPUT_SIN <= X"FE";
                        when "001011" => --11
                            OUTPUT_SIN <= X"F8";
                        when "001100" => --12
                            OUTPUT_SIN <= X"EF"; 
                        when "001101" => --13
                            OUTPUT_SIN <= X"E2";
                        when "001110" => --14
                            OUTPUT_SIN <= X"D2";
                        when "001111" => --15
                            OUTPUT_SIN <= X"C0";
                        when "010000" => --16
                            OUTPUT_SIN <= X"AC";
                        when "010001" => --17
                            OUTPUT_SIN <= X"96";
                        when "010010" => --18
                            OUTPUT_SIN <= X"80";
                        when "010011" => --19
                            OUTPUT_SIN <= X"6A";
                        when "010100" => --20
                            OUTPUT_SIN <= X"54";
                        when "010101" => --21
                            OUTPUT_SIN <= X"40";
                        when "010110" => --22
                            OUTPUT_SIN <= X"2E";
                        when "010111" => --23
                            OUTPUT_SIN <= X"1E";
                        when "011000" => --24
                            OUTPUT_SIN <= X"11";
                        when "011001" => --25
                            OUTPUT_SIN <= X"08"; 
                        when "011010" => --26
                            OUTPUT_SIN <= X"02";
                        when "011011" => --27
                            OUTPUT_SIN <= X"00";
                        when "011100" => --28
                            OUTPUT_SIN <= X"02";
                        when "011101" => --29
                            OUTPUT_SIN <= X"08";
                        when "011110" => --30
                            OUTPUT_SIN <= X"11";
                        when "011111" => --31
                            OUTPUT_SIN <= X"1E";
                        when "100000" => --32
                            OUTPUT_SIN <= X"2E";
                        when "100001" => --33
                            OUTPUT_SIN <= X"40";
                        when "100010" => --34
                            OUTPUT_SIN <= X"54";
                        when "100011" => --35
                            OUTPUT_SIN <= X"6A";
                        when others =>
                            OUTPUT_SIN <= X"00";
                     end case;
              
               
            end if;
        end if;
     end process;
end behav;



       

