library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity MEM_RAM_BANC is
    port (clk  :in std_logic; 
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
end MEM_RAM_BANC;

architecture MEM_RAM_BANC of MEM_RAM_BANC is
    type RAM_TYPE is array (0 to 7) of STD_LOGIC_VECTOR (11 downto 0);
    signal RAM, RAM_AUX,RAM_AUX1: RAM_TYPE := (0 => "000000000000",  
    7 => "000000000000", --0
    others => "000000000000"); --tr sa le dau 0 la toate
   
    type SUME is array (0 to 6) of STD_LOGIC_VECTOR (9 downto 0);
signal val_banc1: SUME := ( 0 =>	"0000000101", --5
1 => "0000001010", --10
2 => "0000010100", --20
3 => "0000110010", --50
4 => "0001100100", --100
5 => "0011001000", --200
6 => "0111110100");--500
type sir is array (0 to 6) of STD_LOGIC_VECTOR (11 downto 0);
    type sir2 is array (0 to 6) of STD_LOGIC_VECTOR (9 downto 0);

    signal suma_r, rest: STD_LOGIC_VECTOR(9 downto 0):=(others=> '0');
    signal suma_rd, restd: STD_LOGIC_VECTOR(9 downto 0):=(others=> '0');
    signal nr_banc: RAM_TYPE;
    signal val_banc: sir2;
    signal nr_banc_ramase: STD_LOGIC_VECTOR(11 downto 0);
    signal count: STD_LOGIC_VECTOR(11 downto 0);
    signal i: integer := 6;
    signal i1: integer := 6;
    signal state: STD_LOGIC := '0';
    signal state1: STD_LOGIC := '0';
    signal verif:std_logic_vector(11 downto 0);
    signal we:std_logic:='0';
    signal we_depunere:std_logic:='0';
    signal we_retragere:std_logic:='0';
   
begin



    process(clk,ED)
        variable nr_banc_ramase1: STD_LOGIC_VECTOR(11 downto 0);
    variable  rest1: STD_LOGIC_VECTOR(9 downto 0):=(others=> '0');
    begin
    if rising_edge(clk) then
        if ED = '0' then
            suma_rd<=suma;
            state1<='1';
            i1<=6;
            count<="000000000000";
        elsif ED='1' and state1='1' then 
             if (suma_rd > "0000000000") and (i1 >= 0) then
                if suma_rd >= val_banc1(i1)  then
                    rest1:=std_logic_vector(unsigned(suma_rd)-unsigned(val_banc1(i1)));
                    restd <= rest1;
                    suma_rd <= rest1 ;
                    count<=count+1;
                else
                    RAM_AUX1(i1)<=count;
                    i1 <= i1 - 1;
                    count<="000000000000";
                end if;
            elsif suma_rd="0000000000000000"   then  
                RAM_AUX1(i1)<=count;
                we_depunere<='1';
            end if;
        end if;
     end if;
    end process;
    
    
    
    
    process (clk,en_verificare)
    variable nr_banc_ramase1: STD_LOGIC_VECTOR(11 downto 0);
    variable suma_r1, rest1: STD_LOGIC_VECTOR(9 downto 0):=(others=> '0');
begin
    if rising_edge(clk) then
        if en_verificare = '0' then
            suma_r <= suma;
            we<='0';
            we_retragere<='0';
            nr_banc(0) <= RAM(0);
            nr_banc(1) <= RAM(1);
            nr_banc(2) <= RAM(2);
            nr_banc(3) <= RAM(3);
            nr_banc(4) <= RAM(4);
            nr_banc(5) <= RAM(5);
            nr_banc(6) <= RAM(6);
            nr_banc(7)<=RAM(7);

            val_banc(0) <= "0000000101";  -- 5
            val_banc(1) <= "0000001010";  -- 10
            val_banc(2) <= "0000010100";  -- 20
            val_banc(3) <= "0000110010";  -- 50
            val_banc(4) <= "0001100100";  -- 100
            val_banc(5) <= "0011001000";  -- 200
            val_banc(6) <= "0111110100";  -- 500

            i <= 6;
            state <= '1';

        elsif en_verificare = '1' and state = '1' then
            if (suma_r > "0000000000") and (i >= 0) then
                if (suma_r >= val_banc(i)) and (nr_banc(i) > "000000000000") then
                    rest1:=std_logic_vector(unsigned(suma_r)-unsigned(val_banc(i)));
                    rest <= rest1;
                    suma_r <= rest1 ;
                    nr_banc_ramase1 := std_logic_vector(unsigned(nr_banc(i)) - 1);
                    nr_banc(i) <= nr_banc_ramase1;
                else
                    i <= i - 1;
                end if;
            end if;

            if suma_r = "0000000000" then
                existenta_bancomat <= '1';
                we<='1';
                RAM_AUX(3)<=RAM(3)-nr_banc(3);
                RAM_AUX(4)<=RAM(4)-nr_banc(4);
                RAM_AUX(5)<=RAM(5)-nr_banc(5);
                RAM_AUX(6)<=RAM(6)-nr_banc(6);
                we_retragere<='1';
              --  verif  <= nr_banc(6);
                state <= '0';
            else
                existenta_bancomat <= '0';
            end if;
        end if;
    end if;
end process;
 process(we)
  begin
  if we ='1' then 
     banc50 <= RAM_AUX(3)(3 downto 0);
     banc100 <= RAM_AUX(4)(3 downto 0);
     banc200 <= RAM_AUX(5)(3 downto 0);
     banc500 <= RAM_AUX(6)(3 downto 0);
  end if;
  end process;
 
    process (we5,we_depunere,we_retragere)
    begin
    if we5='1' then 
    RAM(0)(3 downto 0)<=numar_bancnote ;
    end if;
    if we_depunere='1' then 
        RAM(0)<=RAM(0)+RAM_AUX1(0);
    end if;
    if we_retragere='1' then 
        RAM(0)<=nr_banc(0);
    end if;
    
    end process;
    
    process (we10,we_depunere,we_retragere)
    begin
    if we10='1' then 
    RAM(1)(3 downto 0)<=numar_bancnote ;
    end if;
    if we_depunere='1' then 
        RAM(1)<=RAM(1)+RAM_AUX1(1);
    end if;
    if we_retragere='1' then 
        RAM(1)<=nr_banc(1);
    end if;
    end process;
    
    process (we20,we_depunere,we_retragere)
    begin
    if we20='1' then 
    RAM(2)(3 downto 0)<=numar_bancnote ;
    end if;
    if we_depunere='1' then 
        RAM(2)<=RAM(2)+RAM_AUX1(2);
    end if;
    if we_retragere='1' then 
        RAM(2)<=nr_banc(2);
    end if;
    end process;
    
    process (we50,we_depunere,we_retragere)
    begin
    if we50='1' then 
    RAM(3)(3 downto 0)<=numar_bancnote ;
    end if;
    if we_depunere='1' then 
        RAM(3)<=RAM(3)+RAM_AUX1(3);
    end if;
    if we_retragere='1' then 
        RAM(3)<=nr_banc(3);
    end if;
    end process;
    
    process (we100,we_depunere,we_retragere)
    begin
    if we100='1' then 
    RAM(4)(3 downto 0)<=numar_bancnote ;
    end if;
    if we_depunere='1' then 
        RAM(4)<=RAM(4)+RAM_AUX1(4);
    end if;
    if we_retragere='1' then 
        RAM(4)<=nr_banc(4);
    end if;
    end process;
    
    process (we200,we_depunere,we_retragere)
    begin
    if we200='1' then 
    RAM(5)(3 downto 0)<=numar_bancnote ;
    end if;
    if we_depunere='1' then 
        RAM(5)<=RAM(5)+RAM_AUX1(5);
    end if;
    if we_retragere='1' then 
        RAM(5)<=nr_banc(5);
    end if;
    end process;
    
    process (we500,we_depunere,we_retragere)
    begin
    if we500='1' then 
        RAM(6)(3 downto 0)<=numar_bancnote ;
    end if;
    if we_depunere='1' then 
        RAM(6)<=RAM(6)+RAM_AUX1(6);
    end if;
    if we_retragere='1' then 
        RAM(6)<=nr_banc(6);
    end if;
    end process;
    
    
end MEM_RAM_BANC;