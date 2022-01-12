 -----------begin part1.vhdl---------------------


library ieee;
use ieee.std_logic_1164.all;

entity part1 is
    generic ( width : integer :=7);
    PORT( a, b, c, d: IN std_logic_vector(width downto 0);
        sel: IN std_logic_vector(1 downto 0);
        result: OUT std_logic_vector(width downto 0)
    );
end part1;

architecture muxbehav of part1 is

BEGIN

    result <=       a after 5 ns when sel="00" else
                    b after 5 ns when sel="01" else
                    c after 5 ns when sel="10" else
                    d after 5 ns;
end muxbehav;

-----------end part1.vhdl---------------------

    -----------begin part1_tb.vhdl------------------

library ieee;
use ieee.std_logic_1164.all;


entity part1_tb is
    generic( width : integer := 7);
end part1_tb;

architecture tb of part1_tb is

    signal t_a: std_logic_vector(width downto 0):="00000000";
    signal t_b: std_logic_vector(width downto 0):="00000000";
    signal t_c: std_logic_vector(width downto 0):="00000000";
    signal t_d: std_logic_vector(width downto 0):="00000000";
    signal t_s: std_logic_vector(1 downto 0);
    signal t_o: std_logic_vector(width downto 0);

component part1
    generic(width : integer);
    PORT( a, b, c, d: IN std_logic_vector(width downto 0);
        sel: IN std_logic_vector(1 downto 0);
        result: OUT std_logic_vector(width downto 0)
    );
    end component;

    begin

    U_part1: part1 generic map(width) port map(a=>t_a, b=>t_b, c=>t_c, d=>t_d, sel=>t_s, result=>t_o);

    process

        begin
		report "Starting";
        t_a <= "11111111";
        t_b <= "00000001";
        t_c <= "10101010";
        t_d <= "01010101";

        wait for 10 ns;
        t_s <= "00";
        wait for 6 ns;
        assert (t_o="11111111") report "Error input a" severity error;

        wait for 10 ns;
        t_s <= "01";
        wait for 6 ns;
        assert (t_o="00000001") report "Error input b" severity error;

        wait for 10 ns;
        t_s <= "10";
        wait for 6 ns;
        assert (t_o="10101010") report "Error input c" severity error;

        wait for 10 ns;
        t_s <= "11";
        wait for 6 ns;
        assert (t_o="01010101") report "Error input d" severity error;
		report "Finished";
        wait;

    end process;
end tb;

-----------end part1_tb.vhdl------------------