library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SevenSegmentDecoder is
    Port (
        din : in STD_LOGIC_VECTOR (3 downto 0);
        segm : out STD_LOGIC_VECTOR (7 downto 0)
    );
end SevenSegmentDecoder;

architecture Behavioral of SevenSegmentDecoder is
begin
    process(din)
    begin
        case din is
            when "0000" => segm <= "11000000"; -- 0
            when "0001" => segm <= "11111001"; -- 1
            when "0010" => segm <= "10100100"; -- 2
            when "0011" => segm <= "10110000"; -- 3
            when "0100" => segm <= "10011001"; -- 4
            when "0101" => segm <= "10010010"; -- 5
            when "0110" => segm <= "10000010"; -- 6
            when "0111" => segm <= "11111000"; -- 7
            when "1000" => segm <= "10000000"; -- 8
            when "1001" => segm <= "10010000"; -- 9
            when others => segm <= "11111111"; -- All segments off
        end case;
    end process;
end Behavioral;
