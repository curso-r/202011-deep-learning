# dados

if (!dir.exists("captcha/")) {

  path <- pins::pin(
    "https://storage.googleapis.com/decryptr/data-raw/rsc.zip"  
  )
  
  unzip(path, exdir = "captchas/")
  
}


# leitura dos captchas

arqs <- fs::dir_ls("captchas", glob = "*.png")

captchas <- decryptr::read_captcha(arqs, ans_in_path = TRUE, 
                       vocab = c(0:9, letters))

r <- decryptr::join_captchas(captchas)


# modelo

# Create model
input <- layer_input(shape = c(24, 72, 1))
output <- input %>%
  layer_conv_2d(
    filters = 16,
    kernel_size = c(5, 5),
    padding = "same",
    activation = "relu") %>%
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  layer_conv_2d(
    filters = 32,
    kernel_size = c(5, 5),
    padding = "same",
    activation = "relu") %>%
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  layer_conv_2d(
    filters = 64,
    kernel_size = c(5, 5),
    padding = "same",
    activation = "relu") %>%
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  layer_flatten() %>%
  layer_dense(units = 512) %>%
  layer_dropout(.1) %>%
  layer_dense(units = 4*36) %>%
  layer_reshape(target_shape = c(4, 36)) %>%
  layer_activation("softmax")

model <- keras_model(input, output)

# Compile and fit model
model %>%
  compile(
    optimizer = "adam",
    loss = "categorical_crossentropy",
    metrics = "accuracy")

model %>% 
  fit(r$x, r$y, epochs = 10, validation_split = 0.2)

