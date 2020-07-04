LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY subtractAdder16bits_tb IS
END subtractAdder16bits_tb;

ARCHITECTURE tb OF subtractAdder16bits_tb IS

    COMPONENT subtractAdder16bits
        GENERIC (n : INTEGER := 10);
        PORT (
            C_mantissa_adder_A : IN std_logic_vector(n - 1 DOWNTO 0);
            C_mantissa_adder_B : IN std_logic_vector(n - 1 DOWNTO 0);
            C_mantissa_adder_result : OUT std_logic_vector(n DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL S_mantissa_adder_A, S_mantissa_adder_B : std_logic_vector(9 DOWNTO 0);
    SIGNAL S_mantissa_adder_result : std_logic_vector(10 DOWNTO 0);

    FILE buffer_input : text;
    FILE buffer_output : text;

BEGIN

    UTT : subtractAdder16bits
    PORT MAP(
        C_mantissa_adder_A => S_mantissa_adder_A,
        C_mantissa_adder_B => S_mantissa_adder_B,
        C_mantissa_adder_result => S_mantissa_adder_result
    );

    TB : PROCESS
        VARIABLE write_line : line;
        VARIABLE buffer_space : CHARACTER;
        VARIABLE read_line : line;

        VARIABLE V_mantissa_adder_A, V_mantissa_adder_B : std_logic_vector(9 DOWNTO 0);

    BEGIN

        file_open(buffer_input, "inputsSubtractAdder16bits.txt", read_mode);
        file_open(buffer_output, "outputsSubtractAdder16bits.txt", write_mode);

        WHILE NOT endfile(buffer_input) LOOP
            readline(buffer_input, read_line);

            read(read_line, V_mantissa_adder_A);
            read(read_line, buffer_space);

            read(read_line, V_mantissa_adder_B);
            read(read_line, buffer_space);

            WAIT FOR 20 ns;

            S_mantissa_adder_A <= V_mantissa_adder_A;
            S_mantissa_adder_B <= V_mantissa_adder_B;

            WAIT FOR 20 ns;

            write(write_line, STRING'("Result = "));
            write(write_line, S_mantissa_adder_result);

            writeline(buffer_output, write_line);

            WAIT FOR 20 ns;

        END LOOP;

        file_close(buffer_input);
        file_close(buffer_output);

        WAIT FOR 20 ns;

    END PROCESS;
END tb;