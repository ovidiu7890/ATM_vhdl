library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity MEM_RAM_SUMA is
    port (A_RAM: in STD_LOGIC_VECTOR(1 downto 0);
		CS_RAM: in STD_LOGIC;
		WE: in STD_LOGIC; 
		D_RAM: inout STD_LOGIC_VECTOR(9 downto 0);
		loc_pin: in STD_LOGIC_VECTOR(1 downto 0);
		final_depunere,final_retragere: in STD_LOGIC_VECTOR(9 downto 0);
		ER, ED: in STD_LOGIC);
end MEM_RAM_SUMA;

architecture MEM_RAM_SUMA of MEM_RAM_SUMA is

type RAM_TYPE is array (0 to 3) of STD_LOGIC_VECTOR(9 downto 0);
signal RAM: RAM_TYPE := (0 => "1111101000",  --1000
1 => "1111101000",   --1000
2 => "0110010000",   --400
3 => "1100100000");  --800

begin
    actualizare_suma: process(ER,ED,final_depunere,final_retragere)
    begin 
     if ED ='1' then 
        RAM(conv_integer(loc_pin))<=final_depunere;
     end if;
     if ER='1' then 
        RAM(conv_integer(loc_pin))<=final_retragere;
     end if;
     
    end process;
    D_RAM<=RAM(conv_integer(loc_pin))when (CS_RAM = '1' and WE =  '0');

end MEM_RAM_SUMA;
