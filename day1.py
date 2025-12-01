
with open("input", "r", encoding='utf-8') as file:
    lines = file.readlines()



def part1():
    start = 50
    score = 0
    for line in lines:
        before = start
        if line[0] == "L":
            start -= int(line[1:])
        if line[0] == "R":
            start += int(line[1:])

        start = start % 100

        if start == 0:
            score += 1

    print(score)


def part2():
    start = 50
    score = 0
    for line in lines:
        before = start
        if line[0] == "L":
            cur = -int(line[1:])
        if line[0] == "R":
            cur = int(line[1:])

        do_not_count_first = before == 0

        for i in range(abs(cur)):

            if line[0] == "L":
                sign = -1
            if line[0] == "R":
                sign = 1

            start += sign

            if start > 99:
                start = 0

            elif start < 0:
                start = 99

            if start == 0:
                score += 1

    print(score)

part1()
part2()
