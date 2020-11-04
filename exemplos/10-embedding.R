library(keras)

layer <- layer_text_vectorization(max_tokens = 10, output_mode = "int", 
                                  pad_to_max_tokens = TRUE)

frases <- c(
  "eu gosto de gatos",
  "eu gosto de cachorros",
  "eu gosto de gatos e cachorros"
)

layer %>% 
  adapt(frases)

layer(matrix(frases, ncol = 1))

vocab <- get_vocabulary(layer)

input <- layer_input(shape = 1, dtype = "string")
output <- input %>%
  layer() %>% 
  layer_embedding(input_dim = length(vocab) + 2, output_dim = 2)

model <- keras_model(input, output)
out <- predict(model, matrix(frases, ncol = 1))

dim(out)
out[1,,]
