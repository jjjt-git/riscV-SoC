library ieee;

entity bcd_4bit is
port (
	d: in bit_vector(3 downto 0);
	number: out bit_vector(15 downto 0)
);
end;

architecture def of bcd_4bit is
begin
	number(0) <= not d(0) and not d(1) and not d(2) and not d(3);
	number(1) <= d(0) and not d(1) and not d(2) and not d(3);
	number(2) <= not d(0) and d(1) and not d(2) and not d(3);
	number(3) <= d(0) and d(1) and not d(2) and not d(3);
	number(4) <= not d(0) and not d(1) and d(2) and not d(3);
	number(5) <= d(0) and not d(1) and d(2) and not d(3);
	number(6) <= not d(0) and d(1) and d(2) and not d(3);
	number(7) <= d(0) and d(1) and d(2) and not d(3);
	number(8) <= not d(0) and not d(1) and not d(2) and d(3);
	number(9) <= d(0) and not d(1) and not d(2) and d(3);
	number(10) <= not d(0) and d(1) and not d(2) and d(3);
	number(11) <= d(0) and d(1) and not d(2) and d(3);
	number(12) <= not d(0) and not d(1) and d(2) and d(3);
	number(13) <= d(0) and not d(1) and d(2) and d(3);
	number(14) <= not d(0) and d(1) and d(2) and d(3);
	number(15) <= d(0) and d(1) and d(2) and d(3);
end;