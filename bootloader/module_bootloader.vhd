library ieee;

entity module_bootloader is
port(
	memAddr: in bit_vector(31 downto 0);
	memRd: out bit_vector(31 downto 0)
);
end;

architecture def of module_bootloader is
begin
	with memAddr select memRd <=
-- MULTIPLIKATOR
		x"00205083" when x"00000008",
		x"FE100EE3" when x"0000000C",
		x"00205103" when x"00000010",
		x"FE208EE3" when x"00000014",
		x"000001B3" when x"00000018",
		x"00200863" when x"0000001C",
		x"003081B3" when x"00000020",
		x"FFF10113" when x"00000024",
		x"FF5FF06F" when x"00000028",
		x"00302223" when x"0000002C",

-- WRITE 00000000 TO 7-SEGMENTS
--		x"00100093" when x"00000008",
--		x"00102223" when x"0000000C",

-- LOAD SWITCHES AND WRITEBACK TO LEDS
--		x"00205083" when x"00000008",
--		x"FE100EE3" when x"0000000C",
--		x"00102223" when x"00000010",

-- WRITE FFFFFFFF TO LEDS
--		x"000001B3" when x"00000008",
--		x"FFF10113" when x"0000000C",
--		x"00302123" when x"00000010",

		x"00000000" when others;
end;