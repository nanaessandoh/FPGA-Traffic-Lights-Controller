-- Counter based on 50 MHz clock that outputs control signals 
-- at 50M, with asynchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Count1S is
  port( clk, en: in std_logic;
        cnt50M: out std_logic);
end Count1S;

architecture rtl of Count1S is
  signal cnt: std_logic_vector(25 downto 0) := "00000000000000000000000000";
begin

  -- Clock the counter
  process (clk)
  begin
    if (clk'event) and (clk = '1') then
	if (en = '1') then
       if (cnt = "10111110101111000010000000") then
       --   if (cnt = "00000000000000000000000100") then   -- Uncomment this line for testbench
	     cnt50M <= '1';
          cnt <= "00000000000000000000000000";
        else
          cnt50M <= '0';
          cnt <= cnt + '1';
	  end if;
        end if;
      end if;
  end process;
  
end rtl;
