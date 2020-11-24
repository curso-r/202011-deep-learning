# Dataset

library(keras)

base <- dataset_cifar10()
x <- base$train$x/256
y <- to_categorical(base$train$y)

dim(x)
dim(y)

# Model definition ---------------------------------------------

library(tfhub)

input_para_ajustar <- layer_input(shape = c(32, 32, 3))
input <- layer_input(shape = c(96, 96, 3))

output <- input %>% 
  layer_hub(
    handle = "https://tfhub.dev/google/imagenet/inception_v3/feature_vector/4",
    # handle = "https://tfhub.dev/google/imagenet/mobilenet_v2_075_96/feature_vector/4", 
    # handle = "https://tfhub.dev/tensorflow/efficientnet/b4/feature-vector/1",
    trainable = FALSE
  ) %>% 
  layer_dense(128, activation = "relu") %>% 
  layer_dense(10, activation = "softmax") 

modelo_para_salvar <- keras_model(input, output)  

output_para_treinar <- input_para_ajustar %>% 
  layer_lambda(function(x) tf$image$resize(x, c(96L, 96L))) %>% 
  modelo_para_salvar()

modelo_para_treinar <- keras_model(input_para_ajustar, output_para_treinar)

modelo_para_treinar %>% 
  compile(
    loss = "categorical_crossentropy",
    optimizer = "sgd",
    metrics = "accuracy"
  )

# Model fitting ------------------------------------------------

modelo_para_treinar %>% 
  fit(x, y, batch_size = 32, epochs = 5, validation_split = 0.2)  


save_model_tf(modelo_para_salvar, "modelo-pre-treinado/")


