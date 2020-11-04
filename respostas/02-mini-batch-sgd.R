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

dl_dyhat <- function(y_hat, y) {
  2 * (y - y_hat) * (-1)
}

dyhat_dw <- function(w, x) {
  x
}

dyhat_db <- function(b, x) {
  1
}

epochs <- 10
batch_size <- 32

w <- runif(1)
b <- 0

for (epoch in 1:epochs) {
  indices <- 1:n
  while (length(indices) > batch_size) {
    i <- sample(indices, size = batch_size)
    indices <- indices[!indices %in% i]
    
    y_hat <- model(w, b, x[i])
    
    w <- w - lr*mean(dl_dyhat(y_hat, y[i]) * dyhat_dw(w, x[i]))
    b <- b - lr*mean(dl_dyhat(y_hat, y[i]) * dyhat_db(b, x[i]))
    
  }
  
  print(loss(y, model(w, b, x)))
}

w
b