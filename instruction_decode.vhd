------ This file describes the instruction decode operation -------------
LIBRARY ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity instruction_decode is
	port(instr : in std_logic_vector(31 downto 0);
			m_read, m_write, reg_write, add_sub : out std_logic;
			read_p1, read_p2, write_p : out std_logic_vector(3 downto 0));
end instruction_decode;

architecture struc_behaviour of instruction_decode is
	signal opcode, funct : std_logic_vector(5 downto 0);
	signal shamt : std_logic_vector(4 downto 0);

begin

	opcode <= instr(31 downto 26);
	shamt <= instr(10 downto 6);
	funct <= instr(5 downto 0);

	read_p1 <= instr(24 downto 21);
	read_p2 <= instr(19 downto 16);
	write_p <= instr(14 downto 11);
	
	m_read <= '0';
	m_write <= '0';
	reg_write <= '1' when ((opcode = "000000") and ((funct = "100000") 
			or (funct = "100010"))) 
			else '0';
	
	add_sub <= '1' when ((opcode = "000000") and (funct = "100010"))
							else '0';

end struc_behaviour;