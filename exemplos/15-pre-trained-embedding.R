# Download the data:
# https://www.kaggle.com/c/jigsaw-toxic-comment-classification-challenge
# Download the word vectors:
# http://nlp.stanford.edu/data/glove.6B.zip


# Packages ----------------------------------------------------------------

library(tidyverse)
library(keras)

# Configuration -----------------------------------------------------------

FLAGS <- flags(
  flag_integer("max_sequence_length", 100),
  flag_integer("max_vocab_size", 20000),
  flag_integer("embedding_dim", 50),
  flag_numeric("validation_split", 0.2),
  flag_integer("batch_size", 128),
  flag_integer("epochs", 10)
)


# Read dataset ------------------------------------------------------------

df <- readr::read_csv(
  pins::pin("https://storage.googleapis.com/deep-learning-com-r/toxic-comments.csv")
)

sentences <- df$comment_text
target <- df %>% 
  select(toxic, severe_toxic, obscene, threat, insult, identity_hate) %>% 
  as.matrix()

# Text vectorization ------------------------------------------------------

text_vectorization <- layer_text_vectorization(
  split = "whitespace",
  max_tokens = FLAGS$max_vocab_size, 
  output_sequence_length = FLAGS$max_sequence_length
)

text_vectorization %>% adapt(sentences)

# Prepare embedding layer -------------------------------------------------
library(tidyverse)

# download.file("http://nlp.stanford.edu/data/glove.6B.zip", "glove.zip")

glove <- read_delim(
  unz("glove.zip", sprintf("glove.6B.%dd.txt", FLAGS$embedding_dim)),
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
  input_length = FLAGS$max_sequence_length,
  weights = list(embedding_matrix),
  trainable = FALSE
)

# Build model; ------------------------------------------------------------

input <- layer_input(shape = 1L, dtype = "string")

output <- input %>% 
  text_vectorization() %>% 
  embedding_layer() %>% 
  layer_lstm(units = 15, return_sequences = TRUE) %>% 
  layer_global_max_pooling_1d() %>% 
  layer_dense(units = ncol(target), activation = "sigmoid")

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
    x = sentences,
    y = target,
    batch_size = FLAGS$batch_size,
    epochs = FLAGS$epochs,
    validation_split = FLAGS$validation_split
  )

plot(history)