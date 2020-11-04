# Dataset

library(keras)

base <- dataset_cifar10()
x <- base$train$x/256
y <- to_categorical(base$train$y)

dim(x)
dim(y)

# Model definition ---------------------------------------------

library(tfhub)

input <- layer_input(shape = c(32, 32, 3))

output <- input %>% 
  layer_lambda(f = function(x) tf$image$resize(x, size = c(96L,96L))) %>% 
  layer_hub(
    handle = "https://tfhub.dev/google/imagenet/mobilenet_v2_075_96/feature_vector/4", 
    # handle = "https://tfhub.dev/tensorflow/efficientnet/b4/feature-vector/1",
    trainable = FALSE
  ) %>% 
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


