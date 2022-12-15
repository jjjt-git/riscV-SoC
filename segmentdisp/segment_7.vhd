library ieee;

entity segment_7 is
port (
	segments: out bit_vector(7 downto 0);
	data: in bit_vector(3 downto 0)
);
end;

architecture def of segment_7 is
	signal bcd: bit_vector(15 downto 0);
begin
	BCD_DATA : entity work.bcd_4bit port map(
		number => bcd,
		d => data
	);
	
	segments(0) <= bcd(0) or bcd(2) or bcd(3) or bcd(5) or bcd(6) or bcd(7) or bcd(8) or bcd(9) or bcd(10) or bcd(11) or bcd(12) or bcd(13) or bcd(14) or bcd(15);
	segments(1) <= bcd(0) or bcd(1) or bcd(2) or bcd(3) or bcd(4) or bcd(7) or bcd(8) or bcd(9) or bcd(10) or bcd(11) or bcd(13);
	segments(2) <= bcd(0) or bcd(1) or bcd(3) or bcd(4) or bcd(5) or bcd(6) or bcd(7) or bcd(8) or bcd(9) or bcd(10) or bcd(11) or bcd(13);
	segments(3) <= bcd(0) or bcd(2) or bcd(3) or bcd(5) or bcd(6) or bcd(8) or bcd(9) or bcd(11) or bcd(12) or bcd(13) or bcd(14);
	segments(4) <= bcd(0) or bcd(2) or bcd(6) or bcd(8) or bcd(10) or bcd(11) or bcd(12) or bcd(13) or bcd(14) or bcd(15);
	segments(5) <= bcd(0) or bcd(4) or bcd(5) or bcd(6) or bcd(8) or bcd(9) or bcd(10) or bcd(11) or bcd(12) or bcd(13) or bcd(14) or bcd(15);
	segments(6) <= bcd(2) or bcd(3) or bcd(4) or bcd(5) or bcd(6) or bcd(8) or bcd(9) or bcd(10) or bcd(11) or bcd(14) or bcd(15);
	segments(7) <= bcd(10) or bcd(11) or bcd(12) or bcd(13) or bcd(14) or bcd(15);
end;