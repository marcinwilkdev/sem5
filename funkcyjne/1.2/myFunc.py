def myFunc(x, y):
    return (lambda z: (lambda w: z + 2 * w))(x * y)


def main():
    print(myFunc(3, 5)(2))


if __name__ == "__main__":
    main()
