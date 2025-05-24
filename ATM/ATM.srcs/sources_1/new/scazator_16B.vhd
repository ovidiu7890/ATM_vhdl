library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity scazator_16B is
    Port ( A, B:in std_logic_vector(9 downto 0) ;
           Cin:in std_logic ;
           S:out std_logic_vector (9 downto 0);
           Cout:out std_logic);
end scazator_16B;

architecture Behavioral of scazator_16B is
signal C: std_logic_vector (10 downto 0);
component scazator_1Bit is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           CIN : in STD_LOGIC;
           S : out STD_LOGIC;
           COUT : out STD_LOGIC);
end component;
begin
eth: for i in 0 to 9 generate
    eth:scazator_1Bit port map(A(i),B(i),C(i),S(i),C(i+1));
    end generate;
C(0)<=Cin;
Cout<=C(10);
end Behavioral;