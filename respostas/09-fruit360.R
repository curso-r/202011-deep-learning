# Use um modelo pré-treinado p/ prever as categorias do banco 
# de dados de frutas.
# 
# Compare o resultado com um modelo ajustado do zero.
#

library(keras)
library(tfhub)

base <- readRDS(pins::pin(
  "https://storage.googleapis.com/deep-learning-com-r/fruit360.rds"
))

x <- base$x/256

dim(x)

classes <- unique(base$y)
y <- match(base$y, classes) - 1
y <- to_categorical(y)


plot(as.raster(x[6,,,]))

# Definir modelo -------------------------------

input <- layer_input(shape = c(96, 96, 3))
output <- input %>% 
  layer_hub(
    handle = "https://tfhub.dev/google/imagenet/mobilenet_v1_025_160/feature_vector/4", 
    trainable = FALSE
  ) %>% 
  layer_dense(units = 512, activation = "relu") %>% 
  layer_dense(units = ncol(y), activation = "softmax")

model <- keras_model(input, output)

model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = "sgd",
  metrics = "accuracy"
)

# Ajustar modelo -------------------------------

model %>% fit(x, y, batch_size = 32, epochs = 10, validation_split = 0.25)
