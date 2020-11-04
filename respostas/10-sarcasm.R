# Ajuste um modelo para prever se a manchete é sarcástica ou não.
# Use embeddings e global avg pooling.
# O banco de dados pode ser obtido com o código abaixo:

library(keras)

df <- readr::read_csv(
  pins::pin("https://storage.googleapis.com/deep-learning-com-r/headlines.csv")
  )

x <- df$headline
y <- df$is_sarcastic

vectorize <- layer_text_vectorization(max_tokens = 10000, output_mode = "int", 
                                      pad_to_max_tokens = TRUE,
                                      output_sequence_length = 30)

vectorize %>% 
  adapt(x)

vocab <- get_vocabulary(vectorize)

# Definição do modelo -------------

input <- layer_input(shape = 1, dtype = "string")

output <-  input %>%
  vectorize() %>% 
  layer_embedding(input_dim = length(vocab) + 2, output_dim = 32) %>% 
  layer_global_average_pooling_1d() %>% 
  layer_dropout(0.2) %>% 
  layer_dense(units = 1, activation = "sigmoid")

model <- keras_model(input, output)

model %>% 
  compile(
    loss = "binary_crossentropy",
    optimizer = "sgd",
    metrics = "accuracy"
  )

# ajuste

model %>% 
  fit(matrix(x, ncol = 1), y, validation_split = 0.2, batch_size = 32)

