LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY comparison16bits_tb IS
    GENERIC (
        n : INTEGER := 16;
        m : INTEGER := 10;
        e : INTEGER := 5
    );
END comparison16bits_tb;

ARCHITECTURE tb OF comparison16bits_tb IS
    COMPONENT comparison16bits
        GENERIC (
            n : INTEGER := 16;
            m : INTEGER := 10;
            e : INTEGER := 5
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

    UTT : comparison16bits
    GENERIC MAP(
        n => 16,
        m => 10,
        e => 5
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

      
        S_Reset <= '1';
        WAIT FOR 20 ns;
        S_Reset <= '0';

        file_open(buffer_input, "inputsComparison16bits.txt", read_mode);
        file_open(buffer_output, "outputsComparison16bits.txt", write_mode);

        WHILE NOT endfile(buffer_input) LOOP

            readline(buffer_input, read_line);

            read(read_line, I_Number_A);
            read(read_line, buffer_space);
            read(read_line, I_Number_B);

            S_Number_A <= I_Number_A;
            S_Number_B <= I_Number_B;

            WAIT FOR 20 ns;

            write(write_line, S_AGreaterThanB);
            writeline(buffer_output, write_line);

        END LOOP;

        file_close(buffer_input);
        file_close(buffer_output);

    END PROCESS;

    CLOCK : PROCESS

    BEGIN

        S_Clk <= '0';
        WAIT FOR 20 ns;
        S_Clk <= '1';
        WAIT FOR 20 ns;

    END PROCESS;

END tb;