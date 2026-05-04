----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 11:37:36 AM
-- Design Name: 
-- Module Name: AUTO_ROM - Behavioral
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

entity AUTO_ROM is
    Port (  CLK : in std_logic;
            ADR: in integer;
            DATA: out std_logic_vector(7 downto 0)
     );
end AUTO_ROM;

architecture Behavioral of AUTO_ROM is

type ROM_TYPE is array(4 downto 0) of std_logic_vector(7 downto 0);
-- speed 2 temp 2 prewash 1 extra_rinse 1
--speed:
--00 - 800
--01 - 1000
--10 - 1200

--temp:
--00 - 30
--01 - 40
--10 - 60
--11 - 90
constant ROM: ROM_TYPE:= (
                            0=> "01100100", -- 30,1200,0,0
                            1=> "00101100", -- 60,800,0,0
                            2=> "01001001", -- 40,1000,0,1
                            3=> "00101010", -- 40,1000,1,0
                            4=> "01110001", -- 90,1200,0,1
                            others=> "0000000"               
                         );
begin

process (CLK)
begin
if rising_edge(CLK) then
DATA <= ROM(ADR);
end if;
end process;
end Behavioral;
