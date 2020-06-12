library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity testSubtractAdder is
    generic(n: integer:=23);
end testSubtractAdder;

architecture tb of testSubtractAdder is
    signal A : std_logic;
    signal B : std_logic_vector(n downto 0);
    signal C : std_logic_vector(7 downto 0);
    signal RES : std_logic_vector(n + 8 downto 0);
    file buffer_input: text;
    file buffer_output: text;

begin
tb1 : process
    variable read_line : line;
    variable write_line : line;
    variable buffer_A : std_logic;
    variable buffer_B : std_logic_vector(n downto 0);
    variable buffer_C : std_logic_vector(7 downto 0);
    variable buffer_RES : std_logic_vector(n + 8 downto 0);
    variable buffer_space : character;
    
    begin
        file_open(buffer_input, "../Files/inputsAlignResult.txt", read_mode);
        while not endfile(buffer_input) loop
            readline(buffer_input, read_line);
            
            read(read_line, buffer_A);
            read(read_line, buffer_space);

            read(read_line, buffer_B);
            read(read_line, buffer_space);

            read(read_line, buffer_C);
            read(read_line, buffer_space);

            read(read_line, buffer_RES);

            A <= buffer_A;
            B <= buffer_B;
            C <= buffer_C;
            RES <= buffer_RES;

            wait for 20 ns;
    
        end loop;

        file_close(buffer_input);

        file_open(buffer_output, "..Files/outputsAlignResult.txt", write_mode);

        write(write_line, string'("Values"));
        writeline(buffer_output, write_line);
        
        write(write_line, string'(" Result = "));
        write(write_line, RES);

        writeline(buffer_output, write_line);

        file_close(buffer_output);
        wait;

    end process;
end tb;