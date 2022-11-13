import matplotlib.pyplot as plt
import numpy as np
import math


def main():
    a = np.linspace(-50, 50, 1000)

    y = np.array(
        list(map(lambda x: ((math.e**x) * math.log(1 + math.e ** (-1 * x))), a))
    )

    fig = plt.figure()
    fig.add_subplot(1, 1, 1)

    plt.plot(a, y, "r")

    plt.savefig("plot.png")


if __name__ == "__main__":
    main()
