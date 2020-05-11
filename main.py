import floatToIEEE754

# WORK IN PROGRESS
# warning in this version the normalize for the exponent is missing

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

def subtractBinaries():
    inputs = floatToIEEE754.convertIEE754()

    numberA = inputs[0]
    numberB = inputs[1]

    # TODO normalize the exponent for the smaller exponent of the two numbers 
    
    print(numberA, numberB)
    negativeNumberB = complementTwo(numberB)

    result = additionBinary(numberA, negativeNumberB)
    return result

print(subtractBinaries())