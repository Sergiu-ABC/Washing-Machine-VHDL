library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DOOR_LOCK_SYSTEM is
    Port ( CLK : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           LED : out STD_LOGIC);
end DOOR_LOCK_SYSTEM;

architecture Behavioral of DOOR_LOCK_SYSTEM is

begin

process (CLK)

begin
if rising_edge(CLK) then
LED<=ENABLE;
end if;
end process;

end Behavioral;
