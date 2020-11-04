
# Fazer um modelo para prever seas perguntas são duplicadas usando 
# embeddings pré-treinadas.

# Dados ---------------------------------

df <- readr::read_csv(
  pins::pin("https://storage.googleapis.com/deep-learning-com-r/quora.csv.zip")
)

question1 <- df$question1
question2 <- df$question2
is_duplicate <- df$is_duplicate

# Preparar camada de vetorização ---------
