LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY comparison_tb IS
    GENERIC (
        n : INTEGER := 32;
        m : INTEGER := 23;
        e : INTEGER := 8
    );
END comparison_tb;

ARCHITECTURE tb OF comparison_tb IS
    COMPONENT comparison
        GENERIC (
            n : INTEGER := 32;
            m : INTEGER := 23;
            e : INTEGER := 8
        );
        PORT (
            Number_A : IN std_logic_vector(n - 1 DOWNTO 0);
            Number_B : IN std_logic_vector(n - 1 DOWNTO 0);
            Clk : IN std_logic;
            Reset : IN std_logic;
            AGreaterThanB : OUT std_logic
        );
    END COMPONENT;

    SIGNAL S_Number_A, S_Number_B : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_Clk, S_Reset, S_AGreaterThanB : std_logic;

    FILE buffer_input : text;
    FILE buffer_output : text;

BEGIN

    UTT : comparison
    GENERIC MAP(
        n => 32,
        m => 23,
        e => 8
    )
    PORT MAP(
        Number_A => S_Number_A,
        Number_B => S_Number_B,
        Clk => S_Clk,
        Reset => S_Reset,
        AGreaterThanB => S_AGreaterThanB
    );

    TB : PROCESS

        VARIABLE write_line, read_line : line;
        VARIABLE buffer_space : CHARACTER;

        VARIABLE I_Number_A, I_Number_B : std_logic_vector(n - 1 DOWNTO 0);

    BEGIN

        file_open(buffer_input, "inputsComparison.txt", read_mode);
        file_open(buffer_output, "outputsComparison.txt", write_mode);

        WHILE NOT endfile(buffer_input) LOOP

            readline(buffer_input, read_line);

            read(read_line, I_Number_A);
            read(read_line, buffer_space);
            read(read_line, I_Number_B);

            WAIT FOR 20 ns;

            S_Number_A <= I_Number_A;
            S_Number_B <= I_Number_B;

            S_Clk <= '1';
            S_Reset <= '0';

            WAIT FOR 20 ns;

            write(write_line, S_AGreaterThanB);
            writeline(buffer_output, write_line);

            WAIT FOR 20 ns;

        END LOOP;

        file_close(buffer_input);
        file_close(buffer_output);

    END PROCESS;

END tb;