library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity MAIN is
    port(pin: in STD_LOGIC_VECTOR (3 downto 0);
         optiune: in STD_LOGIC_VECTOR (1 downto 0);
         suma: in STD_LOGIC_VECTOR (9 downto 0);
         chitanta: in STD_LOGIC;
         button:in std_logic;
         catod:out std_logic_vector(7 downto 0);
         clk, rst: in STD_LOGIC;
         banc500:out std_logic_vector(3 downto 0);
         banc200:out std_logic_vector(3 downto 0);
         banc100:out std_logic_vector(3 downto 0);
         banc50:out std_logic_vector(3 downto 0);
         AN:out std_logic_vector(7 downto 0));
end MAIN;

architecture MAIN of MAIN is 

signal eliberare_chitanta, afisare_sold, schimba_pin,enable_verificare_suma, enable_verificare_pin, pin_validare, CS_PINURI, CS_BANCNOTE, CS_SUME, ED, ER,we5,we10,we20,we50,we100,we200,we500: STD_LOGIC;

signal verificat_pin, existenta_suma, existenta_bancomat,buttonf: STD_LOGIC;
    
signal loc_pin: STD_LOGIC_VECTOR (1 downto 0);    

signal A_RAM_PIN, A_RAM_SUME: STD_LOGIC_VECTOR (1 downto 0);

signal A_RAM_BANC: STD_LOGIC_VECTOR (2 downto 0);

signal  D_RAM_SUME: STD_LOGIC_VECTOR (9 downto 0);
signal D_RAM_PINURI: std_logic_vector(3 downto 0);
signal D_RAM_BANCNOTE: STD_LOGIC_VECTOR (11 downto 0);

signal numar_bancnote: STD_LOGIC_VECTOR(3 downto 0);

signal sel: integer range 0 to 4;

signal suma_fin_dep, suma_fin_ret, suma_interogare_cont: STD_LOGIC_VECTOR (9 downto 0);

component MPG 
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : out STD_LOGIC);
end component;

component MEM_RAM_PIN
      Port ( A_RAM : in STD_LOGIC_VECTOR (1 downto 0);
           CS_RAM : in STD_LOGIC;
           WE : in STD_LOGIC;
           D_RAM : inout STD_LOGIC_vector(3 downto 0);
           schimba_pin : in STD_LOGIC;
           pin_nou : in STD_LOGIC_VECTOR (3 downto 0);
           loc_pin : in STD_LOGIC_VECTOR (1 downto 0));
end component;

component MEM_RAM_SUMA
    port (A_RAM: in STD_LOGIC_VECTOR(1 downto 0);
		CS_RAM: in STD_LOGIC;
		WE: in STD_LOGIC; 
		D_RAM: inout STD_LOGIC_VECTOR(9 downto 0);
		loc_pin: in STD_LOGIC_VECTOR(1 downto 0);
		final_depunere,final_retragere: in STD_LOGIC_VECTOR(9 downto 0);
		ER, ED: in STD_LOGIC);
end component;    

component ORGANIGRAMA 
port (clk, rst: in STD_LOGIC;
        button: in std_logic;
		verificat_pin, existenta_suma, chitanta, existenta_bancomat: in STD_LOGIC;
		alegere_optiune: in STD_LOGIC_VECTOR(1 downto 0);
		sel : out integer range 0 to 4; 
		eliberare_chitanta, afisare_sold, schimba_pin, enable_verificare_suma, enable_verificare_pin, CS_PINURI, CS_BANCNOTE, CS_SUME, ED, ER,we5,we10,we20,we50,we100,we200,we500: out STD_LOGIC);
   end component;    

component ADAUGARE_BANI 
     port (suma_depunere: in STD_LOGIC_VECTOR (9 downto 0);
	loc_pin: in STD_LOGIC_VECTOR (1 downto 0);
	suma_finala_cont_curent: out STD_LOGIC_VECTOR (9 downto 0));
end component;

component SCADERE_BANI 
     port (suma_retragere: in STD_LOGIC_VECTOR (9 downto 0);
	loc_pin: in STD_LOGIC_VECTOR (1 downto 0);
	suma_finala_cont_curent: out STD_LOGIC_VECTOR (9 downto 0));
end component;

component INTEROGARE_SOLD
    port (loc_pin: in STD_LOGIC_VECTOR (1 downto 0);
	afisare_sold: in STD_LOGIC;
	sold: out STD_LOGIC_VECTOR (9 downto 0));
end component;

component AFISARE_SOLD_CONT
    Port (clk: in std_logic;
          d_in: in std_logic_vector(9 downto 0);
          seg: out std_logic_vector(7 downto 0);
          an: out std_logic_vector(7 downto 0));
end component;

component verificare_suma_cont
   port(loc_pin: in STD_LOGIC_VECTOR  (1 downto 0);
	suma_retragere: in STD_LOGIC_VECTOR (9 downto 0);
	enable_verificare_suma: in STD_LOGIC;
	existenta_suma: out STD_LOGIC);
end component;

component VALIDARE_PIN 
    Port ( pin : in STD_LOGIC_VECTOR (3 downto 0);
           poz_pin : out STD_LOGIC_VECTOR (1 downto 0);
           enable_verificare_pin : in STD_LOGIC;
           verificat_pin : out STD_LOGIC);
end component;

component MEM_RAM_BANC
    port (clk:in std_logic;
            A_RAM: in STD_LOGIC_VECTOR(2 downto 0);
            CS_RAM: in STD_LOGIC;
            WE5: in STD_LOGIC;
            WE10: in STD_LOGIC;
            WE20: in STD_LOGIC;
            WE50: in STD_LOGIC;
            WE100: in STD_LOGIC;
            WE200: in STD_LOGIC;
            WE500: in STD_LOGIC;
            D_RAM: inout STD_LOGIC_VECTOR(11 downto 0);
            numar_bancnote: in STD_LOGIC_VECTOR(3 downto 0);
            suma: in STD_LOGIC_VECTOR (9 downto 0);
            existenta_bancomat: out STD_LOGIC;
            en_verificare: in STD_LOGIC;
            ED: STD_LOGIC;
            banc500:out std_logic_vector(3 downto 0);
            banc200:out std_logic_vector(3 downto 0);
            banc100:out std_logic_vector(3 downto 0);
            banc50:out std_logic_vector(3 downto 0));
end component;
component MUX
    Port (sel:in integer range 0 to 4;
          D0,D1,D2,D3,D4:in std_logic_vector(7 downto 0);
          Q:out std_logic_vector(7 downto 0));
end component;

begin
numar_bancnote<=pin;
f1: MPG port map(button,clk,buttonf);
MAPARE_ORGANIGRAMA: ORGANIGRAMA port map (clk, rst,button, verificat_pin, existenta_suma, chitanta, existenta_bancomat, optiune,sel, eliberare_chitanta,afisare_sold, schimba_pin, enable_verificare_suma, enable_verificare_pin, CS_PINURI, CS_BANCNOTE, CS_SUME, ED, ER,we5,we10,we20,we50,we100,we200,we500); 

C1: VALIDARE_PIN port map (pin, loc_pin, enable_verificare_pin, verificat_pin);

C2: MEM_RAM_PIN port map (A_RAM_PIN, CS_PINURI, '0', D_RAM_PINURI, schimba_pin, pin, loc_pin);

C3: MEM_RAM_SUMA port map (A_RAM_SUME, CS_SUME, '0', D_RAM_SUME, loc_pin,  suma_fin_dep, suma_fin_ret,ER, ED);    

C4: MEM_RAM_BANC port map (clk,A_RAM_BANC, CS_BANCNOTE, we5,we10,we20,we50,we100,we200,we500,D_RAM_BANCNOTE, numar_bancnote, suma,existenta_bancomat,enable_verificare_suma, ED, banc500, banc200, banc100, banc50);

C5: verificare_suma_cont port map (loc_pin, suma, enable_verificare_suma, existenta_suma);

C6: INTEROGARE_SOLD port map (loc_pin, afisare_sold, suma_interogare_cont);

c7: AFISARE_SOLD_CONT port map (clk, suma_interogare_cont, catod, an);

C8: ADAUGARE_BANI port map (suma, loc_pin, suma_fin_dep);

C9: SCADERE_BANI port map (suma, loc_pin,suma_fin_ret );

--: MUX port map(sel,"11000000","11111001","10100100","10110000","10011001",catod);
end MAIN;