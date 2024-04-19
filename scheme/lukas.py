import functools


@functools.cache
def lukas(n):
    if (n == 0):
        return 2
    if (n == 1):
        return 1

    return lukas(n-2) + lukas(n-1)


for i in range(40):
    print(f"{i}: {lukas(i)}")
