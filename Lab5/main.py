from sklearn import datasets
import numpy as np
import funcs
from scipy import misc
import cv2

digits = datasets.load_digits()

# DEBUG
if False:
	image = digits.images[44]
	text = digits.target[44]
	funcs.show(image, text)
	quit()

x = 100 #length of training data set
X_train = digits.data[0:x]
Y_train = digits.target[0:x]

# valid: 31, 71

# image
image_gray = cv2.imread("input71.png", 0)
image_inverted = 255 - image_gray
image_square = cv2.resize(image_inverted, dsize=(8, 8), interpolation=cv2.INTER_CUBIC)
for i in range(len(image_square)):
	for j in range(len(image_square)):
		image_square[i][j] = int(image_square[i][j] / 17)

# normalize
image_array = np.reshape(image_square, 64)
image_array = np.array(image_array)
maximum = np.amax(image_array)
image_array = image_array / maximum
# Running Nearest Neighbour Classifier
l = len(X_train)
distance = np.zeros(l) #This will store the distance of test from every training value
for i in range(l):
	distance[i] = funcs.dist(X_train[i],image_array)
min_index = np.argmin(distance)
# print image_array
text = f"Predicted value: {Y_train[min_index]}"
funcs.show(image_square, text)