-- 5 Bit Counter that counts from 0 to 31
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Counter5bit is
  port( CLK, EN: in std_logic;
	UB : in std_logic_vector(4 downto 0); -- Upper bound of counter
        COUNT: out  std_logic_vector(4 downto 0); -- Output of Counter
	DIGIT1, DIGIT0: out std_logic_vector(3 downto 0));
end Counter5bit;

architecture rtl of Counter5bit is
  signal CNT: std_logic_vector(4 downto 0) := UB;
begin

  -- Clock the counter
  process (CLK)
  begin

    if (CLK'event) and (CLK = '1') then
	  if (EN = '1') then
          CNT <= CNT - '1';
		 elsif (CNT = "00000") then
			 CNT <= UB;
        end if;
    end if;
  end process;
	COUNT <=CNT;


  process (CNT)
  begin
    case CNT is
        when "00000" => DIGIT1 <= "0000"; DIGIT0 <= "0000"; -- 00
        when "00001" => DIGIT1 <= "0000"; DIGIT0 <= "0001"; -- 01 
        when "00010" => DIGIT1 <= "0000"; DIGIT0 <= "0010"; -- 02 
        when "00011" => DIGIT1 <= "0000"; DIGIT0 <= "0011"; -- 03            
        when "00100" => DIGIT1 <= "0000"; DIGIT0 <= "0100"; -- 04
        when "00101" => DIGIT1 <= "0000"; DIGIT0 <= "0101"; -- 05
        when "00110" => DIGIT1 <= "0000"; DIGIT0 <= "0110"; -- 06
        when "00111" => DIGIT1 <= "0000"; DIGIT0 <= "0111"; -- 07
        when "01000" => DIGIT1 <= "0000"; DIGIT0 <= "1000"; -- 08
        when "01001" => DIGIT1 <= "0000"; DIGIT0 <= "1001"; -- 09
        when "01010" => DIGIT1 <= "0001"; DIGIT0 <= "0000"; -- 10
        when "01011" => DIGIT1 <= "0001"; DIGIT0 <= "0001"; -- 11           
        when "01100" => DIGIT1 <= "0001"; DIGIT0 <= "0010"; -- 12
        when "01101" => DIGIT1 <= "0001"; DIGIT0 <= "0011"; -- 13
        when "01110" => DIGIT1 <= "0001"; DIGIT0 <= "0100"; -- 14
        when "01111" => DIGIT1 <= "0001"; DIGIT0 <= "0101"; -- 15
        when "10000" => DIGIT1 <= "0001"; DIGIT0 <= "0110"; -- 16
        when "10001" => DIGIT1 <= "0001"; DIGIT0 <= "0111"; -- 17
        when "10010" => DIGIT1 <= "0001"; DIGIT0 <= "1000"; -- 18
        when "10011" => DIGIT1 <= "0001"; DIGIT0 <= "1001"; -- 19           
        when "10100" => DIGIT1 <= "0010"; DIGIT0 <= "0000"; -- 20
	     when others => DIGIT1 <= "0000"; DIGIT0 <= "0000"; -- 00 
    end case;   

  end process;
  
end rtl;
