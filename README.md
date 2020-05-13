# Arthur-internship-2020

## Version 1.0 Date 11/05/2020
Python code of the subtraction of two IEEE 754 numbers
2 files : - main.py contains the functions
                findPowerOf2(number) find the power of 2 of a number (number)
                fillWithZeroStart(number, size) fill an array (number) with a number of 0 (size) in first position
                additionBinary(numberA, numberB) addition 2 binary number (numberA and numberB) and return the result 
                complementTwo(number) invert all the bits and add 1 to a binary number (number)
                transformInInteger(number) transform the exponent of an IEEE754 number (number) into an integer
                addExponent(number) add 1 to the exponent of an IEEE754 number (number)
                shiftBitMantissa(number) insert a 0 in first position in the mantissa of an IEEE754 number (number)
                alignExponent(numberA, numberB) add 1 to the smaller exponent between 2 IEEE754 numbers (numberA and numberB) and shift to the right the mantissa of this number by 1 while it's smaller than the second number
                getMantissa(number) return the mantissa of an IEEE754 number (number)
                getExponent(number) return the exponent of an IEEE754 number (number)
                IEEE754ToFloat(number) return the decimal number of an IEEE754 number (number)
                subtractBinaries() main fonction subtract two IEEE754 number and return the result
          - floatToIEEE754.py contains the functions 
                defineInputs() define the 2 float numbers in input of the programm
                findSign(number) return 0 if (number) if positive and 1 if (number) is negative
                convertDecimal(binary) convert an binary number (binary) into an integer
                convertFloatDecimal(binary) convert an binary number (binary) into a decimal number
                convertBinary(dividend) convert a integer number (dividend) into a binary number
                decimalConvertBinary(dividend) convert a decimal number (dividend) into a binary number
                convert8Bits(number) convert a binary number (number) to 8bits format
                normalizeMantissa(exponent, mantissa, decimal) normalize the mantissa (exponent) is the length of the integer part of a floating number in binary, (mantissa) is the binary array of the integer part of this floating number and (decimal) is the binary array of the decimal part of this floating number
                appendList(list, append) append (append) to (list)
                fillWithZeros(list) fill an IEEE754 number (list) with 0 until it reach 32bits length
                convertIEE754() convert two floating numbers into IEEE754 numbers

## Execute main.py to run the programm