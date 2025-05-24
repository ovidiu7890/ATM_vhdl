


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity verificare_suma_cont is 
	port(loc_pin: in STD_LOGIC_VECTOR  (1 downto 0);
	suma_retragere: in STD_LOGIC_VECTOR (9 downto 0);
	enable_verificare_suma: in STD_LOGIC;
	existenta_suma: out STD_LOGIC);
end verificare_suma_cont;

architecture verificare_suma_cont of verificare_suma_cont is

component MEM_RAM_SUMA
	port (A_RAM: in STD_LOGIC_VECTOR(1 downto 0);
		CS_RAM: in STD_LOGIC;
		WE: in STD_LOGIC; 
		D_RAM: inout STD_LOGIC_VECTOR(9 downto 0);
		loc_pin: in STD_LOGIC_VECTOR(1 downto 0);
		final_depunere,final_retragere: in STD_LOGIC_VECTOR(9 downto 0);
		ER, ED: in STD_LOGIC);
end component; 

signal suma_cont_curent , suma_depunere_semnal, suma_retragere_semnal: STD_LOGIC_VECTOR(9 downto 0); 
signal poz_pin_semnal: STD_LOGIC_VECTOR(1 downto 0);
begin	
	
	SUMA_DIN_CONT: MEM_RAM_SUMA port map(loc_pin, '1', '0', suma_cont_curent, poz_pin_semnal, suma_depunere_semnal, suma_retragere_semnal, '0', '0');
	
	VERIFICARE_SUMA_EXISTENTA_CONT: process(suma_retragere, suma_cont_curent,enable_verificare_suma)
	begin
		if enable_verificare_suma = '1' then 
			if  suma_cont_curent >= suma_retragere then
				existenta_suma <= '1';
			else
				existenta_suma <= '0';
			end if;
		end if;
	end process; 

end verificare_suma_cont;
