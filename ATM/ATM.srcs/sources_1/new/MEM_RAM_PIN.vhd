----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2024 07:25:50 PM
-- Design Name: 
-- Module Name: MEM_RAM_PIN - Behavioral
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
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_RAM_PIN is
    Port ( A_RAM : in STD_LOGIC_VECTOR (1 downto 0);
           CS_RAM : in STD_LOGIC;
           WE : in STD_LOGIC;
           D_RAM : inout STD_LOGIC_vector(3 downto 0);
           schimba_pin : in STD_LOGIC;
           pin_nou : in STD_LOGIC_VECTOR (3 downto 0);
           loc_pin : in STD_LOGIC_VECTOR (1 downto 0));
end MEM_RAM_PIN;

architecture MEM_RAM_PIN of MEM_RAM_PIN is
type RAM_TYPE is array(0 to 3) of STD_LOGIC_VECTOR (3 downto 0);
signal RAM: RAM_TYPE := (0 => "1111", 	
                         1 => "1110", 
                         2 => "0001", 
                         3 => "0111"); 
                         

signal p_nou: std_logic_vector(3 downto 0);
begin
    process  (schimba_pin, loc_pin, p_nou, pin_nou)
    begin   
            if schimba_pin ='1' then 
                 p_nou <= pin_nou;
			     RAM(conv_integer(loc_pin)) <= p_nou;
            end if;
    end process;
    
   D_RAM <= RAM(conv_integer(A_RAM)) when (CS_RAM = '1' and WE = '0');
   
end MEM_RAM_PIN;
