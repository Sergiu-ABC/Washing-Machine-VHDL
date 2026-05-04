----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 01:03:52 PM
-- Design Name: 
-- Module Name: HEATER - Behavioral
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

entity HEATER is
    Port ( CLK_2S : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           TARGET_TEMP : in std_logic_vector(2 downto 0);
           RESET : in STD_LOGIC;
           SENSOR_TEMP : out STD_LOGIC);
end HEATER;

architecture Behavioral of HEATER is
signal current_temp: integer := 15;
signal temp: integer := 90;
begin
    process (CLK_2S,RESET)
    begin
        if RESET = '1' then
            current_temp <= 15;
            SENSOR_TEMP <= '0';
            temp <= 90;
            else
        if rising_edge(CLK_2S) then 
                case TARGET_TEMP is
                 when "001" => temp<=30;
                 when "010" => temp<=40;
                 when "011" => temp<=60;
                 when "100" => temp<=90;
                 when others => temp<=30;
    end case;
            if ENABLE = '1' then
            if current_temp < temp then
                current_temp <= current_temp + 1;
                SENSOR_TEMP <='0';
            else
                SENSOR_TEMP <= '1';
            end if;
            end if;
            end if;
        end if;
    end process;
end Behavioral;
