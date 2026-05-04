----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 02:30:08 PM
-- Design Name: 
-- Module Name: TIMER - Behavioral
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

entity TIMER is
  Generic(TARGET: integer := 10);
    Port( CLK_1M: in std_logic;
          ENABLE: in std_logic;
          RESET: in std_logic;
          TC: out std_logic
    );
end TIMER;

architecture Behavioral of TIMER is
signal count: integer := 0;
begin

process(CLK_1M,RESET)
begin
if RESET = '1' then
    count<=0;
    TC<='0';
else
if rising_edge(CLK_1M) then
        if ENABLE = '1' then
            if count<TARGET-1 then
            count <= count + 1;
            TC <='0';
            else
            TC <= '1';
            end if;
        end if;
    end if;
end if;
end process;

end Behavioral;
