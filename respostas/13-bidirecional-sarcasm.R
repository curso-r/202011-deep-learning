# Ajuste um modelo para prever se a manchete é sarcástica ou não.
# Use embeddings pré treinadas, lstms encadeadas e bidirecionais
# O banco de dados pode ser obtido com o código abaixo:

library(keras)
library(tidyverse)

df <- readr::read_csv(
  pins::pin("https://storage.googleapis.com/deep-learning-com-r/headlines.csv")
)

x <- df$headline
y <- df$is_sarcastic

# Text vectorization ------------------------------------------------------

text_vectorization <- layer_text_vectorization(
  split = "whitespace",
  max_tokens = 30000, 
  output_sequence_length = 40
)

text_vectorization %>% adapt(x)

# Prepare embedding layer -------------------------------------------------
library(tidyverse)

# download.file("http://nlp.stanford.edu/data/glove.6B.zip", "glove.zip")

glove <- read_delim(
  unz("glove.zip", sprintf("glove.6B.%dd.txt", 50)),
  delim = " ", 
  col_names = FALSE, 
  quote = ""
)

nms <- glove$X1

glove <- dplyr::select(glove, -X1)
glove <- as.matrix(glove)

rownames(glove) <- nms

vocab <- get_vocabulary(text_vectorization)

get_embedding_weights <- function(vocab, pre_trained) {
  idx <- match(vocab, rownames(pre_trained))
  x <- pre_trained[idx,]
  x[is.na(x)] <- 0
  x <- rbind(
    rep(0, ncol(x)), # padding
    rep(0, ncol(x)), # oov token
    x
  )
  x
}

embedding_matrix <- get_embedding_weights(vocab, glove)

embedding_layer <- layer_embedding(
  input_dim = nrow(embedding_matrix),
  output_dim = ncol(embedding_matrix),
  weights = list(embedding_matrix),
  trainable = FALSE
)

# Build model; ------------------------------------------------------------

input <- layer_input(shape = 1L, dtype = "string")

output <- input %>% 
  text_vectorization() %>% 
  embedding_layer() %>% 
  bidirectional(layer = layer_lstm(units = 15, return_sequences = TRUE)) %>% 
  bidirectional(layer = layer_lstm(units = 32, return_sequences = TRUE)) %>% 
  layer_global_max_pooling_1d() %>% 
  layer_dense(units = 1, activation = "sigmoid")

model <- keras_model(input, output)

metric_auc <- function() {
  AUC <- tensorflow::tf$keras$metrics$AUC()
  custom_metric("auc", function(y_true, y_pred) {
    AUC(y_true, y_pred)
  })
}

model %>% 
  compile(
    loss = "binary_crossentropy",
    optimizer = optimizer_adam(lr= 0.01),
    metrics = c(metric_auc())
  )

# Fitting -----------------------------------------------------------------

history <- model %>% 
  fit(
    x = x,
    y = y,
    batch_size = 32,
    epochs = 5,
    validation_split = 0.2
  )

plot(history)