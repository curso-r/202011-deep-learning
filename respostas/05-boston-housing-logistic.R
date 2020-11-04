# Agora vamos usar bases de dados de verdade!
# Ajuste um MLP com quantas layers e unidades escondidas
# você preferir para prever se uma casa será vendida por
# mais de 25k.

base <- dataset_boston_housing()
x <- scale(base$train$x)
y <- base$train$y
y <- as.numeric(y > 25)

# Model definition ---------------------------------------------

input <- layer_input(shape = ncol(x))

output <- input %>% 
  layer_dense(units = 32, activation = "relu") %>% 
  layer_dense(units = 1, activation = "sigmoid")

model <- keras_model(input, output)

model %>% 
  compile(
    loss = "binary_crossentropy",
    optimizer = "sgd",
    metrics = "accuracy"
  )

# Model fitting ------------------------------------------------

history <- model %>% 
  fit(x, y, batch_size = 32, epochs = 100, validation_split = 0.2)

plot(history)





