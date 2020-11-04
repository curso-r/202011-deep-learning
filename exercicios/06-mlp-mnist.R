# Ajuste uma MLP para a base do MNIST com uantas layers você preferir.
# O mais importante é lembrar da loss e da ativação da última camada.

base <- dataset_mnist()
x <- array_reshape(base$train$x/256, dim = c(60000, 784))
y <- to_categorical(base$train$y)

dim(x)
dim(y)

# Model definition ---------------------------------------------



# Model fitting ------------------------------------------------


