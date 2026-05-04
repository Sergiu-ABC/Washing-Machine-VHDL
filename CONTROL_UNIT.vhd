----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 11:12:42 AM
-- Design Name: 
-- Module Name: UNIT_CONTROL - Behavioral
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
use WORK.state_pack.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UNIT_CONTROL is
  Port (
  -- inputs
  CLK: in std_logic;
  RESET: in std_logic;
  MODE: in std_logic;
  DOOR: in std_logic;
  START: in std_logic;
  --  led outputs
  HEATING_LED: out std_logic;
  PREWASH_LED: out std_logic;
  WASHING_LED: out std_logic;
  RINSING_LED: out std_logic;
  EXTRA_RINSING_LED: out std_logic;
  CENTRIFUGATION_LED: out std_logic;
  FINISHING_LED: out std_logic;
  SPEED_LED: out std_logic_vector(2 downto 0);
  TEMP_LED: out std_logic_vector(2 downto 0);
  -- execution unit connections
  T10_ENABLE: out std_logic;
  T10_RESET: out std_logic;
  
  T20_ENABLE: out std_logic;
  T20_RESET: out std_logic;
  
  T1_ENABLE: out std_logic;
  T1_RESET: out std_logic;
  
  HEATER_ENABLE: out std_logic;
  HEATER_RESET: out std_logic;
  
  LOCK_ENABLE: out std_logic;
  
  CALCULATOR_ENABLE: out std_logic;
  TFINAL_ENABLE: out std_logic;
  TFINAL_RESET: out std_logic;
  TFINALC: in std_logic;
  
  EVAC_START: out std_logic;
  PUMP_START: out std_logic;
  -- in connections
  T10C: in std_logic;
  T20C: in std_logic;
  T1C: in std_logic;
  SENSOR_TEMP: in std_logic;
  CURR_SPEED: in std_logic_vector(2 downto 0);
  CURR_TEMP: in std_logic_vector(2 downto 0);
  CURR_PREWASH: in std_logic;
  CURR_RINSE: in std_logic;
  -- button control
  SPEED_BTN,TEMP_BTN,AUTO_BTN,PREWASH_BTN,EXTRA_RINSE_BTN: in std_logic;
  MODE_OUT: out std_logic;
  SPEED_INC,TEMP_INC,AUTO_INC,PREWASH_TOGGLE,EXTRA_RINSE_TOGGLE: out std_logic
   );
end UNIT_CONTROL;

architecture Behavioral of UNIT_CONTROL is
signal state: STATE_TYPE:=inactive;

begin
      process(CLK)
      begin
      if rising_edge(CLK) then
      
        if RESET = '1' then
        state <= inactive;
        else
      case state is
when inactive =>
MODE_OUT <= MODE;
HEATING_LED <= '0';
PREWASH_LED <= CURR_PREWASH;
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= CURR_RINSE;
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= CURR_SPEED;
TEMP_LED <= CURR_TEMP;

T10_ENABLE <= '0';
T10_RESET <= '1';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '0';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '0';
TFINAL_RESET <= '1';

if MODE = '1' then
state <= auto_mode;
else
state <= manual_mode;
end if;

when manual_mode =>
MODE_OUT <= MODE;
HEATING_LED <= '0';
PREWASH_LED <= CURR_PREWASH;
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= CURR_RINSE;
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= CURR_SPEED;
TEMP_LED <= CURR_TEMP;

T10_ENABLE <= '0';
T10_RESET <= '1';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '0';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= SPEED_BTN;
TEMP_INC <= TEMP_BTN;
AUTO_INC <= '0';
PREWASH_TOGGLE <= PREWASH_BTN;
EXTRA_RINSE_TOGGLE <= EXTRA_RINSE_BTN;

CALCULATOR_ENABLE <='1';
TFINAL_ENABLE <= '0';
TFINAL_RESET <= '1';

--state <= calc_time;
if DOOR = '1' then
state<=wait_start;
else
if MODE = '0' then
state <= manual_mode;
else state <=auto_mode;
end if;
end if;
when auto_mode =>
MODE_OUT <= MODE;

HEATING_LED <= '0';
PREWASH_LED <= CURR_PREWASH;
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= CURR_RINSE;
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= CURR_SPEED;
TEMP_LED <= CURR_TEMP;

T10_ENABLE <= '0';
T10_RESET <= '1';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '0';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= AUTO_BTN;
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='1';
TFINAL_ENABLE <= '0';
TFINAL_RESET <= '1';

if DOOR = '1' then
state<=wait_start;
else
if MODE = '0' then
state <= manual_mode;
else state <=auto_mode;
end if;
end if;

when calc_time =>

HEATING_LED <= '0';
PREWASH_LED <= CURR_PREWASH;
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= CURR_RINSE;
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= CURR_SPEED;
TEMP_LED <= CURR_TEMP;

T10_ENABLE <= '0';
T10_RESET <= '1';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '0';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='1';
TFINAL_ENABLE <= '0';
TFINAL_RESET <= '1';


when wait_start =>

HEATING_LED <= '0';
PREWASH_LED <= '0';
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= '0';
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= "000";
TEMP_LED <= "000";

T10_ENABLE <= '0';
T10_RESET <= '1';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '0';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '0';
TFINAL_RESET <= '1';

if DOOR = '0' then
state <= inactive;
else
    if START = '1' then
    PUMP_START <= '1';
    state<=water_heating;
    else
    state<=wait_start;
    end if;
end if;

when water_heating =>

HEATING_LED <= '1';
PREWASH_LED <= '0';
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= '0';
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= "000";
TEMP_LED <= CURR_TEMP;

T10_ENABLE <= '0';
T10_RESET <= '1';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '1';
HEATER_RESET <= '0';

LOCK_ENABLE <= '1';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '1';
TFINAL_RESET <= '0';

if SENSOR_TEMP = '1' then

    if CURR_PREWASH = '1' then
    state <= prewashing;
    else
    state <= washing;
    end if;
    
end if;

when prewashing =>

HEATING_LED <= '0';
PREWASH_LED <= '1';
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= '0';
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= "000";
TEMP_LED <= CURR_TEMP;

T10_ENABLE <= '1';
T10_RESET <= '0';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '1';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '1';
TFINAL_RESET <= '0';

if T10C = '1' then

state <= washing;
end if;

when washing =>

HEATING_LED <= '0';
PREWASH_LED <= '0';
WASHING_LED <= '1';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= '0';
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= "000";
TEMP_LED <= CURR_TEMP;

T10_ENABLE <= '0';
T10_RESET <= '1';

T20_ENABLE <= '1';
T20_RESET <= '0';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '1';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '1';
TFINAL_RESET <= '0';

if T20C = '1' then

state <= rinsing;
PUMP_START <= '1';
EVAC_START <= '1';
end if;

when rinsing =>

HEATING_LED <= '0';
PREWASH_LED <= '0';
WASHING_LED <= '0';
RINSING_LED <= '1';
EXTRA_RINSING_LED <= '0';
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= "000";
TEMP_LED <= "000";

T10_ENABLE <= '1';
T10_RESET <= '0';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '1';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '1';
TFINAL_RESET <= '0';

if T10C = '1' then

    if CURR_RINSE = '1' then
    T10_RESET <= '1';
    state <= extra_rinsing;
    else
    T10_RESET <= '1';
    EVAC_START <= '1';
    state <=centrifugation;
    end if;
end if;

when extra_rinsing =>

HEATING_LED <= '0';
PREWASH_LED <= '0';
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= '1';
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '0';

SPEED_LED <= "000";
TEMP_LED <= "000";

T10_ENABLE <= '1';
T10_RESET <= '0';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '1';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '1';
TFINAL_RESET <= '0';

if T10C = '1' then
T10_RESET <= '1';
EVAC_START <= '1';
state <= centrifugation;
end if;

when centrifugation =>
HEATING_LED <= '0';
PREWASH_LED <= '0';
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= '0';
CENTRIFUGATION_LED <= '1';
FINISHING_LED <= '0';

SPEED_LED <= CURR_SPEED;
TEMP_LED <= "000";

T10_ENABLE <= '1';
T10_RESET <= '0';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '0';
T1_RESET <= '1';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '1';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '1';
TFINAL_RESET <= '0';

if T10C = '1' then

state <= finishing;
end if;

when finishing =>
HEATING_LED <= '0';
PREWASH_LED <= '0';
WASHING_LED <= '0';
RINSING_LED <= '0';
EXTRA_RINSING_LED <= '0';
CENTRIFUGATION_LED <= '0';
FINISHING_LED <= '1';

SPEED_LED <= "000";
TEMP_LED <= "000";

T10_ENABLE <= '0';
T10_RESET <= '1';

T20_ENABLE <= '0';
T20_RESET <= '1';

T1_ENABLE <= '1';
T1_RESET <= '0';

HEATER_ENABLE <= '0';
HEATER_RESET <= '1';

LOCK_ENABLE <= '1';

EVAC_START <= '0';
PUMP_START <= '0';

SPEED_INC <= '0';
TEMP_INC <= '0';
AUTO_INC <= '0';
PREWASH_TOGGLE <= '0';
EXTRA_RINSE_TOGGLE <= '0';

CALCULATOR_ENABLE <='0';
TFINAL_ENABLE <= '1';
TFINAL_RESET <= '0';

if TFINALC = '1' then
state <= inactive;
end if;

when others => state<=inactive;
      end case;
        end if;
      end if;
      end process;

end Behavioral;
