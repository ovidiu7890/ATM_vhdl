library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Bin2BCD is
    Port (
        binary : in STD_LOGIC_VECTOR (9 downto 0);
        bcd : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Bin2BCD;

architecture Behavioral of Bin2BCD is
begin
    process(binary)
        variable temp_bcd : STD_LOGIC_VECTOR(15 downto 0);
        variable temp_binary : UNSIGNED(9 downto 0);
        variable i : INTEGER;
    begin
        temp_bcd := (others => '0');
        temp_binary := UNSIGNED(binary);

        for i in 0 to 9 loop
            if temp_bcd(15 downto 12) > "0100" then
                temp_bcd(15 downto 12) := std_logic_vector(UNSIGNED(temp_bcd(15 downto 12)) + 3);
            end if;
            if temp_bcd(11 downto 8) > "0100" then
                temp_bcd(11 downto 8) := std_logic_vector(UNSIGNED(temp_bcd(11 downto 8)) + 3);
            end if;
            if temp_bcd(7 downto 4) > "0100" then
                temp_bcd(7 downto 4) := std_logic_vector(UNSIGNED(temp_bcd(7 downto 4)) + 3);
            end if;
            if temp_bcd(3 downto 0) > "0100" then
                temp_bcd(3 downto 0) := std_logic_vector(UNSIGNED(temp_bcd(3 downto 0)) + 3);
            end if;

            temp_bcd := temp_bcd(14 downto 0) & temp_binary(9);
            temp_binary := temp_binary(8 downto 0) & '0';
        end loop;

        bcd <= temp_bcd;
    end process;
    
end Behavioral;
