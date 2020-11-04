library(keras)
library(tidyverse)

# Dados ------------

df <- readr::read_csv(
  pins::pin("https://storage.googleapis.com/deep-learning-com-r/toxic-comments.csv")
)

x <- df$comment_text
y <- as.matrix(df %>% select(-id, -comment_text))

n_palavras <- stringr::str_count(x, pattern = " +") + 1
quantile(n_palavras, c(0.5, 0.75, 0.85, 0.9, 0.95, 0.99, 1))

# Layer para vetorizacao --------

vectorize <- layer_text_vectorization(max_tokens = 10000, output_mode = "int", 
                                      pad_to_max_tokens = TRUE,
                                      output_sequence_length = 150
)

vectorize %>% 
  adapt(x)

vocab <- get_vocabulary(vectorize)

# Definição do modelo -------------

input <- layer_input(shape = 1, dtype = "string")
output <-  input %>%
  vectorize() %>% 
  layer_embedding(input_dim = length(vocab) + 2, output_dim = 32, 
                  mask_zero = TRUE) %>% 
  layer_lstm(units = 256, return_sequences = TRUE) %>% 
  layer_lstm(units = 128, return_sequences = TRUE) %>% 
  layer_lstm(units = 64) %>% 
  layer_dense(units = ncol(y), activation = "sigmoid")

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

