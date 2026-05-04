----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2025 12:46:52 PM
-- Design Name: 
-- Module Name: state_pack - Behavioral
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

package state_pack is
type STATE_TYPE is (inactive,manual_mode,auto_mode,calc_time,wait_start,water_heating,prewashing,washing,rinsing,extra_rinsing,centrifugation,finishing);
end package;