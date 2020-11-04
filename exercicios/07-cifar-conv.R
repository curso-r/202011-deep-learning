# Ajuste uma rede neural para prever as classes do CIFAR10.

base <- dataset_cifar10()
x <- base$train$x/256
y <- to_categorical(base$train$y)

dim(x)
dim(y)

# Model definition ---------------------------------------------



# Model fitting ------------------------------------------------


