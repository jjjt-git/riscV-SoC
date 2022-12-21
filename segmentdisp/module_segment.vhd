library ieee;

entity module_segment is
port(
	clk100MHz: in bit; -- 100MHz
	clk: in bit;
	rst: in bit;
	segments, anode: out bit_vector(7 downto 0);
	memAddr: in bit_vector(31 downto 0);
	memWr: in bit_vector(31 downto 0)
);
end;

architecture def of module_segment is
	signal data, dataTmp: bit_vector(31 downto 0);
begin
	SEGMENTSDECODE : entity work.display_32bit port map(
		clk => clk100MHz,
		segments => segments,
		anode => anode,
		number => data
	);
	
	process(clk)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then data <= x"00000000";
			else data <= dataTmp;
			end if;
		end if;
	end process;

	with memAddr select dataTmp <=
		memWr when x"00000004",
		data when others;
end;