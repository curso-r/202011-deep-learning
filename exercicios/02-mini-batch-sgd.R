# Com base no modelo implementado abaixo, escreva o `for` loop
# necessário p/ implementar o Mini-batch SGD. 
# O tamanho do batch deve ser especificado por meio de uma variável
# chamada batch_size.


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