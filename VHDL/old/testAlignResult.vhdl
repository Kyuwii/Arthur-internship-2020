LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY testAlignResult IS
    GENERIC (n : INTEGER := 23);
END testAlignResult;

ARCHITECTURE tb OF testAlignResult IS
    COMPONENT alignResult
        GENERIC (n : INTEGER := 23);
        PORT (
            A : IN std_logic;
            B : IN std_logic_vector(n DOWNTO 0);
            C : IN std_logic_vector(7 DOWNTO 0);
            RES : OUT std_logic_vector(n + 8 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A : std_logic;
    SIGNAL B : std_logic_vector(n DOWNTO 0);
    SIGNAL C : std_logic_vector(7 DOWNTO 0);
    SIGNAL RES : std_logic_vector(n + 8 DOWNTO 0);
    FILE buffer_input : text;
    FILE buffer_output : text;

BEGIN
    design : alignResult PORT MAP(A => A, B => B, C => C, RES => RES);

    tb1 : PROCESS
        VARIABLE read_line : line;
        VARIABLE write_line : line;
        VARIABLE buffer_A : std_logic;
        VARIABLE buffer_B : std_logic_vector(n DOWNTO 0);
        VARIABLE buffer_C : std_logic_vector(7 DOWNTO 0);
        VARIABLE buffer_RES : std_logic_vector(n + 8 DOWNTO 0);
        VARIABLE buffer_space : CHARACTER;

    BEGIN
        file_open(buffer_input, "../Files/inputsAlignResult.txt", read_mode);
        A <= '1';
        WHILE NOT endfile(buffer_input) LOOP
            readline(buffer_input, read_line);

            read(read_line, buffer_A);
            read(read_line, buffer_space);

            read(read_line, buffer_B);
            read(read_line, buffer_space);

            read(read_line, buffer_C);
            read(read_line, buffer_space);

            read(read_line, buffer_RES);

            A <= '1';
            B <= buffer_B;
            C <= buffer_C;
            RES <= buffer_RES;

            WAIT FOR 20 ns;

        END LOOP;

        file_close(buffer_input);

        file_open(buffer_output, "../Files/outputsAlignResult.txt", write_mode);

        write(write_line, STRING'("Values"));
        writeline(buffer_output, write_line);

        write(write_line, STRING'(" Result = "));
        write(write_line, RES);

        writeline(buffer_output, write_line);

        file_close(buffer_output);
        WAIT;

    END PROCESS;
END tb;