----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 03:18:17 PM
-- Design Name: 
-- Module Name: CLOCK_DIVIDER - Behavioral
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

entity CLOCK_DIVIDER is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK_2S : out STD_LOGIC;
           CLK_1M : out STD_LOGIC;
           CLK_1S : out STD_LOGIC;
           CLK_DISPLAY : out STD_LOGIC);
end CLOCK_DIVIDER;

architecture Behavioral of CLOCK_DIVIDER is
  constant FREQ : integer := 100_000_000;
  --constant FREQ : integer := 2;
  constant TICK_2S: integer := (2 * FREQ)/60;
  constant TICK_1M: integer := FREQ;
  constant TICK_1S: integer := FREQ/60;
  constant TICK_DISPLAY: integer := 100_000;

  
--  constant TICK_2S: integer := 1;
--  constant TICK_1M: integer := 1;
--  constant TICK_1S: integer := 1;
  
  signal counter_2s: unsigned(23 downto 0) := (others=> '0');
  signal counter_1m: unsigned(26 downto 0) := (others=> '0');
  signal counter_1s: unsigned(20 downto 0) := (others=> '0');
  signal counter_display: unsigned(35 downto 0) := (others=> '0');
  signal clk_2s_pulse: std_logic :='0'; 
  signal clk_1m_pulse: std_logic :='0'; 
  signal clk_1s_pulse: std_logic :='0'; 
  signal clk_display_pulse: std_logic :='0'; 
begin
    process (CLK,RESET)
    begin
        if RESET = '1' then
         counter_2s <= (others=>'0');
         counter_1m <= (others=>'0');
         counter_1s <= (others=>'0');
         counter_display <= (others=>'0');
         clk_2s_pulse <='0';
         clk_1m_pulse <='0';
         clk_1s_pulse <='0';
         clk_display_pulse <='0';
         else if rising_edge(CLK) then
         --
             if counter_2s = TICK_2S - 1 then
             counter_2s <= (others=>'0');
             clk_2s_pulse <='1';
             else
             counter_2s <= counter_2s +1;
            clk_2s_pulse <='0';
             end if;
         --
             if counter_1m = TICK_1M - 1 then
             counter_1m <= (others=>'0');
             clk_1m_pulse <='1';
             else
             counter_1m <= counter_1m +1;
             clk_1m_pulse <='0';
             end if;
         --
             if counter_1s = TICK_1S - 1 then
             counter_1s <= (others=>'0');
             clk_1s_pulse <='1';
             else
             counter_1s <= counter_1s +1;
             clk_1s_pulse <='0';
             end if;
         --
             if counter_display = TICK_display - 1 then
             counter_display <= (others=>'0');
             clk_display_pulse <='1';
             else
             counter_display <= counter_display +1;
             clk_display_pulse <='0';
             end if;
         end if; end if;
         
    end process;
    
    CLK_2S<= clk_2s_pulse;
    CLK_1M<= clk_1m_pulse;
    CLK_1S<= clk_1s_pulse;
    CLK_DISPLAY<= clk_display_pulse;
end Behavioral;
