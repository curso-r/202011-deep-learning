# Dados ---------------------------------------

library(tidyverse)

df <- readr::read_csv(
  pins::pin("https://raw.githubusercontent.com/jbrownlee/Datasets/master/pollution.csv")
)

df <- df %>% 
  mutate(date = lubridate::make_datetime(year, month, day, hour)) %>% 
  select(-day, -month, -year, -hour, -No)

df <- df %>% 
  rename(
    pollution = pm2.5,
    dew = DEWP,
    temp = TEMP,
    press = PRES,
    wnd_dir = cbwd,
    wnd_spd = Iws,
    snow = Is,
    rain = Ir
  ) %>% 
  select(date, everything())

# limpeza - jogar fora as primeiras 24h
# substituir os NA's da poluição por 0

df <- df %>% 
  filter(row_number(date) > 24) %>% 
  mutate(pollution = ifelse(is.na(pollution), 0, pollution))

# tabelinha descritiva
df %>% 
  skimr::skim()

# grafico das séries
df %>% 
  select(-wnd_dir) %>% 
  pivot_longer(names_to = "var", values_to = "val", cols = c(-date)) %>% 
  ggplot(aes(x = date, y = val)) +
  geom_line() +
  facet_wrap(~var, scales = "free_y", ncol = 1)

df <- df %>% 
  mutate(
    cv = as.numeric(wnd_dir == "cv"),
    NE = as.numeric(wnd_dir == "NE"),
    NW = as.numeric(wnd_dir == "NW"),
    SE = as.numeric(wnd_dir == "SE")
  ) %>% 
  select(-wnd_dir)

# Preparando os dados ----------------

historico <- 30*24
previsao <- 24
pulos <- 3*24

janelas <- seq(
  from = historico, 
  to = nrow(df) - previsao -1, 
  by = pulos
)

length(janelas)
data <- df %>% arrange(date) %>% select(-date) %>% as.matrix()

x <- array(NA, dim = c(length(janelas), historico, ncol(data)))
y <- array(NA, dim = c(length(janelas), previsao, ncol(data) - 4))

medias <- apply(data[1:(24*365),], 2, mean)
sds <- apply(data[1:(24*365),], 2, sd)

for (i in seq_along(janelas)) {
  
  janela <- janelas[i]
  
  x[i,,] <- scale(data[(janela - historico + 1):janela,], center = medias, 
                  scale = sds)
  y[i,,] <- scale(data[(janela + 1):(janela + previsao),], center = medias,
                  scale = sds)[,-c(8:11)]
  
}

# Definindo o modelo --------------------

library(keras)

input <- layer_input(shape = c(historico, ncol(data)))
output <- input %>% 
  layer_lstm(units = 32, return_sequences = TRUE) %>% 
  layer_lstm(units = 128) %>% 
  layer_dense(units = 512, activation = "relu") %>% 
  layer_dense(units = previsao * (ncol(data) - 4)) %>% 
  layer_reshape(target_shape = c(previsao, ncol(data) -4))
  
model <- keras_model(input, output)

summary(model)

model %>% compile(loss = "mse", optimizer = "adam")

# Ajuste do modelo ---------------------------

id <- 1:500

model %>% 
  fit(x[id,,], y[id,,], batch_size = 10, shuffle = FALSE,
      validation_data = list(x[-id,,], y[-id,,]), epochs = 10)


x_test <- x[-id,,]
y_test <- y[-id,,]
pred <- predict(model, x_test)

obs <- 3

historico <- 
  x_test[obs,,1:7] %>% 
  as.data.frame() %>% 
  mutate(b = "real") %>% 
  mutate(data = row_number())

predito <- 
  pred[obs,,] %>% 
  as.data.frame() %>% 
  mutate(b = "predito") %>% 
  mutate(data = max(historico$data) + row_number())

observado <- 
  y[obs,,] %>% 
  as.data.frame() %>% 
  mutate(b = "real") %>% 
  mutate(data = max(historico$data) + row_number())

bind_rows(historico, predito, observado) %>% 
  pivot_longer(cols = c(-data, -b), names_to = "col", values_to = "val") %>% 
  ggplot(aes(x = data, y = val)) +
  geom_line(aes(colour = b)) +
  facet_wrap(~col, ncol = 1, scales = "free_y")
  
  
  


  
