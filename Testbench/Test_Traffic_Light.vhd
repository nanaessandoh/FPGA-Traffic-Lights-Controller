-- Traffic Light Test Bench

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_traffic is

end test_traffic;

architecture rtl of test_traffic is
 
component traffic_light 
  port( 
	-- Input Signals (SW0 - Car Waiting)
	clk, car_waiting: in std_logic;
	-- Output Signals
	nslgreen, nsgreen,nsred, nsyellow, ewlgreen, ewgreen, ewyellow, ewred: out std_logic;
	-- LEDs to show Output Signals
        LEDR: out std_logic_vector(8 downto 0);	
	-- HEX to Display Timer
	HEX1,HEX0,HEX4, HEX5: out std_logic_vector(6 downto 0)	
);
end component;

	-- Declare the signals
	signal CLK: std_logic := '0' ;
	signal c_wait, nsl_green,ns_green,ns_red,ns_yellow,ewl_green,ew_green,ew_yellow,ew_red : std_logic;
	signal RLED: std_logic_vector (8 downto 0) := "000000000";
  	signal H1,H0,H4,H5: std_logic_vector(6 downto 0) := "0000000";
begin

	T01: traffic_light port map(CLK, c_wait, nsl_green, ns_green, ns_red, ns_yellow, ewl_green, ew_green, ew_yellow, ew_red, RLED, H1, H0, H4, H5);
	CLK <= not CLK after 0.5 ns;
	c_wait <= '0', '1' after 3 ns, '0' after 25 ns, '1' after 40 ns, '0' after 70 ns;
  
end rtl;
