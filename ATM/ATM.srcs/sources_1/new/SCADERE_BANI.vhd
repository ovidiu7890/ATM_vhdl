library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SCADERE_BANI is
    port (suma_retragere: in STD_LOGIC_VECTOR (9 downto 0);
	loc_pin: in STD_LOGIC_VECTOR (1 downto 0);
	suma_finala_cont_curent: out STD_LOGIC_VECTOR (9 downto 0));
end SCADERE_BANI;

architecture SCADERE_BANI of SCADERE_BANI is
    component MEM_RAM_SUMA
        port (A_RAM: in STD_LOGIC_VECTOR(1 downto 0);
                CS_RAM: in STD_LOGIC;
                WE: in STD_LOGIC; 
                D_RAM: inout STD_LOGIC_VECTOR(9 downto 0);
                loc_pin: in STD_LOGIC_VECTOR(1 downto 0);
                final_depunere,final_retragere: in STD_LOGIC_VECTOR(9 downto 0);
                ER, ED: in STD_LOGIC);
    end component;
    component scazator_16B
        Port ( A, B:in std_logic_vector(9 downto 0) ;
           Cin:in std_logic ;
           S:out std_logic_vector (9 downto 0);
           Cout:out std_logic);
    end component;
    signal suma_cont: std_logic_vector (9 downto 0);
    signal final_depunere_semnal,final_retragere_semnal:  STD_LOGIC_VECTOR(9 downto 0);
    signal loc_pin_semnal: std_logic_vector(1 downto 0);
    signal cout_semnal: std_logic;
begin
    return_suma_cont: MEM_RAM_SUMA port map (loc_pin,'1','0',suma_cont,loc_pin_semnal,final_depunere_semnal,final_retragere_semnal,'0','0');
    scadere: scazator_16B port map(suma_cont,suma_retragere,'0',suma_finala_cont_curent,cout_semnal);
end SCADERE_BANI;