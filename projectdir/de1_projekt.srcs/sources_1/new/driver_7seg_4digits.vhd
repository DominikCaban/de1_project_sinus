------------------------------------------------------------
--
-- (EDITED) Driver for 4-digit 7-segment display.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- 
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
-- Edited by AudioGeneration TEAM1 from DE1 course,2022
-- EDITED TO SHOW ALSO NOTES AND LETTERS,
-- USES 2 BCD-to-7seg decoders, 1 for numbers and 2 for notes (letters)
--      Based on DECIMAL POINT DATA (we dont need DECIMAL POINT), we determine for each
--      BCD DATA whether to use number hex decoder or letter version
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------
entity driver_7seg_4digits is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        -- 4-bit input values for individual digits
        data0_i : in  std_logic_vector(4 - 1 downto 0);
        data1_i : in  std_logic_vector(4 - 1 downto 0);
        data2_i : in  std_logic_vector(4 - 1 downto 0); -- unused
        data3_i : in  std_logic_vector(4 - 1 downto 0); -- unused
        -- 4-bit input value for decimal points
        dp_i    : in  std_logic_vector(4 - 1 downto 0);
        -- Decimal point for specific digit
        dp_o    : out std_logic;
        -- Cathode values for individual segments
        seg_o   : out std_logic_vector(7 - 1 downto 0);
        -- Common anode signals to individual displays
        dig_o   : out std_logic_vector(4 - 1 downto 0)
    );
end entity driver_7seg_4digits;

------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------
architecture Behavioral of driver_7seg_4digits is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal 2-bit counter for multiplexing 4 digits
    signal s_cnt : std_logic_vector(2 - 1 downto 0);
    -- Internal 4-bit value for 7-segment decoder
    signal s_hex : std_logic_vector(4 - 1 downto 0);
    
    signal s_seg_out_num: std_logic_vector(7 - 1 downto 0);
    signal s_seg_out_let: std_logic_vector(7 - 1 downto 0);
begin
    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 4 ms
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 40000
        )
        port map(
            clk => clk,
            reset => reset,
            ce_o  => s_en
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 2-bit
    -- down counter
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 2
        )
        port map(
            en_i => s_en,
            cnt_up_i => '0', 
            reset => reset,
            clk => clk,
            cnt_o => s_cnt
        );

    --------------------------------------------------------
    -- Instance (copy) of hex_7seg entity performs a 7-segment
    -- display decoder
    hex2seg : entity work.hex_7seg
        port map(
            hex_i => s_hex,
            seg_o => s_seg_out_num
        );
        
    hex_7seg_letters : entity work.hex_7seg_letters
        port map(
            hex_i => s_hex,
            seg_o => s_seg_out_let
        );

    --------------------------------------------------------
    -- p_mux:
    -- A sequential process that implements a multiplexer for
    -- selecting data for a single digit, a decimal point 
    -- signal, and switches the common anodes of each display.
    --------------------------------------------------------
    p_mux : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_hex <= data0_i;
                dp_o  <= dp_i(0);
                dig_o <= "1110";
            else
                case s_cnt is
                    when "11" =>
                        s_hex <= data3_i;
                        dp_o  <= dp_i(3);
                        if (dp_i(3) = '1') then
                            seg_o <= s_seg_out_let;
                        else
                            seg_o <= s_seg_out_num;
                        end if;
                        dig_o <= "1111"; -- vypnutie disp

                    when "10" =>
                        s_hex <= data2_i;
                        dp_o  <= dp_i(2);
                        if (dp_i(2) = '1') then
                            seg_o <= s_seg_out_let;
                        else
                            seg_o <= s_seg_out_num;
                        end if;
                        dig_o <= "1111"; -- vypnutie disp

                    when "01" =>
                        s_hex <= data1_i;
                        dp_o  <= dp_i(1);
                        if (dp_i(1) = '1') then
                            seg_o <= s_seg_out_let;
                        else
                            seg_o <= s_seg_out_num;
                        end if;
                        dig_o <= "1101";

                    when others =>
                        s_hex <= data0_i;
                        dp_o  <= '1';
                        if (dp_i(0) = '1') then
                            seg_o <= s_seg_out_let;
                        else
                            seg_o <= s_seg_out_num;
                        end if;
                        dig_o <= "1110";
                end case;
            end if;
        end if;
    end process p_mux;

end architecture Behavioral;
