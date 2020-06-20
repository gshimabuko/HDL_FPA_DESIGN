LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC;
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);

END RAM128_32;
architecture behavioural of RAM128_32 is
    type ram_type is array (127 downto 0)  of std_logic_vector (31 downto 0);
    signal ram: ram_type;
    begin
    RAM_PROC: process (clock)
    begin
        if (rising_edge(clock)) then
            if wren = '1' then
                ram(to_integer(unsigned(address))) <= data;
            else   
                ram(to_integer(unsigned(address))) <= ram(to_integer(unsigned(address)));
            end if;
        end if;
    end process RAM_PROC;
        q <= ram(to_integer(unsigned(address)));
end behavioural;
