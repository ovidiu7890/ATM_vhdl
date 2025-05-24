
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/10/2024 10:17:06 AM
-- Design Name: 
-- Module Name: DMUX8x1 - Behavioral
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

entity MUX is
    Port (sel:in integer range 0 to 4;
          D0,D1,D2,D3,D4:in std_logic_vector(7 downto 0);
          Q:out std_logic_vector(7 downto 0));
end MUX;

architecture MUX of MUX is

begin
with sel select
    Q<=D0 when 0,
       D1 when 1,
       D2 when 2,
       D3 when 3,
       D4 when 4,
       x"FF" when others;
end MUX;

