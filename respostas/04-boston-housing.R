# Agora vamos usar bases de dados de verdade!
# Ajuste um MLP com quantas layers e unidades escondidas
# você preferir.

base <- dataset_boston_housing()
x <- scale(base$train$x)
y <- scale(base$train$y)

# Model definition ---------------------------------------------

input <- layer_input(shape = ncol(x))

output <- input %>% 
  layer_dense(units = 32, activation = "relu") %>% 
  layer_dense(units = 1)

model <- keras_model(input, output)

model %>% 
  compile(
    loss = "mse",
    optimizer = "sgd"
  )

# Model fitting ------------------------------------------------

history <- model %>% 
  fit(x, y, batch_size = 32, epochs = 100, validation_split = 0.2)

plot(history)



