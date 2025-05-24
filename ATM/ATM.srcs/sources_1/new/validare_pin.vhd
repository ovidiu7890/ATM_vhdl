----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2024 09:50:53 PM
-- Design Name: 
-- Module Name: validare_pin - validare
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

entity validare_pin is
    Port ( pin : in STD_LOGIC_VECTOR (3 downto 0);
           poz_pin : out STD_LOGIC_VECTOR (1 downto 0);
           enable_verificare_pin : in STD_LOGIC;
           verificat_pin : out STD_LOGIC);
end validare_pin;

architecture validare of validare_pin is
component  MEM_RAM_PIN 
    Port ( A_RAM : in STD_LOGIC_VECTOR (1 downto 0);
           CS_RAM : in STD_LOGIC;
           WE : in STD_LOGIC;
           D_RAM : inout STD_LOGIC_vector(3 downto 0);
           schimba_pin : in STD_LOGIC;
           pin_nou : in STD_LOGIC_VECTOR (3 downto 0);
           loc_pin : in STD_LOGIC_VECTOR (1 downto 0));
end component ;
signal pin0,pin1,pin2,pin3:std_logic_vector(3 downto 0);
signal pozitie:std_logic_vector(1 downto 0);
signal semnal_pin :std_logic_vector(3 downto 0);
begin
   P0 : MEM_RAM_PIN port map("00",'1','0',pin0,'0',semnal_pin,pozitie);
   P1 : MEM_RAM_PIN port map("01",'1','0',pin1,'0',semnal_pin,pozitie);
   P2 : MEM_RAM_PIN port map("10",'1','0',pin2,'0',semnal_pin,pozitie);
   P3 : MEM_RAM_PIN port map("11",'1','0',pin3,'0',semnal_pin,pozitie);
   
   VERIFICARE_PIN: process(pin0,pin1,pin2,pin3,pin,enable_verificare_pin)
   begin 
        if enable_verificare_pin ='1' then
            if pin=pin0 then 
                verificat_pin<='1';
                poz_pin<="00";
            elsif pin=pin1 then 
                verificat_pin<='1';
                poz_pin<="01";
            elsif pin=pin2 then 
                verificat_pin<='1';
                poz_pin<="10";
            elsif pin=pin3 then 
                verificat_pin<='1';
                poz_pin<="11";
            end if;
         else 
         verificat_pin<='0';   
         end if;    
        
   
   end process;
end validare;
