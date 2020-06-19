LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top IS
    PORT (
        I_A : IN std_logic_vector(31 DOWNTO 0);
        I_B : IN std_logic_vector(31 DOWNTO 0);
        clock : IN std_logic;
        reset : IN std_logic;
        I_result : OUT std_logic_vector(31 DOWNTO 0)
    );
END top;

ARCHITECTURE behavior OF top IS
    COMPONENT subtractAdder
        PORT (
            C_mantissa_adder_A : IN std_logic_vector(22 DOWNTO 0);
            C_mantissa_adder_B : IN std_logic_vector(22 DOWNTO 0);
            C_mantissa_adder_result : OUT std_logic_vector(22 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT alignExpo
        PORT (
            C_mantissa_expo_A : IN std_logic_vector(22 DOWNTO 0);
            C_mantissa_expo_B : IN std_logic_vector(22 DOWNTO 0);
            C_exponent_expo_A : IN std_logic_vector(7 DOWNTO 0);
            C_exponent_expo_B : IN std_logic_vector(7 DOWNTO 0);
            C_mantissa_expo_result : OUT std_logic_vector(22 DOWNTO 0);
            C_exponent_expo_result : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT alignResult
        PORT (
            C_sign_result : IN std_logic;
            C_mantissa_result : IN std_logic_vector(22 DOWNTO 0);
            C_exponent_result : IN std_logic_vector(7 DOWNTO 0);
            C_result : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL S_mantissa_expo_A, S_mantissa_expo_B : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_exponent_expo_A, S_exponent_expo_B : std_logic_vector(7 DOWNTO 0);
    SIGNAL S_mantissa_adder_A : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_mantissa_adder_result : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_mantissa_expo_result : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_exponent_expo_result : std_logic_vector(7 DOWNTO 0);
    SIGNAL S_sign_result : std_logic;
    SIGNAL S_result : std_logic_vector(31 DOWNTO 0);

BEGIN

    algExp : alignExpo
    PORT MAP(
        C_mantissa_expo_A => S_mantissa_expo_A,
        C_mantissa_expo_B => S_mantissa_expo_B,
        C_exponent_expo_A => S_exponent_expo_A,
        C_exponent_expo_B => S_exponent_expo_B,
        C_mantissa_expo_result => S_mantissa_expo_result,
        C_exponent_expo_result => S_exponent_expo_result
    );

    subAdd : subtractAdder
    PORT MAP(
        C_mantissa_adder_A => S_mantissa_adder_A,
        C_mantissa_adder_B => S_mantissa_expo_result,
        C_mantissa_adder_result => S_mantissa_adder_result
    );

    algRes : alignResult
    PORT MAP(
        C_sign_result => S_sign_result,
        C_mantissa_result => S_mantissa_adder_result,
        C_exponent_result => S_exponent_expo_result,
        C_result => S_result
    );

    PROCESS (clock)
    BEGIN
        IF (clock'event AND clock = '1') THEN
            IF (reset = '0') THEN
                S_mantissa_expo_A <= (OTHERS => '0');
                S_mantissa_expo_B <= (OTHERS => '0');
                S_exponent_expo_A <= (OTHERS => '0');
                S_exponent_expo_B <= (OTHERS => '0');
                S_mantissa_adder_A <= (OTHERS => '0');
                S_mantissa_adder_result <= (OTHERS => '0');
                S_mantissa_expo_result <= (OTHERS => '0');
                S_exponent_expo_result <= (OTHERS => '0');
                S_sign_result <= '0';
                S_result <= (OTHERS => '0');
            ELSE
                S_mantissa_expo_A <= I_A(30 DOWNTO 8);
                S_mantissa_expo_B <= I_B(30 DOWNTO 8);
                S_exponent_expo_A <= I_A(7 DOWNTO 0);
                S_exponent_expo_B <= I_B(7 DOWNTO 0);
                S_mantissa_adder_A <= I_A(30 DOWNTO 8);
            END IF;
        END IF;
    END PROCESS;

    PROCESS (clock)
    BEGIN
        IF (clock'event AND clock = '1') THEN
            I_result <= S_result;
        END IF;
    END PROCESS;
END behavior;