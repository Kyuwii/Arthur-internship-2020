LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top IS
    PORT (
        I_A : IN std_logic_vector(31 DOWNTO 0);
        I_B : IN std_logic_vector(31 DOWNTO 0);
        clock : IN std_logic;
        reset : IN std_logic;
        I_result : OUT std_logic_vector(31 DOWNTO 0);
        bool : OUT std_logic
    );
END top;

ARCHITECTURE behavior OF top IS
    COMPONENT subtractAdder
        GENERIC (n : INTEGER := 24);
        PORT (
            C_mantissa_adder_A : IN std_logic_vector(n - 1 DOWNTO 0);
            C_mantissa_adder_B : IN std_logic_vector(n - 1 DOWNTO 0);
            C_mantissa_adder_result : OUT std_logic_vector(n - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT alignExpo
        GENERIC (n : INTEGER := 24);
        PORT (
            C_mantissa_expo_B : IN std_logic_vector(n - 1 DOWNTO 0);
            C_exponent_expo_A : IN std_logic_vector(7 DOWNTO 0);
            C_exponent_expo_B : IN std_logic_vector(7 DOWNTO 0);
            C_mantissa_expo_result : OUT std_logic_vector(n - 1 DOWNTO 0);
            C_exponent_expo_result : OUT std_logic_vector(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT alignResult
        GENERIC (n : INTEGER := 23);
        PORT (
            C_sign_result : IN std_logic;
            C_mantissa_result : IN std_logic_vector(n - 1 DOWNTO 0);
            C_exponent_result : IN std_logic_vector(7 DOWNTO 0);
            C_result : OUT std_logic_vector(31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL S_Reg_Input_A, S_Reg_Input_B : std_logic_vector(31 DOWNTO 0);
    SIGNAL S_mantissa_expo_A, S_mantissa_expo_B : std_logic_vector(22 DOWNTO 0);
    SIGNAL S_exponent_expo_A, S_exponent_expo_B : std_logic_vector(7 DOWNTO 0);
    SIGNAL S_mantissa_adder_A : std_logic_vector(23 DOWNTO 0);
    SIGNAL S_mantissa_adder_result : std_logic_vector(23 DOWNTO 0);
    SIGNAL S_mantissa_expo_result : std_logic_vector(23 DOWNTO 0);
    SIGNAL S_exponent_expo_result : std_logic_vector(7 DOWNTO 0);
    SIGNAL S_Reg_result : std_logic_vector(31 DOWNTO 0);
    SIGNAL S_result : std_logic_vector(31 DOWNTO 0);
    SIGNAL S_Final_A : std_logic_vector(23 DOWNTO 0);
    SIGNAL S_Final_B : std_logic_vector(23 DOWNTO 0);
    SIGNAL S_sign : std_logic;

BEGIN

    algExp : alignExpo
    GENERIC MAP(
        n => 24
    )
    PORT MAP(
        C_mantissa_expo_B => S_Final_B,
        C_exponent_expo_A => S_exponent_expo_A,
        C_exponent_expo_B => S_exponent_expo_B,
        C_mantissa_expo_result => S_mantissa_expo_result,
        C_exponent_expo_result => S_exponent_expo_result
    );

    subAdd : subtractAdder
    GENERIC MAP(
        n => 24
    )
    PORT MAP(
        C_mantissa_adder_A => S_Final_A,
        C_mantissa_adder_B => S_mantissa_expo_result,
        C_mantissa_adder_result => S_mantissa_adder_result
    );

    algRes : alignResult
    GENERIC MAP(
        n => 24
    )
    PORT MAP(
        C_sign_result => S_sign,
        C_mantissa_result => S_mantissa_adder_result,  
        C_exponent_result => S_exponent_expo_result,
        C_result => S_result
    );

    PROCESS (reset, clock)
    BEGIN
        IF (reset = '1') THEN
            S_Reg_Input_A <= (OTHERS => '0');
            S_Reg_Input_B <= (OTHERS => '0');
            S_Reg_Result <= (OTHERS => '0');
        ELSIF (clock'event AND clock = '1') THEN
            S_Reg_Input_A <= I_A;
            S_Reg_Input_B <= I_B;
            S_Reg_Result <= S_Result;
        END IF;
    END PROCESS;

    S_mantissa_expo_A <= S_Reg_Input_A(22 DOWNTO 0);
    S_mantissa_expo_B <= S_Reg_Input_B(22 DOWNTO 0);

    S_exponent_expo_A <= S_Reg_Input_A(30 DOWNTO 23);
    S_exponent_expo_B <= S_Reg_Input_B(30 DOWNTO 23);

    S_Final_A <= '1' & S_mantissa_expo_A WHEN S_exponent_expo_A > S_exponent_expo_B ELSE
        '1' & S_mantissa_expo_B;
    S_Final_B <= '1' & S_mantissa_expo_B WHEN S_exponent_expo_A > S_exponent_expo_B ELSE
        '1' & S_mantissa_expo_A;

    S_sign <= '0' WHEN S_exponent_expo_A > S_exponent_expo_B else
        '1';

    I_result <= S_Reg_result;
    bool <= S_Reg_result(31);

END behavior;