LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;

ENTITY example_signed_unsigned_tb IS
END example_signed_unsigned_tb;

ARCHITECTURE behave OF example_signed_unsigned_tb IS

    --Registers
    SIGNAL r_CLK : std_logic := '0';
    SIGNAL r_RST_L : std_logic := '0';
    SIGNAL r_A : NATURAL := 0;
    SIGNAL r_B : NATURAL := 0;
    SIGNAL r_A_SLV : std_logic_vector(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL r_B_SLV : std_logic_vector(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_rs_SUM_res : signed(4 DOWNTO 0);
    SIGNAL s_ru_SUM_res : unsigned(4 DOWNTO 0);
    SIGNAL s_rs_SUB_res : signed(4 DOWNTO 0);
    SIGNAL s_ru_SUB_res : unsigned(4 DOWNTO 0);

    FILE buffer_output : text;

    CONSTANT c_CLK_PERIOD : TIME := 10 ns;

    COMPONENT example_signed_unsigned IS
        PORT (
            i_rst_l : IN std_logic;
            i_clk : IN std_logic;
            i_a : IN std_logic_vector(4 DOWNTO 0);
            i_b : IN std_logic_vector(4 DOWNTO 0);
            rs_SUM_res : OUT signed(4 DOWNTO 0);
            ru_SUM_res : OUT unsigned(4 DOWNTO 0);
            rs_SUB_res : OUT signed(4 DOWNTO 0);
            ru_SUB_res : OUT unsigned(4 DOWNTO 0)
        );
    END COMPONENT example_signed_unsigned;

BEGIN

    i_DUT : example_signed_unsigned
    PORT MAP(
        i_rst_l => r_RST_L,
        i_clk => r_CLK,
        i_a => r_A_SLV,
        i_b => r_B_SLV,
        rs_SUM_res => s_rs_SUM_res,
        ru_SUM_res => s_ru_SUM_res,
        rs_SUB_res => s_rs_SUB_res,
        ru_SUB_res => s_ru_SUB_res
    );
    clk_gen : PROCESS IS
    BEGIN
        r_CLK <= '0' AFTER c_CLK_PERIOD/2, '1' AFTER c_CLK_PERIOD;
        WAIT FOR c_CLK_PERIOD;
    END PROCESS clk_gen;

    PROCESS
        VARIABLE write_line : line;
        VARIABLE buffer_space : CHARACTER;
        VARIABLE read_line : line;
    BEGIN

        file_open(buffer_output, "values.txt", write_mode);

        r_RST_L <= '0';
        WAIT FOR 20 ns;
        r_RST_L <= '1';
        WAIT FOR 20 ns;

        r_A_SLV <= "01001";
        r_B_SLV <= "00110";
        WAIT FOR 20 ns;

        write(write_line, std_logic_vector(s_rs_SUM_res));
        write(write_line, std_logic_vector(s_ru_SUM_res));
        write(write_line, std_logic_vector(s_rs_SUB_res));
        write(write_line, std_logic_vector(s_rs_SUB_res));
        writeline(buffer_output, write_line);
        WAIT;

        file_close(buffer_output);

    END PROCESS;

END behave;