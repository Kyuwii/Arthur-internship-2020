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
    if len(numberA) == len(numberB):
        pass
    elif len(numberA) < len(numberB):
        fillWithZeroStart(numberA, len(numberB) - len(numberA))
    else:
        fillWithZeroStart(numberB, len(numberA) - len(numberB))
    # if findPowerOf2(numberA) == findPowerOf2(numberB):
    #     pass
    # elif findPowerOf2(numberA) < findPowerOf2(numberB):
    #     fillWithZeroStart(numberA, findPowerOf2(numberB) - len(numberA))
    #     fillWithZeroStart(numberB, findPowerOf2(numberB) - len(numberB))
    # else:
    #     fillWithZeroStart(numberB, findPowerOf2(numberA) - len(numberB))
    #     fillWithZeroStart(numberA, findPowerOf2(numberA) - len(numberA))

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
    for i in range(0, len(number)):
        result = result + number[i] * pow(10, len(number) - i - 1)
    return result

def addExponent(number):
    addition = [1]
    result = additionBinary(number, addition)
    return result

def shiftBitMantissa(number):
    number.pop()
    number.insert(0, 0)
    return number

def alignExponent(numberA, numberB):
    exponentA = getExponent(numberA)
    exponentB = getExponent(numberB)
    mantissaA = getMantissa(numberA)
    mantissaB = getMantissa(numberB)

    mantissaA.insert(0, 1)
    mantissaB.insert(0, 1)

    if transformInInteger(exponentA) == transformInInteger(exponentB):
        return numberA, numberB
    elif transformInInteger(exponentA) < transformInInteger(exponentB):
        while transformInInteger(exponentA) < transformInInteger(exponentB):
            exponentA = addExponent(exponentA)
            mantissaA = shiftBitMantissa(mantissaA)
    else:
        while transformInInteger(exponentB) < transformInInteger(exponentA):
            exponentB = addExponent(exponentB)
            mantissaB = shiftBitMantissa(mantissaB)

    mantissaA.pop(0)
    mantissaB.pop(0)

    newNumberA = []
    newNumberB = []

    newNumberA.append(numberA[0])
    floatToIEEE754.appendList(newNumberA, exponentA)
    floatToIEEE754.appendList(newNumberA, mantissaA)

    newNumberB.append(numberB[0])
    floatToIEEE754.appendList(newNumberB, exponentB)
    floatToIEEE754.appendList(newNumberB, mantissaB)
  
    return newNumberA, newNumberB

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

    numbers = alignExponent(numberA, numberB)
  
    numberA = numbers[0]
    numberB = numbers[1]

    if numberB[0] == 0:
        mantissaB = complementTwo(getMantissa(numberB))
    
    mantissaA = getMantissa(numberA)
    mantissaR = additionBinary(mantissaA, mantissaB)

    R = []
    R.insert(0, 0)

    floatToIEEE754.appendList(R, getExponent(numberA))
    floatToIEEE754.appendList(R, mantissaR)
    
    return R

R = subtractBinaries()
print("Result   = ", R, "in decimal =", IEEE754ToFloat(R))

