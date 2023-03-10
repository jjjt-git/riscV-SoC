library ieee;

entity test_32bit is
port(
	anode, segments: out bit_vector(7 downto 0);
	btnCenter, btnUp: in bit;
	leds: out bit_vector(15 downto 0);
	switches: in bit_vector(15 downto 0);
	reset, clk: in bit
);
end;

architecture def of test_32bit is
	signal memWr, memAddr, memRd, memRdRom, memRdSwitches: bit_vector(31 downto 0);
	signal coreClk, realReset, memFetch, memRead, memWrite: bit;
	signal clkCounter, clkCounter_next: bit_vector(14 downto 0);
begin

	MODULE_SEGMENTS : entity work.module_segment port map(
		clk => coreClk,
		clk100MHz => clk,
		rst => realReset,
		anode => anode,
		segments => segments,
		memWr => memWr,
		memAddr => memAddr
	);
	
	MODULE_SWITCHES : entity work.module_switches port map(
		leds => leds,
		switches => switches,
		clk => coreClk,
		rst => realReset,
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
			rst => realReset,
			fetchInstruction => memFetch
		);
	
	memRd <= memRdSwitches or memRdRom;
	
	CORECLK_GEN : entity work.incrementor_26bit port map(
		a => clkCounter,
		s => clkCounter_next
	);
	
	coreClk <= clkCounter(14);
--	coreClk <= btnUp;

	realReset <= not reset;

	process(clk)
	begin
		if clk'event and clk = '1' and btnUp = '0' then
			clkCounter <= clkCounter_next;
		end if;
	end process;
end;

entity incrementor_26bit is
port (
	a: in bit_vector(14 downto 0);
	s: out bit_vector(14 downto 0)
);
end;

architecture def of incrementor_26bit is
	signal c: bit_vector(15 downto 0);
begin
	c(0) <= '1';
	c(15 downto 1) <= a and c(14 downto 0);
	s <= a xor c(14 downto 0);
end;
