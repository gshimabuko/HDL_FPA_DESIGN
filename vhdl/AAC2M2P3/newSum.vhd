library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador_16 is port(
    A, B:  in std_logic_vector(15 downto 0);
    Cin:  in std_logic_vector(0 downto 0);
    S:    out std_logic_vector(15 downto 0);
    Cout:  out std_logic
    );
end somador_16;

architecture RTL of somador_16 is
signal aux: std_logic_vector(16 downto 0);
begin
    aux    <= std_logic_vector(to_unsigned(to_integer(unsigned(A)) + to_integer(unsigned(A)) + to_integer(unsigned(Cin)),17)) ;
    
--    S    <= aux(15 downto 0);
--    Cout  <= aux(16);
end RTL;
