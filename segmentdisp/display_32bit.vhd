library ieee;

entity display_32bit is
port(
	clk: in bit;
	segments, anode: out bit_vector(7 downto 0);
	number: in bit_vector(31 downto 0)
);
end;

architecture def of display_32bit is
	signal data: bit_vector(63 downto 0);
begin
	SEGMENTS_DISPLAY : entity work.segment7_8 port map(
		clk => clk,
		anode => anode,
		segments => segments,
		data => data
	);
	
	S0 : entity work.segment_7 port map(data => number(3 downto 0), segments => data(7 downto 0));
	S1 : entity work.segment_7 port map(data => number(7 downto 4), segments => data(15 downto 8));
	S2 : entity work.segment_7 port map(data => number(11 downto 8), segments => data(23 downto 16));
	S3 : entity work.segment_7 port map(data => number(15 downto 12), segments => data(31 downto 24));
	S4 : entity work.segment_7 port map(data => number(19 downto 16), segments => data(39 downto 32));
	S5 : entity work.segment_7 port map(data => number(23 downto 20), segments => data(47 downto 40));
	S6 : entity work.segment_7 port map(data => number(27 downto 24), segments => data(55 downto 48));
	S7 : entity work.segment_7 port map(data => number(31 downto 28), segments => data(63 downto 56));
end;