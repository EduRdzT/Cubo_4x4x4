----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:51:14 09/24/2016 
-- Design Name: 
-- Module Name:    cubo - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cubo is
    Port ( P,P1 :      in  STD_LOGIC;
           D,Q :    inout  STD_LOGIC_VECTOR (3 downto 0);
           SALIDA : inout  STD_LOGIC_VECTOR (63 downto 0);
           LED :    out  STD_LOGIC_VECTOR (15 downto 0);
           X,Y :    inout  STD_LOGIC_VECTOR (3 downto 0);
           PISOS :  inout  STD_LOGIC_VECTOR (3 downto 0)
			  );
end cubo;

architecture Behavioral of cubo is

begin
--contador de la primer máquina de estados

D(3) <= (Q(3) AND (NOT P)) OR ((NOT Q(1)) AND Q(3)) OR (P AND Q(1) AND Q(0) AND Q(2) AND (NOT Q(3))) OR (Q(3) AND (NOT Q(0))) OR (Q(3) AND (NOT Q(2)));
D(2) <= (Q(2) AND (NOT P))OR ((NOT Q(0)) AND Q(2)) OR ((NOT Q(1)) AND Q(2)) OR (P AND Q(1) AND Q(0) AND (NOT Q(2)));
D(1) <= (Q(1) AND (NOT Q(0))) OR (P AND (NOT Q(1)) AND Q(0)) OR ((NOT P) AND Q(1));	   
D(0) <= ((NOT P) AND Q(0)) OR (P AND (NOT Q(0)));

--proceso de la primer máquina

Maquina1: process (Q)
begin
case Q is 
when "0000" => SALIDA <= "1010101010001010111010001111001011000110101010101010010001110101";
when "0001" => SALIDA <= "0101011100011101101010010101100011111110000001111100110001100101";
when "0010" => SALIDA <= "1010101010001010101010001111000111100011001001010011000100011010";
when "0011" => SALIDA <= "1010111000101110111000011101010111000011000101001000010001000101";
when "0100" => SALIDA <= "1000001101010111010101110100010101011011101010100110000101110011";
when "0101" => SALIDA <= "0101000101011011100101101101001101101010110100000100111010110101";
when "0110" => SALIDA <= "1111111111111111111111111111111111111111111111111111111111111111";
when "0111" => SALIDA <= "1111111111111111111111111111111111111111111111111111111111111111";
when "1000" => SALIDA <= "0001011011100001100100010001101001010100001001101100001101001010";
when "1001" => SALIDA <= "1010101010100010110110110010010110101010000100011000100010110100";
when "1010" => SALIDA <= "1101110110101011100101011001010101010101010110010110010101011010";
when "1011" => SALIDA <= "0000110000110010000100010101110111101101011101101100010010001010";
when "1100" => SALIDA <= "1110010110110100100110011101110101011010110010001110010011101101";
when "1101" => SALIDA <= "1011010101110001000010111110100010101011010101001011001000111101";
when "1110" => SALIDA <= "1111111111111111111111111111111111111111111111111111111111111111";
when "1111" => SALIDA <= "1111111111111111111111111111111111111111111111111111111111111111";

when others => SALIDA <= "1111000010101010111100001010101011110000101010101111000010101010";
end case;
end process Maquina1;

--segundo contador 
X(3) <= (Y(3) AND (NOT P1)) OR ((NOT Y(1)) AND Y(3)) OR (P1 AND Y(1) AND Y(0) AND Y(2) AND (NOT Y(3))) OR (Y(3) AND (NOT Y(0))) OR (Y(3) AND (NOT Y(2)));
X(2) <= (Y(2) AND (NOT P1))OR ((NOT Y(0)) AND Y(2)) OR ((NOT Y(1)) AND Y(2)) OR (P1 AND Y(1) AND Y(0) AND (NOT Y(2)));
X(1) <= (Y(1) AND (NOT Y(0))) OR (P1 AND (NOT Y(1)) AND Y(0)) OR ((NOT P1) AND Y(1));	   
X(0) <= ((NOT P1) AND Y(0)) OR (P1 AND (NOT Y(0)));

--proceso de la segunda máquina
Maquina2: process (Y)
begin
case Y is 
when "0000" => PISOS <= "1000";
when "0001" => PISOS <= "0100";
when "0010" => PISOS <= "0010";
when "0011" => PISOS <= "0001";
when "0100" => PISOS <= "1000";
when "0101" => PISOS <= "0100";
when "0110" => PISOS <= "0010";
when "0111" => PISOS <= "0001";
when "1000" => PISOS <= "1000";
when "1001" => PISOS <= "0100";
when "1010" => PISOS <= "0010";
when "1011" => PISOS <= "0001";
when "1100" => PISOS <= "1000";
when "1101" => PISOS <= "0100";
when "1110" => PISOS <= "0010";
when "1111" => PISOS <= "0001";
when others => PISOS <= "0000";
end case;
end process Maquina2;


LED <= SALIDA(63 downto 48)  when PISOS = "1000" else
		 SALIDA(47 downto 32)  when PISOS = "0100" else
		 SALIDA(31 downto 16)  when PISOS = "0010" else
		 SALIDA(15 downto 0)   when PISOS = "0001" else
		 "0000000000000000";
end Behavioral;