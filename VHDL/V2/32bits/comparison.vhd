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
    SIGNAL S_Number_A, S_Number_B : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL S_AGreaterThanB : std_logic;
    SIGNAL A, B, C : std_logic;
    SIGNAL D, IsExponentNull, IsMantissaNull : std_logic;
    SIGNAL SubtractionExponent : std_logic_vector(e DOWNTO 0);
    SIGNAL SubtractionMantissa : std_logic_vector(m DOWNTO 0);
BEGIN

    --Test if the sign bits are equal 
    D <= S_Number_A(n - 1) XOR S_Number_B(n - 1);
    A <= S_Number_B(n - 1) AND D;
    --A = 1 if Number_A(n - 1) = 0 AND Number_B(n - 1) = 1

    --Subtract the exponents 
    B <= '1' WHEN S_Number_A(n - 2 DOWNTO n - 1 - e) >= S_Number_B(n - 2 DOWNTO n - 1 - e) ELSE
        '0';
    IsExponentNull <= '1' WHEN (S_Number_A(n - 2 DOWNTO n - 1 - e) = S_Number_B(n - 2 DOWNTO n - 1 - e)) ELSE 
        '0';
    
    --Subtract the mantissas
    C <= '1' WHEN S_Number_A(n - 2 - e DOWNTO 0) >= S_Number_B(n - 2 - e DOWNTO 0) ELSE
        '0';
    S_AGreaterThanB <= A OR (B AND (NOT A)) OR (C AND IsExponentNull);

    PROCESS(Clk, reset)
        --add register with clock
        BEGIN
            IF (reset = '1') THEN
                S_Number_A <= (others => '0');
                S_Number_B <= (others => '0');
            ELSIF (Clk'event AND Clk = '1') THEN
                S_Number_A <= Number_A;
                S_Number_B <= Number_B;
                AGreaterThanB <= S_AGreaterThanB;
            END IF;

    END PROCESS;

END behavior;