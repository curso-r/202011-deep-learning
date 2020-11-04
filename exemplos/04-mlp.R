library(keras)

# Data generation ----------------------------------------------

n <- 1000

relu <- function(x) {
  ifelse(x > 0, x, 0)
}

x <- matrix(runif(2*n), ncol = 2)
W <- matrix(c(0.2, 0.7, -0.4, 0.5), nrow = 2)
B <- c(0.1, -0.2)

V <- matrix(c(0.6, 0.7), nrow = 2)
a <- c(0.9)

y <- relu(x %*% W + B) %*% V + a

# Model definition ---------------------------------------------

input <- layer_input(shape = 2)

output <- input %>% 
  layer_dense(units = 2, activation = "relu") %>% 
  layer_dense(units = 1)

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
