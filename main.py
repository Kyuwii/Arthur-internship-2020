import floatToIEEE754

def findPowerOf2(number):
    size = len(number)
    result = 0
    indice = 0
    while result < size:
        result = pow(2, indice)
        indice = indice + 1
    return result

def fillWithZeroStart(number, size):
    for i in range(0, size):
        number.insert(0, 0)
    return number

def additionBinary(numberA, numberB):
    if findPowerOf2(numberA) == findPowerOf2(numberB):
        pass
    elif findPowerOf2(numberA) < findPowerOf2(numberB):
        fillWithZeroStart(numberA, findPowerOf2(numberB) - len(numberA))
        fillWithZeroStart(numberB, findPowerOf2(numberB) - len(numberB))
    else:
        fillWithZeroStart(numberB, findPowerOf2(numberA) - len(numberB))
        fillWithZeroStart(numberA, findPowerOf2(numberA) - len(numberA))

    results = []
    carry = 0
    for i in range(0, len(numberA)):
        results.insert(0, (numberA[len(numberA) - i - 1] + numberB[len(numberA) - i - 1] + carry) % 2)
        if numberA[len(numberA) - i - 1] + numberB[len(numberA) - i - 1] + carry >= 2:
            carry = 1
        else:
            carry = 0
    return results

def complementTwo(number):
    results = []
    complement = [1]
    fillWithZeroStart(number, findPowerOf2(number) - len(number))
    for i in range(0, len(number)):
        if number[i] == 0:
            results.append(1)
        elif number[i] == 1:
            results.append(0)
        else:
            print("Error")
    return additionBinary(results, complement)

def transformInInteger(number):
    result = 0
    for i in range(1, 9):
        result = result + number[i] * pow(10, 8 - i)
    return result

def addExponent(number):
    exponent = []
    for i in range(1, 9):
        exponent.insert(i - 1, number[i])
    addition = [1]
    newExponent = additionBinary(exponent, addition)
    for i in range(2, 9):
        number[i] = newExponent[i - 1]
    return number

def shiftBitMantissa(number):
    number.pop()
    number.insert(9, 0)
    return number

def alignExponent(numberA, numberB):
    if transformInInteger(numberA) == transformInInteger(numberB):
        return numberA, numberB
    elif transformInInteger(numberA) < transformInInteger(numberB):
        while transformInInteger(numberA) < transformInInteger(numberB):
            addExponent(numberA)
            shiftBitMantissa(numberA)
    else:
        while transformInInteger(numberB) < transformInInteger(numberA):
            addExponent(numberB)
            shiftBitMantissa(numberB)
    return numberA, numberB

def getMantissa(number):
    mantissa = []
    for i in range(9, 32):
        mantissa.insert(i - 9, number[i])
    return mantissa

def getExponent(number):
    exponent = []
    for i in range(1, 9):
        exponent.insert(i - 1, number[i])
    return exponent

def IEEE754ToFloat(number):
    binaryExponent = getExponent(number)
    exponent = floatToIEEE754.convertDecimal(binaryExponent)
    shift = exponent - 127
    mantissa = [1]
    for i in range(0, shift):
        mantissa.append(number[i + 9])
    result = floatToIEEE754.convertDecimal(mantissa)
    decimal = []
    for i in range(9 + shift, 32):
        decimal.append(number[i])
    result = result + floatToIEEE754.convertFloatDecimal(decimal)
    if number[0] == 0:
        return result
    else:
        return -result

def subtractBinaries():
    inputs = floatToIEEE754.convertIEE754()

    numberA = inputs[0]
    numberB = inputs[1]

    print("number A = ", numberA, "in decimal =", IEEE754ToFloat(numberA))
    print("number B = ", numberB, "in decimal =", IEEE754ToFloat(numberB))

    alignExponent(numberA, numberB)

    print("number A = ", numberA, "in decimal =", IEEE754ToFloat(numberA))
    print("number B = ", numberB, "in decimal =", IEEE754ToFloat(numberB))

    mantissaA = getMantissa(numberA)
    mantissaB = getMantissa(numberB)
    exponent = getExponent(numberA)
    negativeNumberB = complementTwo(mantissaB)

    result = additionBinary(mantissaA, negativeNumberB)

    floatToIEEE754.appendList(exponent, result)

    exponent.insert(0, 0)

    return exponent

result = subtractBinaries()
print("results = ", result, "in decimal =", IEEE754ToFloat(result))