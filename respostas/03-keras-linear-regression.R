# Agora, ao invés de termos somente uma variável `x`, temos 2.
# Escreva o código usando keras para estimar os parâmetros do modelo.


# Data generation ----------------------------------------------

n <- 1000

x <- matrix(runif(2*n), ncol = 2)
W <- matrix(c(0.2, 0.7), nrow = 2)
B <- 0.1

y <- x %*% W + B

# Model definition ---------------------------------------------

library(keras)

input <- layer_input(shape = ncol(x))
output <- input %>% 
  layer_dense(units = 1)

model <- keras_model(input, output)

summary(model)

model %>% 
  compile(
    loss = "mse",
    optimizer = optimizer_sgd(lr = 0.01)
  )

# Model fitting ------------------------------------------------

model %>% 
  fit(x, y, batch_size = 10, epochs = 50)

get_weights(model)


