----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 12:34:03 PM
-- Design Name: 
-- Module Name: PROJECT_TOP - Behavioral
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

entity PROJECT_TOP is
  Port (
            CLK : in std_logic;
            MODE: in std_logic;
            START : in std_logic;
            DOOR : in std_logic;
            TEMP_BTN : in std_logic;
            SPEED_BTN : in std_logic;
            PREWASH_BTN: in std_logic;
            EXTRA_RINSE_BTN: in std_logic;
            AUTO_BTN: in std_logic;
            RESET: in std_logic;
            
            DOOR_LOCK_LED : out std_logic;
            WATER_PUMP_LED: out std_logic;
            WATER_EVAC_LED: out std_logic;
            HEATING_LED: out std_logic;
            PREWASH_LED: out std_logic;
            WASHING_LED: out std_logic;
            RINSING_LED: out std_logic; 
            EXTRA_RINSING_LED: out std_logic;
            CENTRIFUGATION_LED: out std_logic;
            FINISHING_LED: out std_logic;
            SPEED_LED: out std_logic_vector(2 downto 0);
            TEMP_LED: out std_logic_vector(2 downto 0);
            CAT:out std_logic_vector(7 downto 0);
            AN:out std_logic_vector(7 downto 0)  
   );
end PROJECT_TOP;

architecture Behavioral of PROJECT_TOP is
component UNIT_CONTROL is
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
end component;

component UNIT_EXECUTION is
  Port (
  CLK: in std_logic;
  T10_ENABLE,T20_ENABLE,T1_ENABLE: in std_logic;
  T10_RESET,T20_RESET,T1_RESET: in std_logic;
  HEATER_ENABLE,HEATER_RESET: in std_logic;
  LOCK_ENABLE: in std_logic;
  CALCULATOR_ENABLE: in std_logic;
  TFINAL_ENABLE,TFINAL_RESET: in std_logic;
  EVAC_START: in std_logic;
  PUMP_START: in std_logic;
  -- outputs
  TFINALC,T10C,T20C,T1C,SENSOR_TEMP: out std_logic;
  DOOR_LOCK_LED: out std_logic;
  AN: out std_logic_vector(7 downto 0);
  CAT: out std_logic_vector(7 downto 0);
  -- button signal inputs
  SPEED_INC,AUTO_INC,TEMP_INC,PREWASH_TOGGLE,EXTRA_RINSE_TOGGLE: in std_logic;
  -- rom outputs
  CURR_TEMP,CURR_SPEED: out std_logic_vector(2 downto 0);
  CURR_PREWASH,CURR_RINSE: out std_logic;
  MODE: in std_logic;
  WATER_PUMP_LED: out std_logic;
  WATER_EVAC_LED: out std_logic
   );
end component;
 -- Intermediary signals
  signal T10_ENABLE, T10_RESET, T20_ENABLE, T20_RESET, T1_ENABLE, T1_RESET: std_logic;
  signal HEATER_ENABLE, HEATER_RESET, LOCK_ENABLE: std_logic :='0';
  signal CALCULATOR_ENABLE, TFINAL_ENABLE, TFINAL_RESET: std_logic :='0';
  signal EVAC_START, PUMP_START: std_logic :='0';
  signal TFINALC, T10C, T20C, T1C, SENSOR_TEMP: std_logic :='0';
  signal SPEED_INC, TEMP_INC, AUTO_INC, PREWASH_TOGGLE, EXTRA_RINSE_TOGGLE: std_logic :='0';
  signal CURR_TEMP, CURR_SPEED: std_logic_vector(2 downto 0):="000";
  signal CURR_PREWASH, CURR_RINSE: std_logic := '0';
  signal MODE_OUT: std_logic:='0';
  
component MPG is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           enable : out STD_LOGIC);
end component;  
component DEBOUNCER is
    Port(
    CLK: in std_logic;
    BTN: in std_logic;
    EDGE: out std_logic);
end component;

  signal TEMP_EDGE,AUTO_EDGE,SPEED_EDGE,PREWASH_EDGE,RINSE_EDGE: std_logic := '0';
begin
--  D1: DEBOUNCER port map(
--  CLK=>CLK,
--  BTN => TEMP_BTN,
--  EDGE => TEMP_EDGE
--  );
--  D2: DEBOUNCER port map(
--  CLK=>CLK,
--  BTN => SPEED_BTN,
--  EDGE => SPEED_EDGE
--  );
--  D3: DEBOUNCER port map(
--  CLK=>CLK,
--  BTN => PREWASH_BTN,
--  EDGE => PREWASH_EDGE
--  );
--  D4: DEBOUNCER port map(
--  CLK=>CLK,
--  BTN => AUTO_BTN,
--  EDGE => AUTO_EDGE
--  );
--  D5: DEBOUNCER port map(
--  CLK=>CLK,
--  BTN => EXTRA_RINSE_BTN,
--  EDGE => RINSE_EDGE
--  );
    D1: MPG port map(
    CLK => CLK,
    BTN => TEMP_BTN,
    ENABLE => TEMP_EDGE);
    D2: MPG port map(
    CLK => CLK,
    BTN => PREWASH_BTN,
    ENABLE => PREWASH_EDGE);
    D3: MPG port map(
    CLK => CLK,
    BTN => SPEED_BTN,
    ENABLE => SPEED_EDGE);
    D4: MPG port map(
    CLK => CLK,
    BTN => EXTRA_RINSE_BTN,
    ENABLE => RINSE_EDGE);
    D5: MPG port map(
    CLK => CLK,
    BTN => AUTO_BTN,
    ENABLE => AUTO_EDGE);
  CONTROL_UNIT: UNIT_CONTROL
    port map (
      CLK => CLK,
      RESET => RESET,
      MODE => MODE,
      DOOR => DOOR,
      START => START,
      HEATING_LED => HEATING_LED,
      PREWASH_LED => PREWASH_LED,
      WASHING_LED => WASHING_LED,
      RINSING_LED => RINSING_LED,
      EXTRA_RINSING_LED => EXTRA_RINSING_LED,
      CENTRIFUGATION_LED => CENTRIFUGATION_LED,
      FINISHING_LED => FINISHING_LED,
      SPEED_LED => SPEED_LED,
      TEMP_LED => TEMP_LED,
      T10_ENABLE => T10_ENABLE,
      T10_RESET => T10_RESET,
      T20_ENABLE => T20_ENABLE,
      T20_RESET => T20_RESET,
      T1_ENABLE => T1_ENABLE,
      T1_RESET => T1_RESET,
      HEATER_ENABLE => HEATER_ENABLE,
      HEATER_RESET => HEATER_RESET,
      LOCK_ENABLE => LOCK_ENABLE,
      CALCULATOR_ENABLE => CALCULATOR_ENABLE,
      TFINAL_ENABLE => TFINAL_ENABLE,
      TFINAL_RESET => TFINAL_RESET,
      TFINALC => TFINALC,
      EVAC_START => EVAC_START,
      PUMP_START => PUMP_START,
      T10C => T10C,
      T20C => T20C,
      T1C => T1C,
      SENSOR_TEMP => SENSOR_TEMP,
      CURR_SPEED => CURR_SPEED,
      CURR_TEMP => CURR_TEMP,
      CURR_PREWASH => CURR_PREWASH,
      CURR_RINSE => CURR_RINSE,
      SPEED_BTN => SPEED_EDGE,
      TEMP_BTN => TEMP_EDGE,
      AUTO_BTN => AUTO_EDGE,
      PREWASH_BTN => PREWASH_EDGE,
      EXTRA_RINSE_BTN => RINSE_EDGE,
      MODE_OUT => MODE_OUT,
      SPEED_INC => SPEED_INC,
      TEMP_INC => TEMP_INC,
      AUTO_INC => AUTO_INC,
      PREWASH_TOGGLE => PREWASH_TOGGLE,
      EXTRA_RINSE_TOGGLE => EXTRA_RINSE_TOGGLE
    );

  EXECUTION_UNIT: UNIT_EXECUTION
    port map (
      CLK => CLK,
      T10_ENABLE => T10_ENABLE,
      T20_ENABLE => T20_ENABLE,
      T1_ENABLE => T1_ENABLE,
      T10_RESET => T10_RESET,
      T20_RESET => T20_RESET,
      T1_RESET => T1_RESET,
      HEATER_ENABLE => HEATER_ENABLE,
      HEATER_RESET => HEATER_RESET,
      LOCK_ENABLE => LOCK_ENABLE,
      CALCULATOR_ENABLE => CALCULATOR_ENABLE,
      TFINAL_ENABLE => TFINAL_ENABLE,
      TFINAL_RESET => TFINAL_RESET,
      EVAC_START => EVAC_START,
      PUMP_START => PUMP_START,
      TFINALC => TFINALC,
      T10C => T10C,
      T20C => T20C,
      T1C => T1C,
      SENSOR_TEMP => SENSOR_TEMP,
      DOOR_LOCK_LED => DOOR_LOCK_LED,
      AN => AN,
      CAT => CAT,
      SPEED_INC => SPEED_INC,
      AUTO_INC => AUTO_INC,
      TEMP_INC => TEMP_INC,
      PREWASH_TOGGLE => PREWASH_TOGGLE,
      EXTRA_RINSE_TOGGLE => EXTRA_RINSE_TOGGLE,
      CURR_TEMP => CURR_TEMP,
      CURR_SPEED => CURR_SPEED,
      CURR_PREWASH => CURR_PREWASH,
      CURR_RINSE => CURR_RINSE,
      MODE => MODE_OUT,
      WATER_PUMP_LED => WATER_PUMP_LED,
      WATER_EVAC_LED => WATER_EVAC_LED
    );

end Behavioral;
