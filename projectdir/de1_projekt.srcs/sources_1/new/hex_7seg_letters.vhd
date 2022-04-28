----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2022 11:15:48 AM
-- Design Name: 
-- Module Name: hex_7seg - Behavioral
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

entity hex_7seg_letters is
    Port ( hex_i : in STD_LOGIC_VECTOR (3 downto 0);
           seg_o : out STD_LOGIC_VECTOR (6 downto 0));
end hex_7seg_letters;

------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------
architecture Behavioral of hex_7seg_letters is
begin
    --------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display (Common
    -- Anode) decoder. Any time "hex_i" is changed, the process
    -- is "executed". Output pin seg_o(6) controls segment A,
    -- seg_o(5) segment B, etc.
    --       segment A
    --        | segment B
    --        |  | segment C
    --        +-+|  |   ...   segment G
    --          ||+-+          |
    --          |||            |
    -- seg_o = "0000001"-------+
    --------------------------------------------------------
    p_7seg_decoder : process(hex_i)
    begin
        --USED FOR NOTES AND HEX (0-C, 1-D, 2-E, 3-F, 4-G, 5-A, 6-B)
        case hex_i is
            -- 0
            when "0000" =>
                seg_o <= "0110001"; -- C
            -- 1
            when "0001" =>
                seg_o <= "1000010"; -- D
            -- 2
             when "0010" =>
                seg_o <= "0110000"; -- E
            -- 3
             when "0011" =>
                seg_o <= "0111000"; -- F
            -- 4
            when "0100" =>
                seg_o <= "0000100"; -- G
            -- 5
            when "0101" =>
                seg_o <= "0001000"; -- A
            -- 6
            when "0110" =>
                seg_o <= "1100000"; -- B
            -- 7
            when "0111" =>
                seg_o <= "1001000"; -- H
                
            when "1000" =>
                seg_o <= "0110000"; -- E

            -- 9
            when "1001" =>
                seg_o <= "1110001"; -- L
            -- A
            when "1010" =>
                seg_o <= "0011000"; -- P -- to show HELP on 7 seg display in case of error :)
            -- b
            when "1011" =>
                seg_o <= "1111111";
            -- C
            when "1100" =>
                seg_o <= "1111111"; 
            -- d
            when "1101" =>
                seg_o <= "1111111"; 
                
            when "1110" =>
                seg_o <= "1111111"; -- E
            when others =>
                seg_o <= "1111111"; -- F
        end case;
    end process p_7seg_decoder;

end architecture Behavioral;
