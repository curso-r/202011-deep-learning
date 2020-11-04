library(keras)

# Data generation ----------------------------------------------

n <- 1000

x <- runif(n)
W <- 0.9
B <- 0.1

y <- W * x + B

# Model definition ---------------------------------------------

input <- layer_input(shape = 1)
output <- layer_dense(input, units = 1, use_bias = TRUE)
model <- keras_model(input, output)

summary(model)

model %>% 
  compile(
    loss = loss_mean_squared_error,
    optimizer = optimizer_sgd(lr = 0.01)
  )

# Model fitting ---------------------------------------------------

model %>% 
  fit(
    x = x,
    y = y,
    batch_size = 2, 
    epochs = 5
  )

get_weights(model)
predict(model, x)
