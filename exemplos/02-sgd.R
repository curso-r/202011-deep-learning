# Data generation ----------------------------------------------

n <- 1000

x <- runif(n)
W <- 0.9
B <- 0.1

y <- W * x + B

# Model definition ---------------------------------------------

model <- function(w, b, x) {
  w * x + b
}

loss <- function(y, y_hat) {
  mean((y - y_hat)^2)
}

# Estimating via SGD --------------------------------------------

dl_dyhat <- function(y_hat) {
  2 * (y - y_hat) * (-1)
}

dyhat_dw <- function(w) {
  x
}

dyhat_db <- function(b) {
  1
}

# inicializando os pesos
w <- runif(1)
b <- 0

lr <- 0.1

for (epoch in 1:2) {
  for (i in 1:length(x)) {
    y_hat <- model(w, b, x)
    
    w <- w - lr*(dl_dyhat(y_hat) * dyhat_dw(w))[i]
    b <- b - lr*(dl_dyhat(y_hat) * dyhat_db(b))[i]
    
  }
  
  print(loss(y, y_hat))
}

w
b



