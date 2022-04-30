# Introdução a softwares estatísticos
# Data: 26/06/2019
# Aula: 06
# Assunto: Matrizes e dataframes

rm(list(ls(all = TRUE))) # Remove todos os objetos da memória

# Matrizes (continuação) --------------------------------------------------


# Pra complementar, responda os exercícios abaixo

# 1) O que a função dim() retorn quando aplicado a um vetor?

# NULL

# 2) S e is.matrix(x) retorna TRUE, o que is.array(x) retorna?

# 3) Como você descreveria os três objetos a seguir? Sem executar
# o código, o que se espera como resultado?

x1 <- array(1:5, c(1,1,5))
x2 <- array(1:5, c(1,5,1))
x3 <- array(1:5, c(5,1,1))

x1
x2
x3


# Exercício: crie três vetores com três elementos inteiros, sejam
# eles os objetos x, y, z. Combine os três vetores para se tornar
# uma matriz 3 x 3 em que cada coluna representa um vetor. Altere
# os nomes das linhas para a, b, e c, repectivamente

x <- c(1L, 2L, 3L)
y <- c(4L, 5L, 6L)
z <- c(7L, 8L, 9L)

mat <- cbind(x, y, z)

# Alternativamente
mat <- matrix(c(x,y,z), nrow = length(x), ncol = length(x), byrow = FALSE)

rownames(mat) <- c("a", "b", "c")

# Exercício: Crie um vetor v com 15 valores inteiros e converta-o
# em uma matriz M (5 x 3). Faça isso de duas formas diferentes. Além
# disso, nomeie as linhas de l1 a l5 e as colunas de c1 a c3. Depois,
# crie a matriz N a partir de M tal que N não possui nomes de linhas e colunas

v <- 1:15

M <- matrix(v, nrow = 5, ncol = 3)

rownames(M) <- paste("l", 1:nrow(M), sep = "") # ou 1:dim(M)[1]
colnames(M) <- paste("c", 1:ncol(M), sep = "") # ou 1:dim(M)[2]

# Também poderia usar-se o comando paste0()



# Data frame --------------------------------------------------------------

# Pesquisar pacote "tibble": data frames mais organizados

# Por se tratar de uma estrutura bidimensional assim como matrizes, todos
# os comandos como dim(), names(), colnames(), etc., poderão ser usados
# é um dataframe.

# Podemons criar um dataframe usando a função data.frama() que possui
# como entrada vetores nomeados

df <- data.frame(x= 1:3, y = c("a", "b", "c"))
str(df)

# O operador $ serve para acessar os
df$x
str(df)

# OBS: por padrão, um data frame recebe um vetor de strings como
# fator. Isso pode ser alterado pelo argumento stringAsFactors

df <- data.frame(x= 1:3, y = c("a", "b", "c"), stringsAsFactors = FALSE)
str(df)


typeof(df)
class(df)
is.data.frame(df)

df <- data.frame(x= 1:3, y = c("a", "b", "c"))
cbind(df, data.frame(z = 3:1))

rbind(df, x = 10, y = "z")


# OBS: É poosível que cada coluna de um data frame seja uma lista.
# Essa é uma das características que tornam a linguagem R flexível.
df <- data.frame(x = 1:3)
df$y <- list(1:2, 1:3, 1:4)
df




# Execício: um professor irá criar um data frame para armazenar
# as notas de 5 alunos 

alunos <- paste("Aluno", 1:5)

avaliacoes <- list(rnorm(3, 7, 2), rnorm(3, 7, 2), rnorm(3, 7, 2),
                   rnorm(3, 7, 2), rnorm(3, 7, 2))

df <- data.frame(aluno = alunos, notas = NA)

df$notas <- avaliacoes
