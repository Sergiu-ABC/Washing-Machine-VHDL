----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2025 11:18:11 AM
-- Design Name: 
-- Module Name: WATER_CONTROL - Behavioral
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

entity WATER_CONTROL is
    Port ( CLK : in STD_LOGIC;
           CLK_1S: in STD_LOGIC;
           PUMP_START : in STD_LOGIC;
           EVAC_START : in STD_LOGIC;
           PUMP_LED : out STD_LOGIC;
           EVAC_LED : out STD_LOGIC);
end WATER_CONTROL;

architecture Behavioral of WATER_CONTROL is
signal timer_pump: integer := 0;
signal timer_evac: integer := 0;
begin
    process(CLK)
    begin
    if rising_edge(CLK) then
         if PUMP_START = '1' then
            timer_pump <= 1;
        elsif CLK_1S = '1' and timer_pump > 0 then
            timer_pump <= 0;
        end if;

        if EVAC_START = '1' then
            timer_evac <= 1;
        elsif CLK_1S = '1' and timer_evac > 0 then
            timer_evac <= 0;
        end if;
    end if;
    end process;

PUMP_LED <= '1' when timer_pump > 0 else '0';
EVAC_LED <= '1' when timer_evac > 0 else '0';

end Behavioral;
