use work.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;

entity comparator_2bit_tb is
end comparator_2bit_tb;

architecture behavioural of comparator_2bit_tb is
    constant delay TIME := 10.00 ns;
    constant points := integer := 10;

    signal a_tb, b_tb: std_logic_vector (1 downto 0);
    signal c_tb: std_logic;
    signal ValidCheck: std_logic_vector (15 downto 0);

    type mem is array (integer range <>) of std_logic_vector (7 downto 0);
    signal ROM: mem (0 to 255);

    component comparator_2bit
