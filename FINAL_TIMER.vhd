----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 09:25:38 PM
-- Design Name: 
-- Module Name: FINAL_TIMER - Behavioral
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

entity FINAL_TIMER is
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
end FINAL_TIMER;

architecture Behavioral of FINAL_TIMER is
signal minutes: integer := 0;
signal seconds: integer := 0;

begin
    process (CLK_1S,CLK,RESET,MINUTES_IN,SECONDS_IN)
    
    begin
        if RESET = '1' then
            minutes <= MINUTES_IN;
            seconds <= SECONDS_IN;
            end if;
        if rising_edge(CLK_1S) then
            if minutes = 0 and seconds = 0 then
            TC <= '1';
            else TC <='0';
            end if;
            
            if ENABLE = '1' then
            if minutes > 0 or seconds > 0 then
            
            if seconds = 0 then
            seconds<=59;
            minutes<= minutes-1;
            else
            seconds<=seconds-1;
            end if;
            
            end if;
            end if;
        end if;
            if rising_edge(CLK) then
            digit0 <= std_logic_vector(to_unsigned(seconds mod 10, 4));
            digit1 <= std_logic_vector(to_unsigned(seconds / 10, 4));
            digit2 <= std_logic_vector(to_unsigned(minutes mod 10, 4));
            digit3 <= std_logic_vector(to_unsigned(minutes / 10, 4));
            end if;
    end process;
    
end Behavioral;
