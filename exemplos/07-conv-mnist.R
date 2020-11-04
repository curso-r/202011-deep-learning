# Dataset

library(keras)

base <- dataset_mnist()
x <- array_reshape(base$train$x/256, dim = c(60000, 28, 28, 1))
y <- to_categorical(base$train$y)

dim(x)
dim(y)

# Model definition ---------------------------------------------

input <- layer_input(shape = c(28, 28, 1))

output <- input %>% 
  layer_conv_2d(kernel_size = c(3,3), filters = 32, activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_conv_2d(kernel_size = c(3,3), filters = 64, activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_flatten() %>% 
  layer_dense(128, activation = "relu") %>% 
  layer_dense(10, activation = "softmax") 
  

model <- keras_model(input, output)

model %>% 
  compile(
    loss = "categorical_crossentropy",
    optimizer = "sgd",
    metrics = "accuracy"
  )

# Model fitting ------------------------------------------------

model %>% 
  fit(x, y, batch_size = 32, epochs = 5, validation_split = 0.2)  


