import numpy as np
import matplotlib.pyplot as plt

def dist(x: np.array, y: np.array):
    return np.sqrt(np.sum((x-y)**2))

def show(image: np.array, text: str):
    fig = plt.figure()
    plt.imshow(image, cmap = plt.cm.gray_r)
    plt.title(text)
    plt.show()