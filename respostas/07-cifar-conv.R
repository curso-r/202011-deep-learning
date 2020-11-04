# Ajuste uma rede neural para prever as classes do CIFAR10.

base <- dataset_cifar10()
x <- base$train$x/256
y <- to_categorical(base$train$y)

dim(x)
dim(y)

# Model definition ---------------------------------------------

input <- layer_input(shape = c(32,32,3))
output <- input %>% 
  layer_conv_2d(filters = 32, kernel_size = c(3,3), activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_conv_2d(filters = 64, kernel_size = c(3,3), activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_conv_2d(filters = 128, kernel_size = c(3,3), activation = "relu") %>% 
  layer_max_pooling_2d(pool_size = c(2,2)) %>% 
  layer_flatten() %>% 
  layer_dense(units = 128, activation = "relu") %>% 
  layer_dense(units = 10, activation = "softmax")

model <- keras_model(input, output)

model %>% 
  compile(
    loss = "categorical_crossentropy",
    optimizer = "sgd",
    metrics = "accuracy"
  )

# Model fitting ------------------------------------------------

model %>% 
  fit(x, y, batch_size = 32, epochs = 30, validation_split = 0.25)
