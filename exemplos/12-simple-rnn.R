# Pacotes ---------------------------------------------------------

library(keras)

# Data ------------------------------------------------------------

n <- 10000
l <- 10

cresc <- sample(c(1,0), size = n, replace = TRUE)
x <- array(dim = c(n, l, 1))
for(i in 1:n) {
  v <- runif(2, min = -1, max = 1)
  if (cresc[i] == 1)
    x[i,,1] <- seq(from = min(v), to = max(v), length.out = l)
  else
    x[i,,1] <- seq(from = max(v), to = min(v), length.out = l)
}

plot(x[6,,])

# Model ------------------------------------------------------------

# use float64 for comparison with R
tensorflow::tf$keras$backend$set_floatx("float64") 

input <- layer_input(shape = c(l,1))

output <- input %>% 
  layer_simple_rnn(units = 1, 
                   activation = "sigmoid", use_bias = FALSE)

model <- keras_model(input, output)

model %>% compile(loss = "binary_crossentropy", 
                  optimizer = "sgd",
                  metrics = "accuracy")
model %>% fit(x = x, y = cresc, epochs = 10)

predicoes <- predict(model, x)

# Manual calc ------------------------------------------------------

sigm <- function(x) {
  1/(1 + exp(-x))
}

w <- get_weights(model)

s <- 0
x_ <- x[1,,]
for (i in 1:l) {
  s <- sigm(x_[i]*w[[1]] + s*w[[2]])
}
s

loss(s, cresc)


predict(model, x)[1,]

# Results ----------------------------------------------------------

ggplot2::qplot(predict(model, x), cresc, geom = "jitter")
model(x[1:10,,,drop=FALSE])
cresc[1:10]
