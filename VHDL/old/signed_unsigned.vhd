LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY signed_unsigned IS
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
END signed_unsigned;

ARCHITECTURE behave OF signed_unsigned IS
    SIGNAL rs_SUM_RESULT : signed(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ru_SUM_RESULT : unsigned(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL rs_SUB_RESULT : signed(4 DOWNTO 0) := (OTHERS => '0');
    SIGNAL ru_SUB_RESULT : unsigned(4 DOWNTO 0) := (OTHERS => '0');

BEGIN

    -- Purpose: Add two numbers.  Does both the signed and unsigned
    -- addition for demonstration.  This process is synthesizable.
    p_SUM : PROCESS (i_clk, i_rst_l)
    BEGIN
        IF i_rst_l = '0' THEN -- asynchronous reset (active low)
            rs_SUM_RESULT <= (OTHERS => '0');
            ru_SUM_RESULT <= (OTHERS => '0');
        ELSIF rising_edge(i_clk) THEN

            ru_SUM_RESULT <= unsigned(i_a) + unsigned(i_b);
            rs_SUM_RESULT <= signed(i_a) + signed(i_b);

            rs_SUM_res <= rs_SUM_RESULT;
            ru_SUM_res <= ru_SUM_RESULT;

        END IF;

    END PROCESS p_SUM;
    -- Purpose: Subtract two numbers.  Does both the signed and unsigned
    -- subtraction for demonstration.  This process is synthesizable.
    p_SUB : PROCESS (i_clk, i_rst_l)
    BEGIN
        IF i_rst_l = '0' THEN -- asynchronous reset (active low)
            rs_SUB_RESULT <= (OTHERS => '0');
            ru_SUB_RESULT <= (OTHERS => '0');
        ELSIF rising_edge(i_clk) THEN

            ru_SUB_RESULT <= unsigned(i_a) - unsigned(i_b);
            rs_SUB_RESULT <= signed(i_a) - signed(i_b);

            rs_SUB_res <= rs_SUB_RESULT;
            ru_SUB_res <= ru_SUB_RESULT;

        END IF;

    END PROCESS p_SUB;

    rs_SUM_res <= rs_SUM_RESULT;
    ru_SUM_res <= ru_SUM_RESULT;
    rs_SUB_res <= rs_SUB_RESULT;
    ru_SUB_res <= ru_SUB_RESULT;

END behave;