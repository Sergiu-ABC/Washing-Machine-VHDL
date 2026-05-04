----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 12:30:10 PM
-- Design Name: 
-- Module Name: LED_CONTROLLER - Behavioral
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
use WORK.STATE_PACK.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity LED_CONTROLLER is
    Port(
    clk: in std_logic;
    enable: in std_logic_vector(15 downto 0);
    state: in STATE_TYPE;
    reset: in std_logic;
    led: out std_logic_vector(15 downto 0)
    );
end LED_CONTROLLER;
-- map:
--0 : DOOR LOCK  (handled somewhere else)
--1 : WATER_PUMP (handled somewhere else)
--2 : WATER_EVAC (handled somewhere else)
--3 : HEATING
--4 : PREWASH_LED
--5 : WASHING_LED
--6 : RINSING_LED
--7 : EXTRA_RINSING_LED
--8 : CENTRIFUGATION_LED
--9 : FINISHING_LED
--10,11,12 : TEMP_LED
--13,14,15 : SPEED_LED

architecture Behavioral of LED_CONTROLLER is

begin

process(clk)
begin
if state = inactive then

end if;
end process;
end Behavioral;
