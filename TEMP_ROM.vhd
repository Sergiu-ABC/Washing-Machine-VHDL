----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 11:36:24 AM
-- Design Name: 
-- Module Name: TEMP_ROM - Behavioral
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

entity TEMP_ROM is
    Port (  CLK : in std_logic;
            ADR: in integer;
            DATA: out std_logic_vector(2 downto 0)
     );
end TEMP_ROM;

architecture Behavioral of TEMP_ROM is
type ROM_TYPE is array(3 downto 0) of std_logic_vector(2 downto 0);
constant ROM: ROM_TYPE:=(
                            0=> "001", --30,
                            1=> "010",--40,
                            2=> "011",--60,
                            3=> "100",--90,
                            others=>"000"               
                         );
begin

process (CLK)
begin
if rising_edge(CLK) then
DATA <= ROM(ADR);
end if;
end process;

end Behavioral;
