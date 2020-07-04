LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY alignResult_tb IS
END alignResult_tb;

ARCHITECTURE tb OF alignResult_tb IS

    COMPONENT alignResult
        GENERIC (n : INTEGER := 23);
        PORT (
            C_sign_result : IN std_logic;
            C_mantissa_result : IN std_logic_vector(22 DOWNTO 0);
            C_exponent_result : IN std_logic_vector(7 DOWNTO 0);
            C_result : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL S_sign_result : std_logic;
    SIGNAL S_mantissa_result : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_exponent_result : std_logic_vector(7 DOWNTO 0);
    SIGNAL S_result : std_logic_vector(31 DOWNTO 0);

    FILE buffer_input : text;
    FILE buffer_output : text;

BEGIN

    UTT : alignResult
    PORT MAP(
        C_sign_result => S_sign_result,
        C_mantissa_result => S_mantissa_result,
        C_exponent_result => S_exponent_result,
        C_result => S_result
    );

    TB : PROCESS
        VARIABLE write_line : line;
        VARIABLE buffer_space : CHARACTER;
        VARIABLE read_line : line;
        VARIABLE V_sign_result : std_logic;
        VARIABLE V_mantissa_result : std_logic(22 DOWNTO 0);
        VARIABLE V_exponent_result : std_logic(7 DOWNTO 0);
    BEGIN
    
        file_open(buffer_input, "inputsAlignResult.txt", read_mode);
        file_open(buffer_output, "outputsAlignResult.txt", write_mode);

        WHILE NOT endfile(buffer_input) LOOP
            readline(buffer_input, read_line);

            read(read_line, V_sign_result);
            read(read_line, buffer_space);

            read(read_line, V_exponent_result);
            read(read_line, buffer_space);

            read(read_line, V_mantissa_result);
            read(read_line, buffer_space);

            WAIT FOR 20 ns;

            S_sign_result <= V_sign_result;
            S_mantissa_result <= V_mantissa_result;
            S_exponent_result <= V_exponent_result;

            WAIT FOR 20 ns;

            
            write(write_line, STRING'("Result = "));
            write(write_line, S_result);

            writeline(buffer_output, write_line);

            WAIT FOR 20 ns;

        END LOOP;

        file_close(buffer_input);
        file_close(buffer_output);

        WAIT FOR 20 ns;

    END PROCESS;
END tb;