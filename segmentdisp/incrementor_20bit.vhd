library ieee;

entity incrementor_20bit is
port (
	a: in bit_vector(19 downto 0);
	s: out bit_vector(19 downto 0)
);
end;

architecture def of incrementor_20bit is
	signal c: bit_vector(20 downto 0);
begin
	c(0) <= '1';
	c(20 downto 1) <= a and c(19 downto 0);
	s <= a xor c(19 downto 0);
end;