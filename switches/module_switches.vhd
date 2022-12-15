library ieee;

entity module_switches is
port(
	clk: in bit;
	switches: in bit_vector(15 downto 0);
	stageBtn: in bit;
	leds: out bit_vector(15 downto 0);
	memAddr: in bit_vector(31 downto 0);
	memWr: in bit_vector(31 downto 0);
	memRd: out bit_vector(31 downto 0);
	write, read, rst: in bit
);
end;

architecture def of module_switches is
	signal rData, wData: bit_vector(15 downto 0);
	constant ZERO: bit_vector(15 downto 0) := x"0000";
begin
	process(clk)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				wData <= ZERO;
				rData <= ZERO;
			elsif stageBtn = '1' then
				rData <= switches;
			elsif memAddr = x"00000002" then
				if write = '1' then
					wData <= memWr(15 downto 0);
				elsif read = '1' then
					memRd(15 downto 0) <= rData;
				end if;
			else
				memRd(15 downto 0) <= ZERO; 
			end if;
		end if;
	end process;
	
	memRd(31 downto 16) <= ZERO;
	leds <= wData;
end;