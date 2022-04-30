# Introducao a softwares estatisticos
# Data: 12/06/2019
# Aula: 04
# Assunto: Listas, vetores, fatores



# Listas (continuação) ----------------------------------------------------


# Listas são versáteis porque direrentemente de vetores atômicos, elas pode ser heterogêneas,
# isto é, eus elementos podem ter tipos e estruturas diferentes, incluindo outras listas.
# Veja os exemlplos:

x <- list(list(list(list())))
str(x)
is.recursive(x)

x <- list(list(list(1)))
x


# Concatenação: 

c(c(1,c(2,3)))

x <- c(1, 2, 3, 4, 5)
y <- c(6, 7, 8, 9, 10)
c(x, y)

x <- list(1, 2, 3, 4, 5)
y <- list(6, 7, 8, 9, 10)
list(x, y)

# Atenção aos termos: concatenação não é o mesmo que união.
x <- c(1, 2, 3, 4)
y <- c(1, 2, 5, 6)
c(x, y) # Concatenação
union(x, y) # União (no sentido de conjuntos)


# Usando o comando em listas:
# O comando c() pode ser usado para combinar várias listas em uma só.
# Caso seja usada uma combinação atômica (mesmo tipo) de vetores e listas
# a função c() transforma os vetores em uma lista

x <- list(list(1,2), c(3,4))
y <- c(list(1,2), c(3, 4))
str(x)
str(y)

x <- list(list("1","2"), c(3,4))
y <- c(list("1","2"), c(3, 4))
str(x)
str(y)


# OBS: Outra maneira de enxergar listas é como vetores não atômicos.
# De fato, é assim que o R as vê:

is.vector(list())
is.atomic(list())


# O comado unlist() transforma os elementos de uma lista em elementos de
# um vetor. Lembrando que, em caso de elementos de tipos diferentes,
# o R converte todos para o tipo mais versátil.

y <- unlist(c(list("1", "2"), c(3, 4)))


# Rode o código abaixo e tente intepretar suas saídas

l <- c(list(c(2,3), "a"), c(1,2))
str(l)

m <- list(list(c(2,3), "a"), c(1,2))
str(m)



# O comando is.list()
# OBS: O banco de dados mtcars já vem instalado com o R, e serve para testar comandos
View(mtcars)
is.list(mtcars)

mod <- lm(mpg ~ wt, data = mtcars) # O comando lm() gera um modelo de regressão linear
is.list(mod)



# Exercício:

# A) qual a saída experada de c(1, FALSE), c("a", 1), c(list(1), "a"), c(TRUE, 1L)? Explique:

# B) Por que 1 == "1" retorna TRUE? E por que -1 < FALSE retorna TRUE?



# Em R é possível nomear os elementos de um vetor de 3 deferente maneiras:

# 1) Declarar os nomes na criação do vetor
x <- c(a = 1, b = 2, c = 3)

# Pode-se acessar um elemento tanto por seu índice como por seu nome
x[2]
x["b"]

# 2) Também é possível nomear os elementos de um vetor preexistente
x <- 1:3
names(x) <- c("a", "b", "c")

# 3) usando a função setNames()
x <- setNames(1:3, c("a", "b", "c"))


# A função names() também retorna os nomes de um vetor
y <- c(a = 1, 2, 3)
names(y)
z <- 1:3
names(z)


# Também é possível retirar os nomes dos elementos do vetor
x <- c(a = 2, b = 3, c = 4)
names(x)
names(x) <- NULL
names(x)


# Alternativamente
x <- c(a = 2, b = 3, c = 4)
names(x)
x <- unname(x)
x



# Fatores -----------------------------------------------------------------

# Fator é um vetor que recebe apenas valores predefinidos

x <- factor(c("a", "b", "b", "a")) # Elementos de x são apenas "a" ou "b"
x
class(x)
levels(x) # Vetor com os valores (níveis) que os elementos de x podem assumir


# Caso se tente atribuir um elemento que não corresponde aos níveis admitidos pelo fator
# ocorrerá uma mensagem de erro e o termo receberá NA
x <- factor(c("a", "b", "b", "a"))
x[2] <- "c"
x

# OBS: Tentar concatenar fatores resulta em comportamento indefinido
c(factor("a", "b"), factor("c", "d"))


# A função table() pode criar uma tabelas de frequêcias.
# Pode, por exemplo, criar uma tabela com os níveis de um vetor:

sex_char <- c("m", "m", "m", "f", "f", "f", "f")
sex_factor <- factor(sex_char, levels = c("m", "f", "Outros"))
table(sex_factor)
sex_factor

# Para alterar os níveis de um fator, usa-se a função levels()

sex_char <- c("m", "m", "m", "f", "f", "f", "f")
sex_factor <- factor(sex_char)
table(sex_factor)
sex_factor
levels = c("m", "f", "Outros")
table(sex_factor)
sex_factor


# O que fazem a função rev() e o objeto letters? Rode o código abaixo

# Fator com as 26 letras do alfabeto
f1 <- factor(letters); f1

# Revertendo níveis e elementos
levels(f1) <- rev(letters); f1

# Revertendo o fator
f2 <- rev(factor(letters)); f2

# Revertedo os níveis
f3 <- factor(letters, levels = rev(letters)); f3



# Removendo objetos -------------------------------------------------------

s1 <- "Eu"
s2 <- "amo"
s3 <- "a"
s4 <- "Estatística"
s5 <- paste(s1, s2, s3, s4, sep = " ")


# A função paste() concatena strings (cadeias de caracteres) usando
# um separadaor (por padrão, não há separador)
s5


# Outro exemplo
matriculas <- 1:10
nomes <- letters[1:length(matriculas)]; nomes

paste(nomes, "(", matriculas, ")", sep = "")

paste(nomes, matriculas, sep = "-")

# Listar os objetos em uso
ls()
object.size(ls())
