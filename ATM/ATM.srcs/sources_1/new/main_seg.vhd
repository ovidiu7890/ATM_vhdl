library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity AFISARE_SOLD_CONT is
    Port (clk: in std_logic;
          d_in: in std_logic_vector(9 downto 0);
          seg: out std_logic_vector(7 downto 0);
          an: out std_logic_vector(7 downto 0));
end AFISARE_SOLD_CONT;

architecture Behavioral of AFISARE_SOLD_CONT is
component sevensegmentdecoder
        Port (
        din : in STD_LOGIC_VECTOR (3 downto 0);
        segm : out STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

component divizor
    generic(N:integer:=5000);
    port    (clk,reset: in std_logic;
        clock_out: out std_logic);
end component;
    

component bin2bcd
    Port (
        binary : in STD_LOGIC_VECTOR (9 downto 0);
        bcd : out STD_LOGIC_VECTOR (15 downto 0)
    );
end component;
signal bcd1:std_logic_vector(15 downto 0);
signal seg0,seg1, seg2, seg3, seg4: std_logic_vector(7 downto 0); 
signal an1: std_logic_vector(7 downto 0);
signal clk1 :std_logic;
begin
u0:divizor port map(clk,'0',clk1);
u1:bin2bcd port map(d_in,bcd1);
u2:sevensegmentdecoder port map(bcd1(15 downto 12), seg1);
u3:sevensegmentdecoder port map(bcd1(11 downto 8), seg2);
u4:sevensegmentdecoder port map(bcd1(7 downto 4), seg3);
u5:sevensegmentdecoder port map(bcd1(3 downto 0), seg4);
process(clk1, seg1, seg2, seg3, seg4)
    variable verif:unsigned(1 downto 0):="00";
begin
    if rising_edge(clk1) then
        verif:=verif+1;
    end if;
    if verif=0 then
    seg0<=seg1;
    an1<="11110111";
    end if;
    if verif=1 then
    seg0<=seg2;
    an1<="11111011";
    end if;
    if verif=2 then
    seg0<=seg3;
    an1<="11111101";
    end if;
    if verif=3 then
    seg0<=seg4;
    an1<="11111110";
    end if;
end process;
    an<=an1;
    seg<=seg0;
end Behavioral;