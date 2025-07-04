----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2024 05:53:47 PM
-- Design Name: 
-- Module Name: sumator_1Bit - Behavioral
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

entity sumator_1Bit is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           CIN : in STD_LOGIC;
           S : out STD_LOGIC;
           COUT : out STD_LOGIC);
end sumator_1Bit;

architecture Behavioral of sumator_1Bit is
signal sn: std_logic;
signal cout1: std_logic;
begin
   s<=cin xor (a xor b);
   cout<=((a xor b)nand cin )nand (a nand b);
--s<=sn;
--cout<=cout1;
end Behavioral;
