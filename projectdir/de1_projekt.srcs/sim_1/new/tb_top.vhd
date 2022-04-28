
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
      
   
    signal s_CLK100MHZ :  STD_LOGIC;
   
    signal s_CA_vector : STD_LOGIC_VECTOR (6 downto 0);
    signal s_AN_vector : STD_LOGIC_VECTOR (7 downto 0);
    signal s_DP: std_logic;

    signal     s_AUD_PWM:  STD_LOGIC;
    signal     s_AUD_SD: STD_LOGIC;
    signal     s_JA:  STD_LOGIC;
    signal     s_OUT_PWM_SIN:  STD_LOGIC;
    signal     s_SW: std_logic_vector(15 downto 0);
    
begin
uut_top : entity work.top
    port map(
    CLK100MHZ => s_CLK100MHZ,
    AUD_PWM => s_AUD_PWM,
    AUD_SD => s_AUD_SD,
    JA => s_JA,
    SW =>  b"0000_0000_0000_0001", -- C4,
    BTNC => '0',
    CA => s_CA_vector(0),
    CB => s_CA_vector(1),
    CC => s_CA_vector(2),
    CD => s_CA_vector(3),
    CE => s_CA_vector(4),
    CF => s_CA_vector(5),
    CG => s_CA_vector(6),
    DP => s_DP,
    AN => s_AN_vector
    );
    
    p_clk_gen : process
    begin
         while NOW < 1000000000ms loop
            s_CLK100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_CLK100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen; 

    p_stimulus : process
    begin     
        
       
        
        
    end process p_stimulus;

end Behavioral;
