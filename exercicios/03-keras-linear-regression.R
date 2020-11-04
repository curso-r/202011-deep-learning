# Agora, ao invés de termos somente uma variável `x`, temos 2.
# Escreva o código usando keras para estimar os parâmetros do modelo.


# Data generation ----------------------------------------------

n <- 1000

x <- matrix(runif(2*n), ncol = 2)
W <- matrix(c(0.2, 0.7), nrow = 2)
B <- 0.1

y <- x %*% W + B

# Model definition ---------------------------------------------



# Model fitting ------------------------------------------------





