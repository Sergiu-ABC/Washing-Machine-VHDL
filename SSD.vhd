----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 09:37:56 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
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

entity SSD is
    Port(
        CLK: in std_logic;
        digit0   : in std_logic_vector(3 downto 0); -- seconds units
        digit1   : in std_logic_vector(3 downto 0); -- seconds tens
        digit2   : in std_logic_vector(3 downto 0); -- minutes units
        digit3   : in std_logic_vector(3 downto 0); -- minutes tens
        SEGMENTS : out std_logic_vector(7 downto 0); -- a to g
        AN       : out std_logic_vector(7 downto 0)  -- anodes (active low) 
    );
end SSD;

architecture Behavioral of SSD is
    signal digit_sel: integer range 0 to 3 := 0;
begin

    process(CLK)
    variable current_bcd: std_logic_vector(3 downto 0);
    begin
        if rising_edge(CLK) then
            digit_sel <= (digit_sel + 1) mod 4;
            
            case digit_sel is
                when 0 =>
                    current_bcd := digit0;
                    AN <= "11111110";
                when 1 =>
                    current_bcd := digit1;
                    AN <= "11111101";
                when 2 =>
                    current_bcd := digit2;
                    AN <= "11111011";
                when 3 =>
                    current_bcd := digit3;
                    AN <= "11110111";
                when others =>
                    current_bcd := "0000";
                    AN <= "11111111";
            end case; 
        case current_bcd is
            when "0000" => SEGMENTS <= "00000011"; -- 0
            when "0001" => SEGMENTS <= "10011111"; -- 1
            when "0010" => SEGMENTS <= "00100101"; -- 2
            when "0011" => SEGMENTS <= "00001101"; -- 3
            when "0100" => SEGMENTS <= "10011001"; -- 4
            when "0101" => SEGMENTS <= "01001001"; -- 5
            when "0110" => SEGMENTS <= "01000001"; -- 6
            when "0111" => SEGMENTS <= "00011111"; -- 7
            when "1000" => SEGMENTS <= "00000001"; -- 8
            when "1001" => SEGMENTS <= "00001001"; -- 9
            when others => SEGMENTS <= "00000001"; -- default
        end case;
        end if;
    end process;
end Behavioral;
