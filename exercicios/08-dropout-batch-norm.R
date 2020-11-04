# Ajuste uma rede neural para prever as classes do CIFAR10.
# Use batch_norm e dropouts para melhorar o seu modelo.
# Lembre-se que usamos batch_norm anets da ativação então escreva algo
# assim:
#
# input %>% 
#   layer_conv2d(...) %>% 
#   layer_batch_norm() %>% 
#   layer_activation()
# 

base <- dataset_cifar10()
x <- base$train$x/256
y <- to_categorical(base$train$y)

dim(x)
dim(y)

# Model definition ---------------------------------------------



# Model fitting ------------------------------------------------


