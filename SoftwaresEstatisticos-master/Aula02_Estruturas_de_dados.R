# Introdução a softwares estatísticos
# Data: 05/06/2019
# Aula: 02
# Assunto: Estrutura de Dados


# Estruturas de Dados -----------------------------------------------------




# Inicializando um vetor em R
vet <- c(1, 7, 9, 7)
# x é um vetor atômico, isto é, todos os seus elementos têm o mesmo tipo
length(vet)
typeof(vet)

# Diferentemente de C, não há constantes em R, apenas vetores

# Criando um vetor dos numeros de 1 a 10
a <- 1:10

attr(a, "atributo") <- paste("Aluno_", a, sep = "")

length(a)
typeof(a)

#Vamos agora criar um vetor de inteiros. O comando runif() gera numeros de forma
# automática e tem 3 argumentos: numero, valor maximo e valor minimo
notas <- runif(10, 0,10)
typeof(notas) #notas eh um vetor de inteiros


#Adicionando um atributo ao objeto
attr(notas, "atributo") <- paste("Aluno_", 1:length(notas), sep = "")

#O objeto "notas" agora possui um atributo adicional, uma lista de alunos numerados
# (strings) e deixou de ser um vetor de inteiros. Veja
is.vector(notas)

#Adicionando um outro atributo a notas

matriz <- matrix(1:4, 2, 2) #Matriz 2 por 2 usando os numeros de 1 a 4

attr(notas, "matriz") <- matriz #notas agora tem uma lista de vetores


#O comando objects() lista todos os objetos em uso no momento
objects()

c(1,1,2,1, "Pedro")


#Vamos agora criar uma lista, um objeto heterogeneo
lista <- list(nome = "Pedro", idade = 31)
is.atomic(lista)

#Por padrao, o R usa o tamanho double para numeros informados, mesmo que sejam exatos
is.integer(31) #31 nao eh guardado como inteiro
is.double(31) #31 eh armazenado como double

#Para especificar o armazenamento de um numero como inteiro,
# nao preciso usar a letra L (de literal)
is.double(31L)
is.integer(31L)


#Tipos atomicos em R: logical, integer, numeric, complex, character, NULL e raw

a <-  NULL

a[1] <- 7
a[2] <- 70

a


x <- c(a=1, b=2)
y <- c(a=1, b=2)
attr(y, 'Ano') <- '2017'
#Eh possivel escrever dois comandos em uma linha:
is.vector(x); is.vector(y)
is.atomic(y) || is.list(y) # Como em C, || eh o operador logico "ou"

a <- 7L
a[1]
#Note que o objeto "a" eh um vetor



#Concatenando vetores
vet <- c(1, 2, c(3, 4))

vet[3]


#Quando um vetor tem elementos de tipos diferentes, o interpretador converte tudo
#para o tipo mais flexivel deles: character > double > integer > logical
a <- c(7.1, 2.3, 3L, TRUE)
b <- a + 1 #Somar 1 ao vetor a: soma 1 a todos os elementos de a
c <- a^0.5 #Exponecializar o vetor "a": exponencializa todos os elementos de a
a
b
c

#Valores faltando (Not Avalialble)


str(iris)


#comando sum()

#Convertendo usando as
bool <- c(TRUE, FALSE, TRUE, FALSE , FALSE)
as.numeric(bool)

#
a <- 1:10
a
a[-(7:10)] #ou a <- a[c(1:7)]