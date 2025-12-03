def main():
    filename = "input/2.txt"
    input = ""

    with open(filename, "r") as file:
        for line in file:
            input = line.strip("\n")

    ranges = input.split(",")

    invalidIds = set()
    for r in ranges:
        rangeNums = r.split("-")
        low = int(rangeNums[0])
        high = int(rangeNums[1])
        seq = list(range(low, high + 1))

        for num in seq:
            numStr = str(num)

            # Create valid patterns for num
            patterns = create_pattern(numStr)

            for p in patterns:
                later = numStr[len(p)::]
                substrings = split_by_n(later, len(p))
                result = all(x == p for x in substrings)

                if (result):
                    invalidIds.add(num)
                    break
    
    print(invalidIds)
    print(sum(invalidIds))

def create_pattern(num):
    numStr = str(num)
    patterns = []
    for i in range(1, len(numStr) // 2 + 1):
        patterns.append(numStr[0:i])
    
    return patterns

def split_by_n(string, n):
    substrings = []
    for i in range(0, len(string), n):
        if (i + n <= len(string)):
            substrings.append(string[i:i+n])
        else:
            substrings.append(string[i::])

    return substrings

if __name__ == "__main__":
    main()