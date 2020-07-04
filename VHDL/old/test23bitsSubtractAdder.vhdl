LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY testSubtractAdder IS
    GENERIC (n : INTEGER := 23);
END testSubtractAdder;

ARCHITECTURE tb OF testSubtractAdder IS
    SIGNAL A, B : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL result : std_logic_vector(n - 1 DOWNTO 0);
    FILE buffer_input : text;
    FILE buffer_output : text;

BEGIN
    tb1 : PROCESS
        VARIABLE read_line : line;
        VARIABLE write_line : line;
        VARIABLE buffer_A, buffer_B, buffer_result : std_logic_vector(n - 1 DOWNTO 0);
        VARIABLE buffer_space : CHARACTER;

    BEGIN
        file_open(buffer_input, "../Files/inputsSubtractAdder.txt", read_mode);
        WHILE NOT endfile(buffer_input) LOOP
            readline(buffer_input, read_line);

            read(read_line, buffer_A);
            read(read_line, buffer_space);

            read(read_line, buffer_B);
            read(read_line, buffer_space);

            read(read_line, buffer_result);

            A <= buffer_A;
            B <= buffer_B;
            result <= buffer_result;

            WAIT FOR 20 ns;

        END LOOP;

        file_close(buffer_input);

        file_open(buffer_output, "../Files/outputsSubtractAdder.txt", write_mode);

        write(write_line, STRING'("Values"));
        writeline(buffer_output, write_line);

        write(write_line, STRING'("Number A = "));
        write(write_line, A);

        write(write_line, STRING'(" Number B = "));
        write(write_line, B);

        write(write_line, STRING'(" Result = "));
        write(write_line, result);

        writeline(buffer_output, write_line);

        file_close(buffer_output);
        WAIT;

    END PROCESS;
END tb;