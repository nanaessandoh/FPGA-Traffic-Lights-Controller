-- 5 Bit Counter that counts from 0 to 31
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity traffic_light is
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
end traffic_light;

architecture rtl of traffic_light is

	-- 1 Second Generator
  	component Count1S 
 	 port( clk, en: in std_logic;
        cnt50M: out std_logic);
	end component;

	-- 5 Bit Counter
	component Counter5bit
 	 port( CLK, EN: in std_logic;
		UB : in std_logic_vector(4 downto 0); -- Upper bound of counter
	        COUNT: out  std_logic_vector(4 downto 0); -- Output of Counter
		DIGIT1, DIGIT0: out std_logic_vector(3 downto 0));
	end component;

	component seven_segment_decoder
	    port(
	        SW : in std_logic_vector(3 downto 0);
	        HEX0 : out std_logic_vector(6 downto 0)
	    );
	end component;


	-- Declare the signals
	signal start_counter: std_logic := '0' ;
	signal nsl_g,ns_g,ns_r,ns_y,ewl_g,ew_g,ew_y,ew_r : std_logic := '0' ;
	signal Cstate, DIGIT1,DIGIT0: std_logic_vector (3 downto 0) := "0000";
  	signal time_sec,count: std_logic_vector(4 downto 0) := "00001";

	-- Declare the state types
	type state_type is (NSL_GREEN, NS_GREEN, NS_YELLOW, EWL_GREEN, EW_GREEN, EW_YELLOW, EW_GREENEXT);

	-- Declare current and next state variables
	 signal current_state : state_type := NSL_GREEN ;
	 signal next_state : state_type := NSL_GREEN ; 




begin

 	Seconds: Count1S port map(clk, '1', start_counter);
	C0 : Counter5bit port map (clk, start_counter, time_sec, count, DIGIT1, DIGIT0);
	
	process(clk)
	
	begin
	end process;
 

	-- Process to clock Flip-Flops storing the State Information
  	process (clk)
  	begin
		if ( clk'event and clk = '1') then
		current_state <= next_state;
		end if;

 	 end process;

	-- Process to determine Next State
  	process (current_state, time_sec, count, car_waiting)
  	begin
 		case current_state is

		
		-- NSL_GREEN
		when NSL_GREEN =>
		if (count = "00000") then
			next_state <= NS_GREEN;
			time_sec <= "10100";
			Cstate <= "0001"; 
		else
			next_state <= NSL_GREEN;
		end if;


		-- NS_GREEN
		when NS_GREEN =>
		if (count = "00000") then
			next_state <= NS_YELLOW;
			time_sec <= "00111";
			Cstate <= "0010";
		else
			next_state <= NS_GREEN;
		end if;


		-- NS_YELLOW
		when NS_YELLOW =>
		if (count = "00000") then
			next_state <= EWL_GREEN;
			time_sec <= "10100";
			Cstate <= "0011"; 
		else
			next_state <= NS_YELLOW;
		end if;


		-- EWL_GREEN
		when EWL_GREEN =>
		if (count = "00000") then
			next_state <= EW_GREEN;
			time_sec <= "10100";
			Cstate <= "0100"; 
		else
			next_state <= EWL_GREEN;
		end if;


		-- EW_GREEN
		when EW_GREEN =>
		if (count = "00000") then
		    if (car_waiting = '0') then
			next_state <= EW_GREENEXT;
			time_sec <= "01111";
			Cstate <= "0110";
			else
			next_state <= EW_YELLOW;
			time_sec <= "00111";
			Cstate <= "0101"; 
		end if;
		    else
			next_state <= EW_GREEN;
		end if;


		-- EW_GREENEXT
		when EW_GREENEXT =>
		if (count = "00000") or (car_waiting = '1') then
			next_state <= EW_YELLOW;
			time_sec <= "00111";
			Cstate <= "0101"; 
		    else
			next_state <= EW_GREENEXT;		
		end if;


		-- EW_YELLOW
		when EW_YELLOW =>
		if (count = "00000") then
			next_state <= NSL_GREEN;
			time_sec <= "01010";
			Cstate <= "0000"; 
		else
			next_state <= EW_YELLOW;
		end if;
		
		end case;
 	 end process;


	-- Process to Generate Outputs 

  	process (current_state)
  	begin
 		case current_state is

		
		-- NSL_GREEN
		when NSL_GREEN =>
		nsl_g <= '1';
		ns_g <= '0';
		ns_r <= '1';
		ns_y <= '0';
		ewl_g <= '0';
		ew_g <= '0'; 
		ew_y <= '0';
		ew_r <= '1';

		-- NS_GREEN
		when NS_GREEN =>
		nsl_g <= '0';
		ns_g <= '1';
		ns_r <= '0';
		ns_y <= '0';
		ewl_g <= '0';
		ew_g <= '0'; 
		ew_y <= '0';
		ew_r <= '1';

		-- NS_YELLOW
		when NS_YELLOW =>
		nsl_g <= '0';
		ns_g <= '0';
		ns_r <= '0';
		ns_y <= '1';
		ewl_g <= '0';
		ew_g <= '0'; 
		ew_y <= '0';
		ew_r <= '1';


		-- EWL_GREEN
		when EWL_GREEN =>
		nsl_g <= '0';
		ns_g <= '0';
		ns_r <= '1';
		ns_y <= '0';
		ewl_g <= '1';
		ew_g <= '0'; 
		ew_y <= '0';
		ew_r <= '1';


		-- EW_GREEN
		when EW_GREEN =>
		nsl_g <= '0';
		ns_g <= '0';
		ns_r <= '1';
		ns_y <= '0';
		ewl_g <= '0';
		ew_g <= '1'; 
		ew_y <= '0';
		ew_r <= '0';


		-- EW_GREENEXT
		when EW_GREENEXT =>
		nsl_g <= '0';
		ns_g <= '0';
		ns_r <= '1';
		ns_y <= '0';
		ewl_g <= '0';
		ew_g <= '1'; 
		ew_y <= '0';
		ew_r <= '0';


		-- EW_YELLOW
		when EW_YELLOW =>
		nsl_g <= '0';
		ns_g <= '0';
		ns_r <= '1';
		ns_y <= '0';
		ewl_g <= '0';
		ew_g <= '0'; 
		ew_y <= '1';
		ew_r <= '0';
		
		end case;
 	 end process;


	-- Assign Output Signals 
	nslgreen <= nsl_g;
	nsgreen <= ns_g;
	nsred <= ns_r;
	nsyellow <= ns_y;
	ewlgreen <= ewl_g;
	ewgreen <= ew_g;
	ewyellow <= ew_y;
	ewred <= ew_r;

	-- Assign Signals to LEDs
	LEDR(0) <= car_waiting;
	LEDR(1) <= nsl_g;
	LEDR(2) <= ns_g;
	LEDR(3) <= ns_r;
	LEDR(4) <= ns_y;
	LEDR(5) <= ewl_g;
	LEDR(6) <= ew_g;
	LEDR(7) <= ew_y;
	LEDR(8) <= ew_r;


	SecH_0 : seven_segment_decoder port map (DIGIT0, HEX0);
	SecH_1 : seven_segment_decoder port map (DIGIT1, HEX1);
	SecH_4 : seven_segment_decoder port map (Cstate, HEX4);
	SecH_5 : seven_segment_decoder port map ("0101", HEX5);

end rtl;
