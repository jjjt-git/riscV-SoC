library ieee;

entity segment7_8 is
port(
	clk: in bit; -- 100 MhZ
	anode: out bit_vector(7 downto 0);
	segments: out bit_vector(7 downto 0);
	data: in bit_vector(63 downto 0)
);
end;

architecture def of segment7_8 is
	signal cnt, cnt_n: bit_vector(19 downto 0);
	signal data_tmp: bit_vector(63 downto 0);
begin
	data_tmp <= data xor x"FFFFFFFFFFFFFFFF";
	
	CNT_INC : entity work.incrementor_20bit port map (
		a => cnt,
		s => cnt_n
	);

	with cnt(19 downto 17) select
		segments <=
			data_tmp(63 downto 56) when "111",
			data_tmp(55 downto 48) when "110",
			data_tmp(47 downto 40) when "101",
			data_tmp(39 downto 32) when "100",
			data_tmp(31 downto 24) when "011",
			data_tmp(23 downto 16) when "010",
			data_tmp(15 downto 8)  when "001",
			data_tmp(7 downto 0)   when "000";
	
	
	with cnt(19 downto 17) select
		anode <=
			"11111110" when "000",
			"11111101" when "001",
			"11111011" when "010",
			"11110111" when "011",
			"11101111" when "100",
			"11011111" when "101",
			"10111111" when "110",
			"01111111" when "111";
	
	process(clk)
	begin
		if clk'event and clk = '1'
		then
			cnt <= cnt_n;
		end if;
	end process;
end;