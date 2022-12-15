library ieee;

entity module_segment is
port(
	clk100MHz: in bit; -- 100MHz
	clk: in bi;
	segments, anode: out bit_vector(7 downto 0);
	memAddr: in bit_vector(31 downto 0);
	memWr: in bit_vector(31 downto 0)
);
end;

architecture def of module_segment is
	signal data: bit_vector(31 downto 0);
begin
	SEGMENTS : entity display_32bit port map(
		clk => clk100MHz,
		segments => segments,
		anode => anode,
		number => data
	);
	
	process(clk)
	begin
		if clk'event and clk = '1' then
			if memAddr = x"00000004" then
				data <= memWr;
			end if;
		end if;
	end process;
end;