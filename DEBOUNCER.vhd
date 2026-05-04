----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 03:13:59 PM
-- Design Name: 
-- Module Name: DEBOUNCER - Behavioral
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

entity DEBOUNCER is
    Port(
    CLK: in std_logic;
    BTN: in std_logic;
    EDGE: out std_logic);
end DEBOUNCER;

architecture Behavioral of DEBOUNCER is
signal last: std_logic:='0';

begin
    process(CLK)
    
    begin
    if rising_edge(CLK) then
    if BTN='1' and last ='0' then
        EDGE<='1';
    else
        EDGE<='0';
    end if;
    
    last <= BTN;
    end if;
    end process;    

end Behavioral;
