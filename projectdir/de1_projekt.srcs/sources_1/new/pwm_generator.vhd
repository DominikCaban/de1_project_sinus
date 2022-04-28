library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pwm_generator is
    Port ( duty_in : in STD_LOGIC_VECTOR (7 downto 0); -- duty from singen changes
           pwm_signal_out : out STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC);
           
end pwm_generator;

architecture Behavioral of pwm_generator is
     signal s_cnt : STD_LOGIC_VECTOR(7 downto 0) := "00000000"; 
     signal s_out : STD_LOGIC := '0';
     signal s_duty_old : STD_LOGIC_VECTOR(7 downto 0) := "00000000"; --stores duty_in so pwm pulse can complete
begin
PWM_PROC : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                s_cnt <= "00000000";
                pwm_signal_out <= '0';
                s_duty_old <= duty_in;
            else
                if(s_cnt = s_duty_old) then
                    s_out <= '0';
                end if;
                if(s_cnt = "00000000") then
                    s_out <= '1';
                    s_duty_old <= duty_in;
                end if;
                s_cnt <= std_logic_vector(to_unsigned(to_integer(unsigned( s_cnt )) + 1, 8));
                
                if (duty_in = "00000000") then
                   s_out <= '0';
                end if;
                pwm_signal_out <= s_out;

            end if;
        end if;
     end process;
end Behavioral;
