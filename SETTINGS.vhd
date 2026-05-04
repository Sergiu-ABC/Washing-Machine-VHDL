----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 01:33:28 PM
-- Design Name: 
-- Module Name: SETTINGS - Behavioral
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

entity SETTINGS is
  Port (
  CLK: in std_logic;
  MODE: in std_logic;
  AUTO_SEL: in integer;
  TEMP_SEL: in integer;
  SPEED_SEL: in integer;
  PREWASH_SEL: in integer;
  EXTRA_RINSE_SEL: in integer;
  TEMP : out std_logic_vector(2 downto 0);
  SPEED : out std_logic_vector(2 downto 0);
  PREWASH,RINSE: out std_logic
   );
end SETTINGS;

architecture Behavioral of SETTINGS is
component SPEED_ROM is
    Port (  CLK : in std_logic;
            ADR: in integer;
            DATA: out std_logic_vector(1 downto 0)
     );
end component;

component TEMP_ROM is
    Port (  CLK : in std_logic;
            ADR: in integer;
            DATA: out std_logic_vector(2 downto 0)
     );
end component;

component AUTO_ROM is
    Port (  CLK : in std_logic;
            ADR: in integer;
            DATA: out std_logic_vector(7 downto 0) 
     );
end component;

signal SPEED_OUT,TEMP_OUT: std_logic_vector(2 downto 0):="000";
signal AUTO_OUT: std_logic_vector(7 downto 0):=(others=>'0');

begin
ROM1: SPEED_ROM port map(
            CLK =>CLK,
            ADR =>SPEED_SEL,
            DATA=>SPEED_OUT(1 downto 0)
);
ROM2: TEMP_ROM port map(
            CLK =>CLK,
            ADR =>TEMP_SEL,
            DATA=>TEMP_OUT
);
ROM3: AUTO_ROM port map(
            CLK =>CLK,
            ADR =>AUTO_SEL,
            DATA=>AUTO_OUT
);

    process (CLK)
    begin
    if rising_edge(CLK) then
    if MODE = '0' then
    
    SPEED <= SPEED_OUT;
    TEMP <= TEMP_OUT;
    
    if PREWASH_SEL = 1 then
    PREWASH <= '1';
    else PREWASH <= '0';
    end if;
    if EXTRA_RINSE_SEL = 1 then
    RINSE <= '1';
    else RINSE <= '0';
    end if;
    else
    
    SPEED<= AUTO_OUT(7 downto 5);
    TEMP <= AUTO_OUT(4 downto 2);
    PREWASH<= AUTO_OUT(1);
    RINSE<= AUTO_OUT(0);
    
    end if;   
    end if;
    end process;

end Behavioral;
