----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 08:29:53 PM
-- Design Name: 
-- Module Name: TIME_CALCULATOR - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TIME_CALCULATOR is
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
end TIME_CALCULATOR;

architecture Behavioral of TIME_CALCULATOR is

type INTEGER_PAIR is array(1 downto 0) of integer;
type AUTO_TYPE is array(4 downto 0) of INTEGER_PAIR;
constant auto_times: AUTO_TYPE :=(
    0 => (0 => 41, 1 => 30),
    1 => (0 => 42, 1 => 30),
    2 => (0 => 51, 1 => 50),
    3 => (0 => 51, 1 => 50),
    4 => (0 => 53, 1 => 30)
);
signal m: integer:=0;
signal s: integer:=0;
signal temp_int: integer:=0;
begin
process(TEMP)
begin
case TEMP is
    when "001" => temp_int<=30;
    when "010" => temp_int<=40;
    when "011" => temp_int<=60;
    when "100" => temp_int<=90;
    when others => temp_int<=30;
    end case;
end process;
process (CLK)
    variable total_seconds: integer;
begin
                if rising_edge(CLK) then
                if ENABLE = '1' then
                if MODE = '1' then
                    -- AUTO mode
                    m <= auto_times(AUTO)(0);
                    s <= auto_times(AUTO)(1);
                else
                    -- MANUAL mode
                    total_seconds := 2460 + (temp_int - 15) * 2;
                    if PREWASH = 1 then
                        total_seconds := total_seconds + 600;
                    end if;
                    if EXTRA_RINSE = 1 then
                        total_seconds := total_seconds + 600;
                    end if;

                    m <= total_seconds / 60;
                    s <= total_seconds mod 60;
                end if;
                end if;
                end if;
end process;

 MINS <= m;
 SECS <= s;
end Behavioral;
