LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY top_tb IS
END top_tb;

ARCHITECTURE tb OF top_tb IS

    COMPONENT top
        PORT (
            I_A : IN std_logic_vector(31 DOWNTO 0);
            I_B : IN std_logic_vector(31 DOWNTO 0);
            clock : IN std_logic;
            reset : IN std_logic;
            I_result : OUT std_logic_vector(31 DOWNTO 0);
            bool : OUT std_logic
        );
    END COMPONENT;

    SIGNAL S_I_A, S_I_B, S_I_result : std_logic_vector(31 DOWNTO 0);
    SIGNAL S_bool, S_clock, S_reset : std_logic;

    FILE buffer_input : text;
    FILE buffer_output : text;

BEGIN

    UTT : top
    PORT MAP(
        I_A => S_I_A,
        I_B => S_I_B,
        clock => S_clock,
        reset => S_reset,
        I_result => S_I_result,
        bool => S_bool
    );

    TB : PROCESS
        VARIABLE write_line : line;
        VARIABLE buffer_space : CHARACTER;
        VARIABLE read_line : line;
        VARIABLE V_I_A : std_logic_vector(31 DOWNTO 0);
        VARIABLE V_I_B : std_logic_vector(31 DOWNTO 0);
    BEGIN

        file_open(buffer_input, "inputsTop.txt", read_mode);
        file_open(buffer_output, "outputsTop.txt", write_mode);

        S_clock <= '0';
        S_reset <= '0';

        WHILE NOT endfile(buffer_input) LOOP
            readline(buffer_input, read_line);

            read(read_line, V_I_A);
            read(read_line, buffer_space);

            read(read_line, V_I_B);

            WAIT FOR 20 ns;

            S_I_A <= V_I_A;
            S_I_B <= V_I_B;

            S_clock <= '1';

            WAIT FOR 20 ns;
            write(write_line, STRING'("Result = "));
            write(write_line, S_I_result);

            writeline(buffer_output, write_line);

            WAIT FOR 20 ns;

        END LOOP;

        file_close(buffer_input);
        file_close(buffer_output);

        WAIT FOR 20 ns;

    END PROCESS;
END tb;