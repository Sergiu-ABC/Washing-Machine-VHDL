----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 01:22:29 PM
-- Design Name: 
-- Module Name: COUNTER - Behavioral
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

entity COUNTER is
  Generic(
    MAX : integer :=1
  );
  Port (
        CLK: in std_logic;
        PULSE : in std_logic;
        COUNT : out integer
   );
end COUNTER;

architecture Behavioral of COUNTER is
signal counter : integer := 0;
begin
    process(CLK)
    begin
    if rising_edge(CLK) then
        if PULSE = '1' then
            if counter = MAX then
            counter <= 0;
            else
            counter <= counter + 1;
            end if;
        end if;
    end if;
    end process;
    COUNT <= counter;
end Behavioral;
