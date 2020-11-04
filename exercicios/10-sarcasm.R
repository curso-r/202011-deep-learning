# Ajuste um modelo para prever se a manchete é sarcástica ou não.
# Use embeddings e global avg pooling.
# O banco de dados pode ser obtido com o código abaixo:

df <- readr::read_csv(
  pins::pin("https://storage.googleapis.com/deep-learning-com-r/headlines.csv")
  )


# Camada de vetorização

# Definição do modelo

# Ajuste do modelo