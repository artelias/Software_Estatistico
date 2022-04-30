# Introdução a softwares estatísticos
# Data: 24/07/2019
# Aula: 12
# Assunto: Estruturas de repetição e comandos funcionais


# Estruturas de repetição (continuação) -----------------------------------

# Exercício: baseado no exercício anterior, escreva um código que 
# receba um inteiro e tenha a segunte saída:
# n = 1         n = 2        n = 3      ...
#  A             A             A
#                BB            BB
#                              CCC

n <- 5

for(linha in 1:n){
  for(coluna in 1:linha){
    cat(LETTERS[linha])
  }
  cat("\n")
}

# R possui listas de letras em ordem alfabética, letters para minúsculas
# e LETTERS para maiúsculas.


# Exercício: Um professor que realizar um construir uma função em R
# que recebe as notas de uma aluno e informe se ele foi aprovado,
# reprovado ou irá para prova final. Neste último caso, também deve
# ser informada a nota necessária para ele ser aprovado.



aluno <- function(){      # Criando uma função sem argumentos
  
  n_avaliacoes <- as.numeric(readline(prompt = "Quantas avaliações? "))
  
  i <- 1
  
  vet_provas <- NULL
  
  for(i in 1:n_avaliacoes)
    vet_provas[i] <- as.numeric(readline(prompt = 
                                           paste("Nota",i," = ", sep = "")))
  
  media_notas <- mean(vet_provas)
  
  if(media_notas >= 7){
    situacao <- "Aprovado(a)"
    list(media_notas = media_notas, situacao = situacao)
  }
  else if(media_notas < 4){
    situacao <- "Reprovado"
    list(media_notas = media_notas, situacao = situacao)
  }
  else{
    situacao <- "Prova Final"
    nota_final <- (25 - 3*media_notas) / 2
    list(media_notas = media_notas, situacao = situacao, nota_necessaria_final = nota_final) 
  }

}

aluno() # Chamando a função que definimos


# OBS: Diferentemente de programar em C, na computação estatísticas em R não
# estamos interessados na interação com o usários e sim em funções que recebem
# argumentos e retornam objetos.



# Exercício: crie uma matriz 5 x 2 e some todos os elementos 
# de uma matriz. 
# Dica: gere aleatoriamente os números da matriz.

set.seed(0) # Fixar a semente dos números aleatórios faz com que os
            # resultados sejam replicáveis.

matriz <- matrix(runif(10), 5, 2)

soma <- 0 # Instanciar o valor antes de somar

for(coluna in 1:ncol(matriz)) # Percorrer as colunas da matriz
  for(linha in 1:nrow(matriz)) # Dentro de cada coluna, percorrer as linhas
    somaz <- soma + matriz[linha, coluna] # Adicionar cada elemento à soma

soma
  

# OBS: O exercício acima tem o objetivo de exercitar os conhecimentos em
# programação. Uma solução mais simples para o problema seria:

sum(matriz)


# Vamos tentar o mesmo para uma matriz 1000 x 1000, com um milhão de números.
# Usando loops:

set.seed(0)

matriz <- matrix(runif(1e06), 1000, 1000)

tempo_inicial <- Sys.time() # Tempo inicial do relógio
soma <- 0
for(coluna in 1:ncol(matriz))
  for(linha in 1:nrow(matriz))
    soma <- soma + matriz[linha, coluna]
Sys.time() - tempo_inicial # Diferença entre tempo inicial e final


# Usando o sum():

tempo_inicial <- Sys.time() # Tempo antes de somarmos
sum(matriz)
Sys.time() - tempo_inicial # Diferença entre tempo inicial e final


# Execícios: usando loops, retorne um vetor com as somas das colunas
# de uma matriz 10 x 10 gerada aleatoriamente.


set.seed(0)

matriz <- matrix(runif(100), 10, 10)

vetor_soma <- numeric(ncol(matriz)) # Criando um vetor de zeros de tamanho 10

for(coluna in 1:ncol(matriz)){
  soma <- 0                     # Resetamos a soma para cada coluna
  for(linha in 1:nrow(matriz)){
    soma <- vetor_soma[coluna] + matriz[linha,coluna]
    vetor_soma[coluna] <- soma
  }
}
  
vetor_soma
  
# Alternativamente, podemos usar a função apply()

apply(matriz, MARGIN = 2, FUN = sum)

# Por receber uma função como argumento, o comando apply() é o que
# chamamos de funcional.


# Comando tapply()--------------------------------------------------


# Vamos agora aprender sobre outro comando funcional, o tapply().
# O banco warpbreaks vem com o R base, e tem dados sobre testes de
# resistência de fios de lã a força de tensão, uma espécie de 
# controle de qualidade.

data(warpbreaks)

head(warpbreaks) # A instrução head() nos dá mais detalhes sobre o banco
                 # exibindo o nome das variáveis e o conteúdo das 
                 # primeiras linhas.


# O comando tapply() permite aplicar uma função a uma variável de um
# data frame e cruzar os resultados entre os valores assumidos por uma
# ou mais variáveis categóricas.


# No código abaixo, estamos somando o total de rompimentos cruzando as
# combinações entre tipo de lã (wool): A ou B, e tensão aplicada no teste
# (tension): baixa (L de "low"), média (M de "medium") ou alta (H de "high").

tapply(X = warpbreaks$breaks, INDEX = warpbreaks[,-1], FUN = sum)

# OBS: O filtro aplicado em warpbreaks como INDEX significa "todas as linhas
# de todas as colunas exceto a primeira", pois esta tem os dados numéricos
# enquanto as outras duas possuem as variáveis catégóricas.


# Mais informações sobre os comandos da "família" apply podem ser encontrados
# na documentação

?lapply
?apply
?tapply


# Comandos funcionais são bastante úteis para se varrer um data frame
# com uma função sem o uso de loops.


# OBS: Por padrão, strings informadas em data.frame são coercidas para fatores.
# Isso é controlado pelo argumento StringAsFactors, que por padrão é TRUE.
# Veja o exemplo:

x <- data.frame(a = 1:10, b = letters[1:10])
str(x$b)

levels(x$b)

# Isso é útil para se quer usar os valores assumidos pela variável de caractere
# como categorias para agrupar outras, como no exemplo do banco warpbreaks.


# Outro exemplo de tapply:

# z é um data frame com informações sobre altura (em metros), sexo e
# turma de um grupo hipotético de 8 estudantes.

z <- data.frame(altura = c(1.8, 1.6, 1.77, 1.68, 1.72, 1.65, 1.73, 1.59),
                sexo = c("M", "F", "M", "F", "F", "M", "M", "F"),
                turma = c("1", "1", "2", "2", "1", "2", "1", "2"))
z

# O comando tapply() permite que possamos separar esses estudantes
# em grupos  menores de acordo com turma e sexo, e calcular as médias
# de altura de cada subgrupo.

tapply(X = z$altura, INDEX = z[,2:3], FUN = mean)


# Comando sapply()----------------------------------------------------------

# Outro comando: funcional, o sapply() serve para alicar uma mesma função em todos
# os elementos de uma lista ou vetor, retornando um vetor com os resultados.

# A lista abaixo contém um vetor com os inteiros de 1 a 15 em ordem aleatória,
# outro com 4 números reais e finalmente um com 100 números pseudoaleatórios
# gerados de acordo com uma distribuição uniforme entre 0 e 1.

lista <- list(t1 = sample(15), t2 = c(7.7, 3.4, 4.7, 8.02), t3 = runif(100))

# O código abaixo aplica a função quantile() aos vetores de lista, retornando
# os quartis da distribução de elementos de cada um.

sapply(lista, quantile)

# OBS: A função informada deve ser apropriada para as estruturas na lista.



# Outro exemplo: Temos uma função que gera 10 números pseudoaleatórios e os
# soma, e queremos executá-la 10 vezes, guardando os resultados em um vetor.

# Função:

f <- function(i) sum(runif(10))

# Aplicando 10 vezes com loops:

vetor <- numeric(10) # Geramos um vetor de zeros

set.seed(0)

for(i in 1:10)
  vetor[i] <- f()

vetor

# Aplicando 10 vezes com comandos funcionais:

set.seed(0)

sapply(1:10, FUN = f)



# O pacote purrr fornece mais comandos funcionais, que permitem realizar
# operações mais complicadas com comandos mais curtos e maior
# desempenho computacional, a custo maior de raciocínio.
