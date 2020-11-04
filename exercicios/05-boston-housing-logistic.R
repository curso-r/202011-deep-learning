# Agora vamos usar bases de dados de verdade!
# Ajuste um MLP com quantas layers e unidades escondidas
# você preferir para prever se uma casa será vendida por
# mais de 25k.

base <- dataset_boston_housing()
x <- base$train$x
y <- base$train$y
y <- as.numeric(y > 25)

# Model definition ---------------------------------------------



# Model fitting ------------------------------------------------





