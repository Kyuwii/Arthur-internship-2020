LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY comparison IS
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
END comparison;

ARCHITECTURE behavior OF comparison IS
    SIGNAL A, B, C : std_logic;
    SIGNAL D, IsExponentNull, IsMantissaNull : std_logic;
    SIGNAL SubtractionExponent : std_logic_vector(e DOWNTO 0);
    SIGNAL SubtractionMantissa : std_logic_vector(m DOWNTO 0);
BEGIN

    --Test if the sign bits are equal 
    D <= Number_A(n - 1) XOR Number_B(n - 1);
    A <= Number_B(n - 1) AND D;
    --A = 1 if Number_A(n - 1) = 0 AND Number_B(n - 1) = 1

    --Subtract the exponents 
    B <= '1' WHEN Number_A(n - 2 DOWNTO n - 1 - e) >= Number_B(n - 2 DOWNTO n - 1 - e) ELSE
        '0';
    IsExponentNull <= '1' WHEN (Number_A(n - 2 DOWNTO n - 1 - e) = Number_B(n - 2 DOWNTO n - 1 - e)) ELSE 
        '0';
    
    --Subtract the mantissas
    C <= '1' WHEN Number_A(n - 2 - e DOWNTO 0) >= Number_B(n - 2 - e DOWNTO 0) ELSE
        '0';
    AGreaterThanB <= A OR (B AND (NOT A)) OR (C AND IsExponentNull);

END behavior;