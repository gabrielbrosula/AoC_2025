def main():
    filename = "input/1-1.txt"
    lst = []

    with open(filename, "r") as file:
        for line in file:
            lst.append(line.strip("\n"))

    begin = 50
    count = 0
    for l in lst:
        dir = -1 if l[0] == "L" else 1
        num = dir * int(l[1::])
        result = (begin + num) % 100
        
        print(f"Begin: {begin}, Line: \"{l}\", Num: {num}, Result: {result}, Count: {count}")
        
        begin = result

        if result == 0:
            count += 1


if __name__ == "__main__":
    main()