# Use um modelo pré-treinado p/ prever as categorias do banco 
# de dados de frutas.
# 
# Compare o resultado com um modelo ajustado do zero.
#

base <- readRDS(pins::pin(
  "https://storage.googleapis.com/deep-learning-com-r/fruit360.rds"
))

x <- base$x/256

classes <- unique(base$y)
y <- match(base$y, classes) - 1
y <- to_categorical(y)


plot(as.raster(x[6,,,]))

# Definir modelo -------------------------------


# Ajustar modelo -------------------------------