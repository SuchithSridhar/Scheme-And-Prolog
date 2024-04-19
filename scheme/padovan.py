from functools import cache


@cache
def padovan(n):
    if (n in (0, 1, 2)):
        return 1

    return padovan(n-2) + padovan(n-3)


for i in range(101):
    print(f"{i}: {padovan(i)}")

print(f"{1000}: {padovan(1000)}")
