# Introdução a softwares estatísticos
# Data: 15/07/2019
# Aula: 09
# Assunto: Filtros de data frames

# Filtro de dados de um data frame -------------------------

# O comando data() exibe os conjuntos de dados presentes por padrão
# no R, que podem ser usados para testar funções e praticar códigos.

# Exercício:
# A) Vamos usar o conjunto statex.77 para construir o data frame "dados"

class(state.x77)
dados <- as.data.frame(state.x77)
class(dados)
View(dados)

# Nosso data frame contém dados sobre estados norte americanos, como
# população, renda, expectativa de vida, escolaridade, etc.

# B) obtenha um data frame de nome dados_1 com as observações de dados
# que possuam população maior que 4246, isto é, os estados americanos
# de população maior que 4246000 pessoas.

dados_1 <- dados[dados$Population > 4246, ]

# C) Agora, crie o dara frame com os estados de população maior que
# 4246 e menor que 8000 (8 milhões de pessoas)

dados_2 <- dados[dados$Population > 4246 & dados$Population < 8000, ]

# Quantos estados temos em dados_2?

dim(dados_2)

# D) Obtenha um vetor estados_c com os nomes dos estados selecionados
# no item anterior

estados_c <- rownames(dados_2)
estados_c

# E) Agora, construa o data frame dados_3 com os estados de população
# maior que 1.5 vezes a média dos 50 estados considerados, e obtenha um
# vetor com os nomes destes estados.

mean(dados$Population) # Aqui temos a média
1.5 * mean(dados$Population) # Aqui temos 150% da média
dados_3 <- dados[dados$Population > 1.5 * mean(dados$Population),]

estados_e <- rownames(dados_3)

# F) Construa o data frame dados_4 com os estados americanos com
# população duas vezes maior que a mediana dos 50 estados ou
# de expectativa vida de maior que 71.84

dados[dados$Population > 2*median(dados$Population),]
dados[dados$'Life Exp' > 71.84,]
dados_4 <- dados[dados$Population > 2*median(dados$Population) |
                   dados$'Life Exp' > 71.84,]

dim(dados_4)

# G) Obtenha o data frame dados_5 com os estados esstadunidanses
# com renda maior que a média nacional e expectativa de vida
# maior que 72 anos.

dados_5 <- dados[dados$Income > mean(dados$Income) &
                   dados$`Life Exp` > 72,]

# Quantos são?
dim(dados_5)

# Quais são?
estados_g <- rownames(dados_5)


# H) Adicione ao data frame dados duas linhas com a média de
# todas as variÁveis e variâncias, respectivamente.

dados

# O comando apply() percorre um data frame com uma função.
# Com o argumento MARGIN = 1, percorre as linhas, aplicando
# a função em cada uma. Para MARGIN = 2, ela percorre as colunas.
# Como queremos média e variância de cada variável (coluna), fazemos
# MARGIN = 2:
vetor_media <- apply(X = dados, MARGIN = 2, FUN = mean)
vetor_media
vetor_variancia <- apply(X = dados, MARGIN = 2, FUN = var)
vetor_variancia

# Para adicionar novas linhas ao data frame, usamos o rbind():
dados_h <- rbind(dados, Media = vetor_media, Variancia = vetor_variancia)
dados_h


# Operadores [] e [[]]-------------------------------------------

# Podemos acessar os operador $, [[]] ou [] para acessar os elementos de uma lista
# Qual é a diferença?

# Usamos [[]] para itens únicos items, e $ para itens nomeados

# Há uma metáfora útil para os operadores [] e [[]]: vagões de em trem e os
# objetos que eles contêm. x[[3]] corresponderia ao conteúdo do vagão 3,
# enquanto x[3] corresponde ao próprio vagão 3.

x <- list(1:3, "a", 4:6)

# Ao acessar nosso "trem" x, podemos acessar um vagão ou conjunto de vagões,
# ou o conteúdo de um deles.

x[3]      # Lista com os números 1,2, e 3
x[[3]]    # Vetor com os números 1,2, e 3

# O operador [] permite acessar múltiplos elementos de uma lista,
# enquanto o operador [[]] acessa um elemento único. O operador $
# é uma abreviação de [[]], usado para elementos nomeados.


# Exemplo
b <- list(a = list(b = list(c = list(d = 1))))


b[[c("a", "b", "c", "d")]]
# ...que é o mesmo que...
b[["a"]][["b"]][["c"]][["d"]]
# que é o mesmo que...
b$a$b$c$d

# Aqui terminamos o assunto "Estruturas de dados em R" e o slide Aulas1.


# Simplificação vs Preservação-------------------------------


# Quando acessamos um subconjunto de uma estrutura de dados, é
# a estrutura do objeto gerado pode ser a mesma do original
# (preservada) ou alterada (simplificada)



# Consequências da simplificação:

# I) A simplificação descarta os nomes dos objetos

x <- c(a = 1, b = 2)

x[1]   # O operador [] preserva a estrutura, mantendo o nome "a" do elemento 1.
x[[1]] # Enquanto [[]] acessa apenas o valor do elemento.


# II) A simplificação retorna o objeto dentro da lista e não uma lista de um elemento.

y <- list(a = 1, b = 2)

str(y[1])     # Este comando gera uma lista com o primeiro elemento de y
str(y[[1]])   # Já este gera um vetor numérico com o primeiro número de y



# III) A simplificação de um fator descarta os níveis não utilizados
z <- fator(c("a", "b"))
z[1]
z[1, drop = TRUE] # O argumento drop força preservação ou simplificação
                  # da estrutura do subconjunto de um objeto


# IV) Se os índices de ao menos uma das dimensões tem comprimento 1,
#     a simplificação reduz a dimensão.

a <- matrix(1:4, nrow = 2) # Matriz 2 x 2 com os números de 1 a 4

a[1,,drop = FALSE] # Exibimos uma matriz 2 x 2com uma linha com os elementos
                   # da primeira linha de a, e uma linha vazia

a[1, ]             # Temos um vetor com os inteiros da primeira linha de a


# Por padrão, filtros de um data frame simplificam a estrutura
# de dados

# Se uma das estruturas é informada e a outra é deixada em branco,
# a estrutura será preservada. Se uma das estruturas é informada
# a outra é selecionada por completo (ex: todas as linhas de uma coluna),
# a estrutura será simplificada.

df <- data.frame(a = 1:2, b = 1:2)
str(df[1])
str(df[[1]])
str(df[,"a", drop = FALSE])
df[,"a"]


# Exercício: Vamos acessar o data frame mtcars, que é padrão do R.

View(mtcars)
is.list(mtcars)

# Temos que os comandos abaixo são equivalentes
mtcars[[1]]
mtcars$mpg

# Veja que é possível passar uma variável que contém o nome do objeto
# com o operador [[]], mas não com o $
var <- "cyl"

mtcars$var
mtcars[[var]]

# Isso ocorre porque $ equivale a [[]] com o argumento exact como FALSE
# que por padrão de [[]] é TRUE. O quer dizer que é possível $ acessar
# um objeto quando o nome informado não é exatamente o real.

mtcars$cy # Em vez de "cyl"

# Veja este outro exemplo:

x <- list(abc = 1)
x$a
x[["a"]]

# Portanto, cuidado ao usar o operador $, pois euso inadequado dele
# pode levar a ambiguidades ou comportamento inesperado.


# Todos os operadores de subconjuntos estudados são compatíveis
# com a atribuição de valores. Veja os exemplos abaixo:

x <- 1:5
x[c(1, 2)] <- 2:3
x

x[-1] <- 4:1
x

# Quando a mesma posição é informada mais de uma vez, as atribuições
# ocorrem em memória mas teremos como resultado apenas o valor final.
x[c(1, 1)] <- 2:3
x

# OBS: NA passados em vetor de índices geram erros em vetores de inteiros,
# mas são permitidos em vetores lógicos (e tratados como FALSE)

x[c(1, NA)] <- c(1, 2)

x[c(T, F, NA)] <- 1


# Essa compatibilidade é útil quando queremos realizar uma atribuição
# condicional em um objeto. 
df <- data.frame(a = c(1, 10, NA))
df$a[df$a < 5] <- 0
df$a


# Aprendemos que o comando lapply() serve para aplicar uma função
# em todos os termos de uma lista. Veja os dois códigos abaixo.
# Tente entender o que eles fazem, como as atribuições funcionam
# e o que a função informada faz.

dados <- mtcars
dados <- lapply(X = mtcars, FUN = as.integer)
dados

dados <- mtcars
dados[] <-lapply(X = mtcars, FUN = as.integer)
dados


# Correspondência entre vetores-----------------------------------

# Exemplo:
grades <- c(1,2,2,3,1)
info <- data.frame(grade = 3:1, desc = c("Excellent", "Good", 
                                         "Poor"), fail = c(F,F,T))

# Usando o comando match() recebe dois um vetor como argumentos
# e associa cada elemento do primeiro com a posição em que ele
# aparece no segundo, retornado um vetor com essas posições.

# No nosso exemplo, temos um vetor "grades" com escores (notas, pontuação)
# de alunos e um data frame que associa cada escore a um conceito correspondente
# (Excelente, Bom, Ruim) e a reprovação ou não do aluno.

# O comando match() irá retornar a posição (conceito) que corresponde
# a cada elemento de grades. Se chamarmos os elementos de info usando
# essas posições, exibiremos os conceitos e reprovação (ou não)
# de cada escore.

id <- match(grades, info$grade)
info[id,]


