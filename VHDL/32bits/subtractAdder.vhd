LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_signed.ALL;

ENTITY subtractAdder IS
    GENERIC (n : INTEGER := 23);
    PORT (
        C_mantissa_adder_A : IN std_logic_vector(n - 1 DOWNTO 0);
        C_mantissa_adder_B : IN std_logic_vector(n - 1 DOWNTO 0);
        C_mantissa_adder_result : OUT std_logic_vector(n DOWNTO 0)
    );
END subtractAdder;

ARCHITECTURE behavior OF subtractAdder IS
    SIGNAL operation : std_logic;
BEGIN
    operation <= C_mantissa_adder_A(n - 1) XOR C_mantissa_adder_B(n - 1); 
    WITH operation SELECT
        C_mantissa_adder_result <= (C_mantissa_adder_A(n - 1) & C_mantissa_adder_A) - (C_mantissa_adder_B(n - 1) & C_mantissa_adder_B) WHEN '0',
        (C_mantissa_adder_A(n - 1) & C_mantissa_adder_A) + (C_mantissa_adder_B(n - 1) & C_mantissa_adder_B) WHEN '1',
        (OTHERS => '0') WHEN OTHERS;
        
END behavior;