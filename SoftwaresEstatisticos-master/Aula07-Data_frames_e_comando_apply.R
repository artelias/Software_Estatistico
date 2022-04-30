# Introdução a softwares estatísticos
# Data: 08/07/2019
# Aula: 07
# Assunto: Dataframes

# Data frames (continuação)------------------------------------

# Na aula passada, tentamos criar um data frame onde uma das
# variáveis é uma lista. Veja que primeiro criamos o data frame 
# com a variável vazia, e então atribuímos a lista como valor.
# O propósito foi mostrar que cada célula de um data frame pode
# ser um vetor

alunos <- paste("Aluno", 1:5, sep = "_")

avaliacoes <- list(c(6.5, 7.2, 8.1), c(7.7, 5.6, 6.9), c(4.3, 5.5, 8.3, 6.0),
                   c(9.5, 7.2, 6.0), c(8.0, 9.5))

df <- data.frame(aluno = alunos, notas = NA)

df$notas <- avaliacoes

# Porém, observe que atribuir uma lista no momento de criação do data frame gera um erro.
# Veja:

df <- data.frame(aluno = alunos, 
                 notas = list(c(6.5, 7.2, 8.1),c(7.7, 5.6, 6.9), c(4.3, 5.5, 8.3, 6.0),
                                              c(9.5, 7.2, 6.0), c(8.0, 9.5)))

# O comando I() previne esse erro

dfl <- data.frame(x = 1:3, y = I(list(1:2, 1:3, 1:4)))

# Mais informações
?I


# A função lapply() permite que se aplica uma função a todos
# os elementos de uma lista. Veja os exemplos para média e
# soma das notas do nosso daa frame anterior.

lapply(X = df[,2], FUN = mean)

lapply(X = df[,2], FUN = sum)

# Também é possível passar funções além das convencionais como argumento.

soma_um <- function(x){
  x + 1
}

lista <- c(1,2,3,4)

lapply(X = lista, FUN = soma_um)

# O R também permite que o conteúdo de uma variável em um data frame
# seja uma matriz

dfm <- data.frame(x = 1:3, y = I(matrix(1:9, nrow = 3)))

# Podemos acessar a matriz y pelo operador $
dfm$y

# Também podemos especificar a linha da matriz y, também
dfm[2, "y"]


# Assim como o comando lapply() funciona com listas, o apply()
# funciona com matrizes e data frames. A diferença está no fato
# de serem estruturas multidimensionais: é preciso especificar se
# a função será aplicada por linhas através do argumento MARGIN


# No nosso exemplo, vamos gerar as notas aleatoriamente seguindo 
# uma distribuição uniforme. O comando runif faz isso, recebendo
# como argumento a quantidade de números a gerar e os valores
# máximo e mínimo.

avaliacoes <- matrix(runif(n = 15, min = 6, max = 10), ncol = 3, nrow = 5)

# Para mais detalhes:
?runif

alunos <- paste("Aluno", 1:5)

historico <- data.frame(aluno = alunos, notas = I(avaliacoes))

historico$notas

# Qual é soma das notas de cada aluno?
apply(historico$notas, MARGIN = 1, FUN = sum)

# Qual é média das notas de cada aluno?
apply(historico$notas, MARGIN = 1, FUN = mean)

# Quais são os quartis das distribuiçoes de notas de cada aluno?
apply(historico$notas, MARGIN = 1, FUN = summary)


# OBS: Adicionado e removendo colunas de um data frame-------

# Adicionado uma nova coluna
notas <- apply(historico$notas, MARGIN = 1, FUN = mean)

historico$nota4 <- notas


# Renomeando uma coluna

nomes <- colnames(historico)

nomes[3] <- "media"

colnames(historico) <- nomes


# Removendo uma coluna

historico <- historico[,-3]

# Isso remove todos os elementos da terceira coluna. Veja com
# mais detalhes na seção a seguir



# Acessando subconjunto de um vetor -------------------------------

x <- c(2.1, 4.2, 3.3, 5.4)

# O comando order() serve para ordenar os termos de um vetor

# Por padrão retornará as posições...
order(x)

# ... e quando passado como índice, retorna o vetor ordenado
x[order(x)]


# É possivel acessar subconjuntos de um vetor passando um vetor
# para índices dos valores desejados.
x[c(1,3)]


# OBS1: Índices repetidos retornam o mesmo valor
x[c(1,1)]


# OBS2: Valores reais são truncados (a parte real é desconsiderada)
x[c(2.5, 3.9)]


# Também se pode remover termos de um vetor desse método
x[-4] # Sem o quarto elemento
x[-c(1,2)] # Sem o primeiro e o segundo elementos
x[c(-3,-4)] # Sem o terceiro e o quarto elementos


# OBS3: Também se pode passar valores lógicos como índices.

x[c(TRUE, FALSE, TRUE, FALSE)]

# Caso o vetor lógico seja menor que x, ele será reciclado (repetido)
x[c(FALSE, TRUE)]


# Isso permite a busca de termos através de expressões lógicas

x[x > 3] # Elementos de x maiores que 3
x[x > 3 & x < 5] # Elementos de x maiores que 3 e menores que 5


# OBS4: NA no índice gera NA na posição. NÃO é o mesmo que FALSE.
x[c(TRUE, FALSE, NA, TRUE)]


# Também podemos chamar elementos por seus nomes
y <- setNames(x, letters[1:4])
y[c("a", "c", "b")]

# Chamar um nome que não corresponde a elemento algum retorna NA
z <- c(abc = 1, def = 2)
z
z[c("a", "b")]


# Essa sintaxe também funciona para arrays e data frames.
# Veja o exemplo abaixo com uma matriz

a <- matrix(1:9, nrow = 3) # matriz 3x3 com os números de 1 a 9

colnames(a) <- c("A", "B", "C") # Nomeando as colunas
a[1:2,] # Linhas 1 e 2, todos as colunas

a[c(T,F,T), c("B", "A")] # Primeira e terceira linhas, colunas "B" e "A"

a[0, -2] # Nomes das colunas, excluindo a segunda

# Comando outer()------------------------------------------------------

# O comando outer() aplica uma determinada operação em todas as combinações
# possíveis dos elementos dos argumentos X e Y, gerando um array que contém
# os resultados.

x <- 1:3
y <- 4:6

soma_xy <- outer(X = x, Y = y, FUN = "+")
dif_xy <- outer(X = x, Y = y, FUN = "-")

?outer


# O código abaixo está aplicando o comando paste() para todos
# os números de 1 a 5
vals <- outer(1:5, 1:5, FUN = "paste", sep = ",")


# Ainda é possível buscar elementos com um vetor como índice.
# Note que os elementos são contados por coluna.
vals[c(4, 15)]


# Também é possível acessar os elementos de um array usando uma
# matriz com os pares ordenados dos elementos desejados
 
select <- matrix(ncol = 2, byrow = TRUE, c(1,1,3,1,2,4))
select
vals[select]


