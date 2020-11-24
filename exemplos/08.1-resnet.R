library(keras)

# Dados -------------------------------------------------------------------

base <- dataset_cifar10()
x <- base$train$x/256
y <- to_categorical(base$train$y)

dim(x)
dim(y)

# Residual block ----------------------------------------------------------

layer_residual_block <- function(x, filters, downsample) {
  
  if (downsample)
    stride <- 2
  else
    stride <- 1
  
  y <- x %>% 
    
    layer_conv_2d(kernel_size = c(3,3), filters = filters, 
                  padding = "same", strides = stride) %>% 
    layer_batch_normalization() %>% 
    layer_activation_relu() %>% 
    
    layer_conv_2d(kernel_size = c(3,3), filters = filters, 
                  padding = "same") %>% 
    layer_batch_normalization() %>% 
    layer_activation_relu()
  
  if (downsample) {
    x <- x %>% 
      layer_conv_2d(kernel_size = c(3,3), filters = filters,
                    padding = "same", strides = stride)
  }
  
  list(x, y) %>% 
    layer_add() %>% 
    layer_batch_normalization() %>% 
    layer_activation_relu()
}

# Criando o modelo --------------------------------------------------------

input <- layer_input(shape = c(32,32,3))

output <- input %>% 
  
  layer_conv_2d(filters = 16, kernel_size = c(3,3), 
                padding = "same") %>% 
  layer_batch_normalization() %>% 
  layer_activation_relu() %>% 
  
  layer_residual_block(filters = 16, downsample = FALSE) %>% 
  layer_residual_block(filters = 16, downsample = FALSE) %>% 
  layer_residual_block(filters = 16, downsample = TRUE) %>% 
  
  layer_conv_2d(filters = 32, kernel_size = c(3,3), 
                padding = "same") %>% 
  layer_batch_normalization() %>% 
  layer_activation_relu() %>% 
  
  layer_residual_block(filters = 32, downsample = FALSE) %>% 
  layer_residual_block(filters = 32, downsample = FALSE) %>% 
  layer_residual_block(filters = 32, downsample = TRUE) %>% 

  layer_conv_2d(filters = 64, kernel_size = c(3,3), 
                padding = "same") %>% 
  layer_batch_normalization() %>% 
  layer_activation_relu() %>% 
  
  layer_residual_block(filters = 64, downsample = FALSE) %>% 
  layer_residual_block(filters = 64, downsample = FALSE) %>% 
  layer_residual_block(filters = 64, downsample = TRUE) %>% 
  
  layer_average_pooling_2d() %>% 
  
  layer_flatten() %>% 
  layer_dense(10, activation = "softmax")

model <- keras_model(input, output)

# Compile -----------------------------------------------------------------

model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = "sgd",
  metrics = "accuracy"
)

# Fit ---------------------------------------------------------------------

model %>% fit(
  x = x, 
  y = y,
  batch_size = 32,
  validation_split = 0.2
)
  
