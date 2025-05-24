

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity INTEROGARE_SOLD is
	port (loc_pin: in STD_LOGIC_VECTOR (1 downto 0);
	afisare_sold: in STD_LOGIC;
	sold: out STD_LOGIC_VECTOR (9 downto 0));
end INTEROGARE_SOLD;


architecture INTEROGARE_SOLD of INTEROGARE_SOLD is	

component MEM_RAM_SUMA
	        port (A_RAM: in STD_LOGIC_VECTOR(1 downto 0);
                CS_RAM: in STD_LOGIC;
                WE: in STD_LOGIC; 
                D_RAM: inout STD_LOGIC_VECTOR(9 downto 0);
                loc_pin: in STD_LOGIC_VECTOR(1 downto 0);
                final_depunere,final_retragere: in STD_LOGIC_VECTOR(9 downto 0);
                ER, ED: in STD_LOGIC);
end component;

signal suma_cont, suma_depunere_semnal, suma_retragere_semnal: STD_LOGIC_VECTOR (9 downto 0);
signal loc_pin_semnal: STD_LOGIC_VECTOR (1 downto 0);


begin

	SUMA_CONT_CURENT: MEM_RAM_SUMA port map (loc_pin, '1', '0', suma_cont, loc_pin_semnal, suma_depunere_semnal, suma_retragere_semnal, '0', '0');
	
	AFISARE_SOLD_CONT_CURENT: process (suma_cont, afisare_sold)
	begin
		if afisare_sold = '1' then 
			sold <= suma_cont; 
		end if;
	end process;
	

end INTEROGARE_SOLD;