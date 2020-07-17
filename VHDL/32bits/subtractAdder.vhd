LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY subtractAdder IS
    GENERIC (n : INTEGER := 24);
    PORT (
        C_mantissa_adder_A : IN std_logic_vector(n - 1 DOWNTO 0);
        C_mantissa_adder_B : IN std_logic_vector(n - 1 DOWNTO 0);
        C_mantissa_adder_result : OUT std_logic_vector(n - 1 DOWNTO 0)
    );
END subtractAdder;

ARCHITECTURE behavior OF subtractAdder IS
    SIGNAL S_mantissa_A : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_mantissa_B : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    S_mantissa_A <= C_mantissa_adder_A WHEN C_mantissa_adder_A > C_mantissa_adder_B ELSE
        C_mantissa_adder_B;

    S_mantissa_B <= C_mantissa_adder_B WHEN C_mantissa_adder_A > C_mantissa_adder_B ELSE
        C_mantissa_adder_A;

    C_mantissa_adder_result <= S_mantissa_A - S_mantissa_B;
        
END behavior;