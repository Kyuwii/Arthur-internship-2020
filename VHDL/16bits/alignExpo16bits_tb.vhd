LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY alignExpo16bits_tb IS
END alignExpo16bits_tb;

ARCHITECTURE tb OF alignExpo16bits_tb IS
    COMPONENT alignExpo16bits
        GENERIC (n : INTEGER := 10);
        PORT (
            C_mantissa_expo_A : IN std_logic_vector(9 DOWNTO 0);
            C_mantissa_expo_B : IN std_logic_vector(9 DOWNTO 0);
            C_exponent_expo_A : IN std_logic_vector(4 DOWNTO 0);
            C_exponent_expo_B : IN std_logic_vector(4 DOWNTO 0);
            C_mantissa_expo_result : OUT std_logic_vector(9 DOWNTO 0);
            C_exponent_expo_result : OUT std_logic_vector(4 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL S_mantissa_expo_A, S_mantissa_expo_B, S_mantissa_expo_result : std_logic_vector(9 DOWNTO 0);
    SIGNAL S_exponent_expo_A, S_exponent_expo_B, S_exponent_expo_result : std_logic_vector(4 DOWNTO 0);

    FILE buffer_input : text;
    FILE buffer_output : text;

BEGIN

    UTT : alignExpo16bits
    PORT MAP(
        C_mantissa_expo_A => S_mantissa_expo_A,
        C_mantissa_expo_B => S_mantissa_expo_B,
        C_exponent_expo_A => S_exponent_expo_A,
        C_exponent_expo_B => S_exponent_expo_B,
        C_mantissa_expo_result => S_mantissa_expo_result,
        C_exponent_expo_result => S_exponent_expo_result
    );

    TB : PROCESS
        VARIABLE write_line : line;
        VARIABLE buffer_space : CHARACTER;
        VARIABLE read_line : line;
        VARIABLE V_mantissa_expo_A, V_mantissa_expo_B : std_logic_vector(9 DOWNTO 0);
        VARIABLE V_exponent_expo_A, V_exponent_expo_B : std_logic_vector(4 DOWNTO 0);
    BEGIN

        file_open(buffer_input, "inputsAlignExpo16bits.txt", read_mode);
        file_open(buffer_output, "outputsAlignExpo16bits.txt", write_mode);

        WHILE NOT endfile(buffer_input) LOOP
            readline(buffer_input, read_line);

            read(read_line, V_exponent_expo_A);
            read(read_line, buffer_space);

            read(read_line, V_mantissa_expo_A);
            read(read_line, buffer_space);

            read(read_line, V_exponent_expo_B);
            read(read_line, buffer_space);

            read(read_line, V_mantissa_expo_B);
            read(read_line, buffer_space);

            WAIT FOR 20 ns;

            S_mantissa_expo_A <= V_mantissa_expo_A;
            S_mantissa_expo_B <= V_mantissa_expo_B;

            S_exponent_expo_A <= V_exponent_expo_A;
            S_exponent_expo_B <= V_exponent_expo_B;

            WAIT FOR 20 ns;

            write(write_line, STRING'("Exponent = "));
            write(write_line, S_exponent_expo_result);
            
            write(write_line, STRING'(" Mantissa = "));
            write(write_line, S_mantissa_expo_result);

            writeline(buffer_output, write_line);

            WAIT FOR 20 ns;

        END LOOP;

        file_close(buffer_input);
        file_close(buffer_output);

    END PROCESS;
END tb;