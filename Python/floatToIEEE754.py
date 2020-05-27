# imports
import math

def defineInputs():
    a = 10#input("Input float number a : ")
    b = 5.5#input("Input float number b : ")
    return a, b

def findSign(number):
    if number >= 0:
        return 0
    else:
        return 1 

def convertDecimal(binary):
    results = 0
    for i in range(0, len(binary)):
        results = results + binary[len(binary) - i - 1] * pow(2, i)
    return results

def convertFloatDecimal(binary):
    results = 0
    for i in range(0, len(binary)):
        results = results + binary[i] * pow(2, -i - 1)
    return results

def convertBinary(dividend):
    results = []
    while dividend > 0:
        temp = dividend % 2
        dividend = dividend // 2
        results.append(int(temp))
    results.reverse()
    return results

def decimalConvertBinary(dividend):
    results = []
    while dividend > 0:
        dividend = dividend * 2
        number = math.modf(float(dividend))
        dividend = number[0]
        results.append(int(number[1]))
    return results

def convert8Bits(number):   
    if len(number) < 8:
        for i in range(len(number), 8):
            number.insert(0, 0)
        return number
    elif len(number) == 8:
        return number
    else:
        print("Error")

def normalizeMantissa(exponent, mantissa, decimal):
    for i in range(0, exponent):
        decimal.insert(0, mantissa[exponent - i])
    return decimal

def appendList(list, append):
    for i in range(0, len(append)):
        list.append(append[i])
    return list

def fillWithZeros(list):
    for i in range(len(list), 32):
        list.append(0)
    return list

def convertIEE754():
    # define the inputs
    inputs = defineInputs()

    # separate the whole and the decimal part of each input 
    numberA = math.modf(float(inputs[0]))
    numberB = math.modf(float(inputs[1]))
    # the first cell of numberA is the decimal and the second cell is the integer 
    
    # convert in binary the integer part of the inputs
    binaryA = convertBinary(numberA[1])
    binaryB = convertBinary(numberB[1])

    # convert in binary the decimal part of the inputs
    binaryDecimalA = decimalConvertBinary(numberA[0])
    binaryDecimalB = decimalConvertBinary(numberB[0])

    # find the exponent 
    exponentA = len(binaryA) - 1
    exponentB = len(binaryB) - 1

    # normalize the mantissa
    normalizeMatissaA = normalizeMantissa(exponentA, binaryA, binaryDecimalA)
    normalizeMatissaB = normalizeMantissa(exponentB, binaryB, binaryDecimalB)

    # find the biased exponent
    biasedExponentA = 127 + exponentA
    biasedExponentB = 127 + exponentB

    # convert in binary the biased exponents
    binaryExponentA = convertBinary(biasedExponentA)
    binaryExponentB = convertBinary(biasedExponentB)

    # put it in 8 bits format
    convert8Bits(binaryExponentA)
    convert8Bits(binaryExponentB)

    # write the numbers in IEEE754
    A = []
    B = []

    # put the sign bit in first
    A.append(findSign(numberA[1]))
    B.append(findSign(numberB[1]))

    # then the exponent
    appendList(A, binaryExponentA)
    appendList(B, binaryExponentB)

    # the the mantissa
    appendList(A, normalizeMatissaA)
    appendList(B, normalizeMatissaB)
    
    # and fill the rest of the 32 bits with 0s
    fillWithZeros(A)
    fillWithZeros(B)

    return A, B

def prettyPrint(ieee754num):
    sign, exp, mant = ieee754num[0], ieee754num[1:9], ieee754num[9:]
    exp = ''.join(map(str, exp))
    mant = ''.join(map(str, mant))

    pretty = '%s | %s | %s' % (sign, exp, mant)
    return pretty