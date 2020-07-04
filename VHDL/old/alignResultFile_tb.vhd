LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE STD.textio.ALL;
USE ieee.std_logic_textio.ALL;

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
    FILE file_result : text;
    FILE file_inputs : text;
BEGIN

    UTT : alignResult
    PORT MAP(
        C_sign_result => S_sign_result,
        C_mantissa_result => S_mantissa_result,
        C_exponent_result => S_exponent_result,
        C_result => S_result
    );

    TB : PROCESS
        VARIABLE v_iline : line;
        VARIABLE v_oline_result : line;
        VARIABLE v_sign : std_logic;
        VARIABLE v_mantissa : std_logic_vector(22 DOWNTO 0);
        VARIABLE v_exponent : std_logic_vector(7 DOWNTO 0);
        VARIABLE v_space : CHARACTER;

    BEGIN
        file_open(file_inputs, "inputs.txt", read_mode);
        file_open(file_result, "o_result.txt", write_mode);
        WHILE NOT endfile(file_inputs) LOOP
            readline(file_inputs, v_iline);

            read(v_iline, v_sign);
            read(v_iline, v_space);
            read(v_iline, v_mantissa);
            read(v_iline, v_space);
            read(v_iline, v_exponent);
            S_sign_result <= v_sign;
            S_mantissa_result <= v_mantissa;
            S_exponent_result <= v_exponent;

            WAIT FOR 20 ns;

            write(v_oline_result, S_result);
            writeline(file_result, v_oline_result);
        END LOOP;
        file_close(file_inputs);
        file_close(file_result);

        WAIT;
    END PROCESS;
END tb;