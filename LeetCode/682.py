def calPoints(ops):
    """
    :type ops: List[str]
    :rtype: int
    """
    stack = []
    for index in range(len(ops)):
        item = ops[index]
        if item is "+":
            stack.append(int(stack[-1]) + int(stack[-2]))
        elif item is "C":
            stack.pop()
        elif item is "D":
            stack.append(int(stack[-1]) * 2)
        else:
            stack.append(int(item))
    return sum(stack)

        
def main():
    sum = calPoints(["1","2","3","+","D","9","D","C","D"])
    print(sum)


# 执行
main()
