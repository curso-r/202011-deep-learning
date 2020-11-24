
# Deep Learning

<!-- README.md is generated from README.Rmd. Please edit that file -->

Repositório com material das aulas de deep learning com R.

## Ementa

  - **Introdução**
      - O que é e quando utilizar Deep Learning
      - O que são redes neurais profundas
  - **Ajuste**
      - Ajustando modelos de deep learning no R
      - O pacote `keras`
      - Técnicas de regularização
  - **Arquiteturas**
      - Redes neurais recorrentes (RNN)
      - Redes neurais convolucionais (CNN)
      - *Long short-term memory* (LSTM)

## Slides

Os slides do curso podem ser encontrados nesse
[link](https://curso-r.github.io/202011-deep-learning/slides).

## Instalação

Os seguintes programas serão instalados. Estamos prevendo algum tempo no
início do curso para instalar os pacotes mas se você já conseguir
instalar, melhor\!

1)  Instale o R\! De preferência a versão mais recente (\>= 4.0).

No Windows você também precisa instalar o [Microsoft Visual C++
Redistributable for Visual Studio 2015, 2017
and 2019](https://support.microsoft.com/help/2977003/the-latest-supported-visual-c-downloads).
Baixar a versão x64.

2)  Execute as seguintes linhas de código em uma sessão limpa do R.
    (Certifique-se de fechar todas as outras sessões do R/RStudio que
    estiverem abertas no seu computador).

<!-- end list -->

    install.packages("reticulate")
    reticulate::install_miniconda()
    install.packages(c("keras", "tfhub"))
    keras::install_keras()
    tfhub::install_tfhub()

3)  Verifique a instalação com:

<!-- end list -->

    tensorflow::tf_version() # deve retornar 2.2

Nesse vídeo você pode ver o passo a passo da instalação no Windows:
<https://www.youtube.com/watch?v=nSOyfBulXlQ&feature=youtu.be>

## Dúvidas

O melhor lugar para tirar dúvidas relativas ao conteúdo do curso é no
nosso [discourse](https://discourse.curso-r.com/).

## Scripts usados em aula

#### Exemplos

| exemplo                      | link                                                                                         | gh\_link                                                                                                |
| :--------------------------- | :------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------ |
| 01-linear-regression.R       | [link](https://curso-r.github.io/202011-deep-learning/exemplos/01-linear-regression.R)       | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/01-linear-regression.R)       |
| 02-sgd.R                     | [link](https://curso-r.github.io/202011-deep-learning/exemplos/02-sgd.R)                     | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/02-sgd.R)                     |
| 03-keras.R                   | [link](https://curso-r.github.io/202011-deep-learning/exemplos/03-keras.R)                   | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/03-keras.R)                   |
| 04-mlp.R                     | [link](https://curso-r.github.io/202011-deep-learning/exemplos/04-mlp.R)                     | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/04-mlp.R)                     |
| 05-regressao-logistica.R     | [link](https://curso-r.github.io/202011-deep-learning/exemplos/05-regressao-logistica.R)     | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/05-regressao-logistica.R)     |
| 05.1-regressao-custom-loss.R | [link](https://curso-r.github.io/202011-deep-learning/exemplos/05.1-regressao-custom-loss.R) | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/05.1-regressao-custom-loss.R) |
| 05.2-tensorboard.R           | [link](https://curso-r.github.io/202011-deep-learning/exemplos/05.2-tensorboard.R)           | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/05.2-tensorboard.R)           |
| 06-convolution.R             | [link](https://curso-r.github.io/202011-deep-learning/exemplos/06-convolution.R)             | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/06-convolution.R)             |
| 07-conv-mnist.R              | [link](https://curso-r.github.io/202011-deep-learning/exemplos/07-conv-mnist.R)              | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/07-conv-mnist.R)              |
| 08-tfhub.R                   | [link](https://curso-r.github.io/202011-deep-learning/exemplos/08-tfhub.R)                   | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/08-tfhub.R)                   |
| 08.1-resnet.R                | [link](https://curso-r.github.io/202011-deep-learning/exemplos/08.1-resnet.R)                | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/08.1-resnet.R)                |
| 09-text-vectorization.R      | [link](https://curso-r.github.io/202011-deep-learning/exemplos/09-text-vectorization.R)      | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/09-text-vectorization.R)      |
| 10-embedding.R               | [link](https://curso-r.github.io/202011-deep-learning/exemplos/10-embedding.R)               | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/10-embedding.R)               |
| 11-avg-pooling.R             | [link](https://curso-r.github.io/202011-deep-learning/exemplos/11-avg-pooling.R)             | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/11-avg-pooling.R)             |
| 12-simple-rnn.R              | [link](https://curso-r.github.io/202011-deep-learning/exemplos/12-simple-rnn.R)              | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/12-simple-rnn.R)              |
| 13-simple-lstm.R             | [link](https://curso-r.github.io/202011-deep-learning/exemplos/13-simple-lstm.R)             | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/13-simple-lstm.R)             |
| 14-lstm.R                    | [link](https://curso-r.github.io/202011-deep-learning/exemplos/14-lstm.R)                    | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/14-lstm.R)                    |
| 15-pre-trained-embedding.R   | [link](https://curso-r.github.io/202011-deep-learning/exemplos/15-pre-trained-embedding.R)   | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/15-pre-trained-embedding.R)   |
| 15-simple-gru.R              | [link](https://curso-r.github.io/202011-deep-learning/exemplos/15-simple-gru.R)              | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/15-simple-gru.R)              |
| 16-gru.R                     | [link](https://curso-r.github.io/202011-deep-learning/exemplos/16-gru.R)                     | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/16-gru.R)                     |
| 17-pre-trained-embedding.R   | [link](https://curso-r.github.io/202011-deep-learning/exemplos/17-pre-trained-embedding.R)   | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/17-pre-trained-embedding.R)   |
| 18-encadeando-lstms.R        | [link](https://curso-r.github.io/202011-deep-learning/exemplos/18-encadeando-lstms.R)        | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/18-encadeando-lstms.R)        |
| 19-bidirecional.R            | [link](https://curso-r.github.io/202011-deep-learning/exemplos/19-bidirecional.R)            | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/19-bidirecional.R)            |
| 20-quora.R                   | [link](https://curso-r.github.io/202011-deep-learning/exemplos/20-quora.R)                   | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/20-quora.R)                   |
| 21-series-temporais.R        | [link](https://curso-r.github.io/202011-deep-learning/exemplos/21-series-temporais.R)        | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/21-series-temporais.R)        |
| 22-unet.R                    | [link](https://curso-r.github.io/202011-deep-learning/exemplos/22-unet.R)                    | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/22-unet.R)                    |
| 23-captcha.R                 | [link](https://curso-r.github.io/202011-deep-learning/exemplos/23-captcha.R)                 | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exemplos/23-captcha.R)                 |

#### Exercicios

| exercicio                    | link                                                                                           | gh\_link                                                                                                  |
| :--------------------------- | :--------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------- |
| 01-linear-regression.R       | [link](https://curso-r.github.io/202011-deep-learning/exercicios/01-linear-regression.R)       | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/01-linear-regression.R)       |
| 02-mini-batch-sgd.R          | [link](https://curso-r.github.io/202011-deep-learning/exercicios/02-mini-batch-sgd.R)          | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/02-mini-batch-sgd.R)          |
| 03-keras-linear-regression.R | [link](https://curso-r.github.io/202011-deep-learning/exercicios/03-keras-linear-regression.R) | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/03-keras-linear-regression.R) |
| 04-boston-housing.R          | [link](https://curso-r.github.io/202011-deep-learning/exercicios/04-boston-housing.R)          | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/04-boston-housing.R)          |
| 05-boston-housing-logistic.R | [link](https://curso-r.github.io/202011-deep-learning/exercicios/05-boston-housing-logistic.R) | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/05-boston-housing-logistic.R) |
| 06-mlp-mnist.R               | [link](https://curso-r.github.io/202011-deep-learning/exercicios/06-mlp-mnist.R)               | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/06-mlp-mnist.R)               |
| 07-cifar-conv.R              | [link](https://curso-r.github.io/202011-deep-learning/exercicios/07-cifar-conv.R)              | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/07-cifar-conv.R)              |
| 08-dropout-batch-norm.R      | [link](https://curso-r.github.io/202011-deep-learning/exercicios/08-dropout-batch-norm.R)      | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/08-dropout-batch-norm.R)      |
| 09-fruit360.R                | [link](https://curso-r.github.io/202011-deep-learning/exercicios/09-fruit360.R)                | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/09-fruit360.R)                |
| 10-sarcasm.R                 | [link](https://curso-r.github.io/202011-deep-learning/exercicios/10-sarcasm.R)                 | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/10-sarcasm.R)                 |
| 11-lstm-sarcasm.R            | [link](https://curso-r.github.io/202011-deep-learning/exercicios/11-lstm-sarcasm.R)            | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/11-lstm-sarcasm.R)            |
| 12-pre-trained-sarcasm.R     | [link](https://curso-r.github.io/202011-deep-learning/exercicios/12-pre-trained-sarcasm.R)     | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/12-pre-trained-sarcasm.R)     |
| 13-bidirecional-sarcasm.R    | [link](https://curso-r.github.io/202011-deep-learning/exercicios/13-bidirecional-sarcasm.R)    | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/13-bidirecional-sarcasm.R)    |
| 14-quora.R                   | [link](https://curso-r.github.io/202011-deep-learning/exercicios/14-quora.R)                   | [link](https://github.com/curso-r/202011-deep-learning/blob/main/exercicios/14-quora.R)                   |

#### Respostas

| exercicio                    | link                                                                                          | gh\_link                                                                                                 |
| :--------------------------- | :-------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------- |
| 01-linear-regression.R       | [link](https://curso-r.github.io/202011-deep-learning/respostas/01-linear-regression.R)       | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/01-linear-regression.R)       |
| 02-mini-batch-sgd.R          | [link](https://curso-r.github.io/202011-deep-learning/respostas/02-mini-batch-sgd.R)          | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/02-mini-batch-sgd.R)          |
| 03-keras-linear-regression.R | [link](https://curso-r.github.io/202011-deep-learning/respostas/03-keras-linear-regression.R) | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/03-keras-linear-regression.R) |
| 04-boston-housing.R          | [link](https://curso-r.github.io/202011-deep-learning/respostas/04-boston-housing.R)          | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/04-boston-housing.R)          |
| 05-boston-housing-logistic.R | [link](https://curso-r.github.io/202011-deep-learning/respostas/05-boston-housing-logistic.R) | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/05-boston-housing-logistic.R) |
| 06-mlp-mnist.R               | [link](https://curso-r.github.io/202011-deep-learning/respostas/06-mlp-mnist.R)               | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/06-mlp-mnist.R)               |
| 07-cifar-conv.R              | [link](https://curso-r.github.io/202011-deep-learning/respostas/07-cifar-conv.R)              | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/07-cifar-conv.R)              |
| 08-dropout-batch-norm.R      | [link](https://curso-r.github.io/202011-deep-learning/respostas/08-dropout-batch-norm.R)      | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/08-dropout-batch-norm.R)      |
| 09-fruit360.R                | [link](https://curso-r.github.io/202011-deep-learning/respostas/09-fruit360.R)                | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/09-fruit360.R)                |
| 10-sarcasm.R                 | [link](https://curso-r.github.io/202011-deep-learning/respostas/10-sarcasm.R)                 | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/10-sarcasm.R)                 |
| 11-lstm-sarcasm.R            | [link](https://curso-r.github.io/202011-deep-learning/respostas/11-lstm-sarcasm.R)            | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/11-lstm-sarcasm.R)            |
| 12-pre-trained-sarcasm.R     | [link](https://curso-r.github.io/202011-deep-learning/respostas/12-pre-trained-sarcasm.R)     | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/12-pre-trained-sarcasm.R)     |
| 13-bidirecional-sarcasm.R    | [link](https://curso-r.github.io/202011-deep-learning/respostas/13-bidirecional-sarcasm.R)    | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/13-bidirecional-sarcasm.R)    |
| 14-quora.R                   | [link](https://curso-r.github.io/202011-deep-learning/respostas/14-quora.R)                   | [link](https://github.com/curso-r/202011-deep-learning/blob/main/respostas/14-quora.R)                   |
