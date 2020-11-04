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


