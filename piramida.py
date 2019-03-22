def isint(s):
    try:
        int(s)
        return True
    except ValueError:
        return False


while True:
    print('Введите высоту пирамиды от 1 до 23')
    height = input()
    if isint(height) == True:None
    else:continue
    height = int(height)
    if (height<24) and (height>0):None
    else:continue
    break

a = height
b=0
while True:
    a = a - 1
    b = b + 1
    print(' '*a, '#'*b, '#', sep='')
    if (a == 0) or ( b == height):
        break
