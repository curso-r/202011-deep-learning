library(keras)

set.seed(1)

imgs <- fs::dir_ls("~/Downloads/fruits-360/Training/", 
                   recurse = TRUE, type = "file")

imgs <- sample(imgs, 10000)
class <- stringr::str_split(imgs, "/", simplify = TRUE)[,7]

load_img <- function(path) {
  keras::image_load(path, target_size = c(96, 96)) %>% 
    image_to_array()
}

imgs <- lapply(imgs, load_img)
k <- do.call(abind::abind, append(imgs, list(along = 0)))

saveRDS(list(x = k, y = class), "data/fruit360.rds")



