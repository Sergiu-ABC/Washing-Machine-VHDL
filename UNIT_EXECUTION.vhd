----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 11:24:33 AM
-- Design Name: 
-- Module Name: UNIT_EXECUTION - Behavioral
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

entity UNIT_EXECUTION is
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
end UNIT_EXECUTION;

architecture Behavioral of UNIT_EXECUTION is

component WATER_CONTROL is
    Port ( CLK : in STD_LOGIC;
           CLK_1S: in STD_LOGIC;
           PUMP_START : in STD_LOGIC;
           EVAC_START : in STD_LOGIC;
           PUMP_LED : out STD_LOGIC;
           EVAC_LED : out STD_LOGIC);
end component;

component SSD is
    Port(
        CLK: in std_logic;
        digit0   : in std_logic_vector(3 downto 0); -- seconds units
        digit1   : in std_logic_vector(3 downto 0); -- seconds tens
        digit2   : in std_logic_vector(3 downto 0); -- minutes units
        digit3   : in std_logic_vector(3 downto 0); -- minutes tens
        SEGMENTS : out std_logic_vector(7 downto 0); -- a to g
        AN       : out std_logic_vector(7 downto 0)  -- anodes (active low) 
    );
end component;

component FINAL_TIMER is
    Port(
        CLK : in std_logic;
        CLK_1S: in std_logic;
        ENABLE: in std_logic;
        MINUTES_IN: in integer;
        SECONDS_IN: in integer;
        RESET: in std_logic;
        digit0      : out std_logic_vector(3 downto 0); -- seconds units
        digit1      : out std_logic_vector(3 downto 0); -- seconds tens
        digit2      : out std_logic_vector(3 downto 0); -- minutes units
        digit3      : out std_logic_vector(3 downto 0);  -- minutes tens  
        TC : out std_logic
    );
end component;
signal digit0,digit1,digit2,digit3: std_logic_vector(3 downto 0):="0000";

component TIME_CALCULATOR is
    Port ( CLK: in STD_LOGIC;
           ENABLE: in STD_LOGIC;
           MODE: in STD_LOGIC;
           AUTO : in integer;
           TEMP: in STD_LOGIC_VECTOR(2 downto 0);
           PREWASH: in integer;
           EXTRA_RINSE: in integer;
           MINS: out integer;
           SECS: out integer
    );
end component;
signal MINS,SECS: integer:=0;
component HEATER is
    Port ( CLK_2S : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           TARGET_TEMP : in std_logic_vector(2 downto 0);
           RESET : in STD_LOGIC;
           SENSOR_TEMP : out STD_LOGIC);
end component;

component TIMER is
  Generic(TARGET: integer := 10);
    Port( CLK_1M: in std_logic;
          ENABLE: in std_logic;
          RESET: in std_logic;
          TC: out std_logic
    );
end component;

component CLOCK_DIVIDER is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK_2S : out STD_LOGIC;
           CLK_1M : out STD_LOGIC;
           CLK_1S : out STD_LOGIC;
           CLK_DISPLAY : out STD_LOGIC);
end component;
signal CLK_2S,CLK_1M,CLK_1S,CLK_DISPLAY: std_logic :='0';
signal DIVIDER_RESET: std_logic:='0';

component DOOR_LOCK_SYSTEM is
    Port ( CLK : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           LED : out STD_LOGIC);
end component;

component COUNTER is
  Generic(
    MAX : integer :=1
  );
  Port (
        CLK: in std_logic;
        PULSE : in std_logic;
        COUNT : out integer
   );
end component;
signal auto_sel,temp_sel,speed_sel,prewash_sel,extra_rinse_sel: integer := 0;

component SETTINGS is
  Port (
  CLK: in std_logic;
  MODE: in std_logic;
  AUTO_SEL: in integer;
  TEMP_SEL: in integer;
  SPEED_SEL: in integer;
  PREWASH_SEL: in integer;
  EXTRA_RINSE_SEL: in integer;
  TEMP: out std_logic_vector(2 downto 0);
  SPEED : out std_logic_vector(2 downto 0);
  PREWASH,RINSE: out std_logic
   );
end component;
signal TEMP,SPEED:std_logic_vector(2 downto 0):="000";
signal PREWASH,RINSE: std_logic:='0';

begin

DIVIDER: CLOCK_DIVIDER port map(
CLK=>CLK,
RESET=>DIVIDER_RESET,
CLK_2S=>CLK_2S,
CLK_1M=>CLK_1M,
CLK_1S=>CLK_1S,
CLK_DISPLAY=>CLK_DISPLAY
);

HEAT: HEATER port map(
    CLK_2S => CLK_2S,
    ENABLE => HEATER_ENABLE,
    TARGET_TEMP =>TEMP,
    RESET => HEATER_RESET,
    SENSOR_TEMP => SENSOR_TEMP
);
TIMER10: TIMER generic map (TARGET=> 10) port map(
  CLK_1M => CLK_1M,
  ENABLE => T10_ENABLE,
  RESET => T10_RESET,
  TC => T10C      
);
TIMER20: TIMER generic map (TARGET=> 20) port map(
  CLK_1M => CLK_1M,
  ENABLE => T20_ENABLE,
  RESET => T20_RESET,
  TC => T20C      
);
TIMER1: TIMER generic map (TARGET=> 1) port map(
  CLK_1M => CLK_1M,
  ENABLE => T1_ENABLE,
  RESET => T1_RESET,
  TC => T1C      
);
LOCK: DOOR_LOCK_SYSTEM port map(
  CLK => CLK,
  ENABLE => LOCK_ENABLE,
  LED => DOOR_LOCK_LED
);
SET: SETTINGS port map(
  CLK=>CLK,
  MODE=>MODE,
  AUTO_SEL=>auto_sel,
  TEMP_SEL=>temp_sel,
  SPEED_SEL=>speed_sel,
  PREWASH_SEL=>prewash_sel,
  EXTRA_RINSE_SEL=>extra_rinse_sel,
  TEMP=>TEMP,
  SPEED=>SPEED, 
  PREWASH=>PREWASH,
  RINSE => RINSE
);
C_SPEED: COUNTER generic map(MAX=>2)port map(
        CLK => CLK,
        PULSE => SPEED_INC,
        COUNT => speed_sel
);
C_TEMP: COUNTER  generic map(MAX=>3) port map(
        CLK => CLK, 
        PULSE => TEMP_INC,
        COUNT => temp_sel
);
C_PREWASH: COUNTER  generic map(MAX=>1) port map(
        CLK => CLK,
        PULSE => PREWASH_TOGGLE,
        COUNT => prewash_sel
);
C_RINSE: COUNTER  generic map(MAX=>1) port map(
        CLK => CLK,
        PULSE => EXTRA_RINSE_TOGGLE,
        COUNT => extra_rinse_sel
);
C_AUTO: COUNTER generic map(MAX=>4) port map(
        CLK => CLK,
        PULSE => AUTO_INC,
        COUNT => auto_sel
);
TIME_CALC: TIME_CALCULATOR port map(
           CLK => CLK,
           ENABLE => CALCULATOR_ENABLE,
           MODE => MODE,
           AUTO => auto_sel,
           TEMP => TEMP,
           PREWASH => prewash_sel,
           EXTRA_RINSE => extra_rinse_sel,
           MINS => mins,
           SECS => secs
);
TIMER_FINAL: FINAL_TIMER port map(
        CLK => CLK,
        CLK_1S => CLK_1S,
        ENABLE => TFINAL_ENABLE,
        MINUTES_IN => mins,
        SECONDS_IN => secs,
        RESET => TFINAL_RESET,
        digit0 => digit0,
        digit1 => digit1,
        digit2 => digit2,
        digit3 => digit3,
        TC => TFINALC
);
SEVEN_SEGMENT: SSD port map(
        CLK => CLK_DISPLAY,
        digit0 => digit0,
        digit1 => digit1,
        digit2 => digit2,
        digit3 => digit3,
        SEGMENTS => CAT,
        AN => AN
);
PUMP: WATER_CONTROL port map(
           CLK => CLK,
           CLK_1S => CLK_1M,
           PUMP_START => PUMP_START,
           EVAC_START => EVAC_START,
           PUMP_LED => WATER_PUMP_LED,
           EVAC_LED => WATER_EVAC_LED
           );
CURR_SPEED <= SPEED;
CURR_TEMP <= TEMP;
CURR_PREWASH <= PREWASH;
CURR_RINSE <= RINSE;

end Behavioral;
