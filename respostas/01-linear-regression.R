# Esse script tem uma pequena modificação com relação ao exemplo 01.
# Agora, ao invés de termos somente uma variável `x`, temos 2.
# O objetivo aqui é escrever o GD de forma a estimar os três parâmetros
# do modelo.


# Data generation ----------------------------------------------

n <- 1000

x1 <- runif(n)
x2 <- runif(n)

W1 <- 0.9
W2 <- 0.5
B <- 0.1

y <- W1 * x1 + W2 * x2 + B

# Model definition ---------------------------------------------

model <- function(w1, w2, b, x1, x2) {
  w1 * x1 + w2 * x2 + b
}

loss <- function(y, y_hat) {
  mean((y - y_hat)^2)
}

# Estimating via SGD --------------------------------------------

dl_dyhat <- function(y_hat) {
  2 * (y - y_hat) * (-1)
}

dyhat_dw1 <- function(w1) {
  x1
}

dyhat_dw2 <- function(w2) {
  x2
}

dyhat_db <- function(b) {
  1
}

# escreva o laço que faz a estimativa de todos os parametros w1, w2 e b.

# inicializando os pesos
w1 <- runif(1)
w2 <- runif(1)
b <- 0

lr <- 0.1

for (step in 1:500) {
    
    y_hat <- model(w1, w2, b, x1, x2)
    
    w1 <- w1 - lr*mean(dl_dyhat(y_hat) * dyhat_dw1(w1))
    w2 <- w2 - lr*mean(dl_dyhat(y_hat) * dyhat_dw2(w2))
    b <- b - lr*mean(dl_dyhat(y_hat) * dyhat_db(b))
    
    if (step %% 10 == 0) {
      print(loss(y, y_hat))
    }
    
}

w1
w2
b
