----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/19/2024 10:05:08 PM
-- Design Name: 
-- Module Name: Organigrama - Organigrama
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Organigrama is
port (clk, rst: in STD_LOGIC;
        button: in std_logic;
		verificat_pin, existenta_suma, chitanta, existenta_bancomat: in STD_LOGIC;
		alegere_optiune: in STD_LOGIC_VECTOR(1 downto 0);
		sel : out integer range 0 to 4; 
		eliberare_chitanta, afisare_sold, schimba_pin, enable_verificare_suma, enable_verificare_pin, CS_PINURI, CS_BANCNOTE, CS_SUME, ED, ER,we5,we10,we20,we50,we100,we200,we500: out STD_LOGIC);
end Organigrama;

architecture Organigrama of Organigrama is

type type_state is (introducere5,introducere10,introducere20,introducere50,introducere100,introducere200,introducere500,introducere_pin, introducere_suma_retragere, introducere_suma_depunere, actualizare_cont_retragere, actualizare_cont_depunere, schimbare_pin);
signal state, nx_state: type_state;
signal buttonf:std_logic;

component divizor
generic (N: integer := 5000);
port    (clk,reset: in std_logic;
        clock_out: out std_logic);
end component;

signal clkf: std_logic;
begin
    f1:divizor generic map(5) port map(clk,'0',clkf);
    ACTUALIZARE_STARE: process(clkf, rst)
        begin 
            if rst = '1' then 
                state <= introducere_pin;
            elsif clkf'event and clkf = '1' then 
                state <= nx_state;
            end if;
        end process;  
        
    TRANSITIONS: process (button,state, verificat_pin, existenta_suma,existenta_bancomat, chitanta, alegere_optiune)
	variable k : unsigned(2 downto 0) := "000";
	begin 
		eliberare_chitanta <= '0';
		afisare_sold <= '0';
		schimba_pin <= '0';
		CS_PINURI <= '0';
		CS_BANCNOTE <= '0';
		CS_SUME <= '0';	 
		ED <= '0';
		ER <= '0';	 
		enable_verificare_suma <= '0';
		enable_verificare_pin  <= '0';
		we5<='0';
		we10<='0';
		we20<='0';
		we50<='0';
		we100<='0';
		we200<='0';
		we500<='0';
		case state is
			when introducere5 =>
			     if button='1' then 
                     we5<='1';
                     nx_state<=introducere10;
                 end if;
             when introducere10 =>
			     if button='1' then 
                     we10<='1';
                     nx_state<=introducere20;
                 end if; 
             when introducere20 =>
			     if button='1' then 
                     we20<='1';
                     nx_state<=introducere50;
                 end if; 
             when introducere50 =>
			     if button='1' then 
                     we50<='1';
                     nx_state<=introducere100;
                 end if;   
             when introducere100 =>
			     if button='1' then 
                     we100<='1';
                     nx_state<=introducere200;
                 end if; 
             when introducere200 =>
			     if button='1' then 
                     we200<='1';
                     nx_state<=introducere500;
                 end if;
             when introducere500 =>
			     if button='1' then 
                     we500<='1';
                     nx_state<=introducere_pin;
                 end if;            
			when introducere_pin =>
			sel<=0;
				CS_PINURI <= '1';
				enable_verificare_pin <= '1';
				if verificat_pin = '0' then 
					nx_state <= introducere_pin;
				elsif alegere_optiune = "00" then nx_state <= introducere_suma_retragere;
				elsif alegere_optiune = "01" then nx_state <= introducere_suma_depunere;
				elsif alegere_optiune = "10" then 
					afisare_sold <= '1';
					nx_state <= introducere_pin;
				else nx_state <= schimbare_pin;
				end if;	
			
			when introducere_suma_retragere =>
			sel<=1;
				enable_verificare_suma <= '1';
				if (existenta_suma = '0') or (existenta_bancomat = '0') then 
					nx_state <= introducere_pin;  
				else nx_state <= actualizare_cont_retragere;
				end if;
			
			when actualizare_cont_retragere =>
				ER <= '1';
				CS_SUME <= '1';
				CS_BANCNOTE <= '1';
				if chitanta = '1' then 
					eliberare_chitanta <= '1';
					nx_state <= introducere_pin;
				else
					nx_state <= introducere_pin;
				end if;
			
			when introducere_suma_depunere => 
			sel<=2;
			nx_state <= actualizare_cont_depunere;
			
			when actualizare_cont_depunere =>
				ED <= '1';
				CS_SUME <= '1';	
				if chitanta = '1' then 
					eliberare_chitanta <= '1';
					nx_state <= introducere_pin;
				else  
					nx_state <= introducere_pin;
				end if;
			
			when schimbare_pin =>
			sel<=3;
				CS_PINURI <= '1';
				schimba_pin <= '1';
				if chitanta = '1' then 
					eliberare_chitanta <= '1';
					nx_state <= introducere_pin;
				else 
					nx_state <= introducere_pin;
				end if;
		end case;
	end process;
end Organigrama;
