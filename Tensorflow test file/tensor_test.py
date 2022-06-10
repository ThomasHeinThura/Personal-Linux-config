import tensorflow as tf
from tensorflow import keras
import numpy as np
import matplotlib as plt
import time

(x_train, y_train), (x_test,y_test) = keras.datasets.cifar10.load_data()

#checking images shape
x_train.shape, x_test.shape

#checking labels
y_train[:5]

#scaling image values between 0-1
x_train_scaled = x_train/255
x_test_scaled = x_test/255

#one hot encolding labels
y_train_encoded = keras.utils.to_categorical(y_train, num_classes = 10, dtype= 'float32')
y_test_encoded = keras.utils.to_categorical(y_test, num_classes = 10, dtype = 'float32')

#Building model

def get_model():
    model = keras.Sequential([
        keras.layers.Flatten(input_shape=(32,32,3)),
        keras.layers.Dense(3000, activation='relu'),
        keras.layers.Dense(1000, activation='relu'),
        keras.layers.Dense(10, activation='sigmoid')
    ])
    model.compile(optimizer='SGD',
              loss='categorical_crossentropy',
              metrics=['accuracy'])
    return model

start_time = time.time()

#GPU
with tf.device('/GPU:0'):
    model_gpu = get_model()
    model_gpu.fit(x_train_scaled,y_train_encoded, epochs = 10)

end_time = time.time()

print(f"This test is trained with RTX 3060 for : {end_time-start_time}")
