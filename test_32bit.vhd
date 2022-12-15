library ieee;

entity test_32bit is
port(
	anode, segments: out bit_vector(7 downto 0);
	btnCenter: in bit;
	leds: out bit_vector(15 downto 0);
	switches: in bit_vector(15 downto 0);
	reset, clk: in bit
);
end;

architecture def of test_32bit is
	signal coreClk, memRead, memWrite: bit;
	signal memWr, memAddr, memRd, memRdRom, memRdSwitches: bit_vector(31 downto 0);
	signal clkCounter, clkCounter_next: bit_vector(24 downto 0);
begin
	MODULE_SEGMENTS : entity work.module_segment port map(
		clk => coreClk,
		clk100MHz => clk,
		anode => anode,
		segments => segments,
		memWr => memWr,
		memAddr => memAddr
	);
	
	MODULE_SWITCHES : entity work.module_switches port map(
		leds => leds,
		switches => switches,
		clk => coreClk,
		rst => reset,
		stageBtn => btnCenter,
		read => memRead,
		write => memWrite,
		memAddr => memAddr,
		memWr => memWr,
		memRd => memRdSwitches
	);
	
	MODULE_ROM : entity work.module_bootloader port map(
		memAddr => memAddr,
		memRd => memRdRom
	);
	
	CORE : entity work.cu_32bit
		generic map(
			bootloaderStartAddr => x"00000008"
		)
		port map(
			memRd => memRd,
			memWr => memWr,
			memAddr => memAddr,
			write => memWrite,
			read => memRead,
			clk => coreClk,
			rst => reset
		);
	
	memRd <= memRdSwitches or memRdRom;
	
	CORECLK_GEN : entity work.incrementor_25bit port map(
		a => clkCounter,
		s => clkCounter_next,
		o => coreClk
	);
	
	process(clk)
	begin
		if clk'event and clk = '1' then
			clkCounter <= clkCounter_next;
		end if;
	end process;
end;

entity incrementor_25bit is
port (
	a: in bit_vector(24 downto 0);
	o: out bit;
	s: out bit_vector(24 downto 0)
);
end;

architecture def of incrementor_25bit is
	signal c: bit_vector(25 downto 0);
begin
	c(0) <= '1';
	c(25 downto 1) <= a and c(24 downto 0);
	s <= a xor c(24 downto 0);
	o <= c(25);
end;