-- Counter based on 50 MHz clock that outputs control signals 
-- at 50M, with asynchronous reset and
-- a synchronous clear.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Count1S is
  port( CLK, EN: in std_logic;
        CNT50M: out std_logic);
end Count1S;

architecture behav of Count1S is
  signal CNT: std_logic_vector(25 downto 0) := "00000000000000000000000000";
begin

  -- Clock the counter
  process (CLK)
  begin
    if (CLK'event) and (CLK = '1') then
	if (EN = '1') then
       if (CNT = "10111110101111000010000000") then
       --   if (cnt = "00000000000000000000000010") then   -- Uncomment this line for testbench
	     CNT50M <= '1';
          CNT <= "00000000000000000000000000";
        else
          CNT50M <= '0';
          CNT <= CNT + '1';
	  end if;
        end if;
      end if;
  end process;
  
end behav;
