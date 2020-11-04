library(keras)

mnist <- dataset_mnist()
img <- mnist$train$x[1,,]/256

plot(as.raster(img))

# vamos criar um 'kernel' - w

w <- matrix(runif(9), nrow = 3, ncol = 3)

# vizinhança de tamanho 3x3
i <- 12
j <- 16

vizinhos <- img[i + (-1):1, j + (-1):1]
valor <- sum(w*vizinhos)

new_img <- img
for (i in 2:(nrow(img) - 1)) {
  for (j in 2:(ncol(img) - 1)) {
    new_img[i, j] <- sum(img[i + (-1):1, j + (-1):1] * w)
  }
}
new_img <- new_img[-c(1, nrow(new_img)), -c(1, ncol(new_img))]

plot(as.raster(new_img/max(new_img)))


# ---------- como Keras faz -----------------

w2 <- w %>% 
  rray::rray_expand(3) %>% 
  rray::rray_expand(4)

conv <- layer_conv_2d(filters = 1, kernel_size = c(3,3), use_bias = FALSE,
                      weights = list(w2))

im <- img %>% 
  rray::rray_expand(1) %>% 
  rray::rray_expand(4)

dim(im)

new_im <- conv(im)
new_im <- as.array(new_im)[1,,,1]

all.equal(new_im, new_img)
