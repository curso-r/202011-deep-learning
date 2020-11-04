
# Dados ---------------------------------

df <- readr::read_csv(
  pins::pin("https://storage.googleapis.com/deep-learning-com-r/quora.csv.zip")
)

question1 <- df$question1
question2 <- df$question2
is_duplicate <- df$is_duplicate

# Preparar camada de vetorização ---------

library(keras)

vectorize <- layer_text_vectorization(
  max_tokens = 50000, 
  output_mode = "int",
  pad_to_max_tokens = TRUE
)

vectorize %>% 
  adapt(c(question1, question2))

vocab <- get_vocabulary(vectorize)

# Preparar camadas de embedding -----------

embedding <- layer_embedding(
  input_dim = length(vocab) + 2, 
  output_dim = 256
)

seq_embedding <- layer_lstm(
  units = 128
)

# Definição do modelo ----------------------

input1 <- layer_input(shape = 1, dtype = "string")
input2 <- layer_input(shape = 1, dtype = "string")

e1 <- input1 %>% 
  vectorize() %>% 
  embedding() %>% 
  seq_embedding()

e2 <- input2 %>% 
  vectorize() %>% 
  embedding() %>% 
  seq_embedding()

output <- layer_dot(list(e1, e2), axes = 1) %>% 
  layer_dense(units = 1, activation = "sigmoid")

model <- keras_model(list(input1, input2), output)

model %>% compile(
  optimizer = optimizer_sgd(lr = 0.1), 
  metrics = "accuracy",
  loss = "binary_crossentropy"
)

# Treino ----------------------------

model %>% 
  fit(list(question1, question2), is_duplicate,
      validation_split = 0.2, batch_size = 64)
