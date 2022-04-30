# Introdução a softwares estatísticos
# Data: 28/08/2019
# Aula: 18
# Assunto: Algoritmos para geração de números aleatórios

# Geração de Números pseudoaleatórios -------------------------


# Os princípios e conceitos por trás da geração de números aleatórios
# como abordados nos slides de aula (função quantilíca, etc)
# vão além do objetivo da disciplina.


# Apesar disso, a implementação de seus algoritmos, não está além
# dos conhecimentos abordados em aula.


# Exercício 1: implemente uma função que recebe uma quantidade
# númerica e retorna essa quantidade de números que seguem uma
# distribuição normal pelo método polar. O algoritmo é:

# 1) Gerar duas observações uniformes em 0 e 1: U1 e U2.
# 2) Efetuar a transformação U'1 = 2*U1 - 1 e U'2 = 2*U2 - 1,
#    W = (U'1)^2 + (U'2)^2
# 3) Se W > 1, volte a 1)
# 4) Retorne as observações X = sqrt(-log(W)/W)*U'1 e
#    Y = sqrt(-log(W)/W)*U'2


# Solução:

mynorm <- function(n = 1){
  
  vetor_norm <- NULL
  
  repeat{
    # Geramos as observações uniformes.
    u <- runif(n = 2L, min = 0, max = 1)
    
    # As transformamos em u_1, u_2, e w
    u_1 <- 2*u[1] - 1
    u_2 <- 2*u[2] - 1
    w <- u_1^2 + u_2^2
    
    # Caso w  seja maior que, descartar o valor e tentar de novo
    if(w > 1)
      next
    
    x = sqrt(-log(w)/w)*u_1
    y = sqrt(-log(w)/w)*u_2
    
    # Concatenar o vetor de valores com a novas observações x e y
    vetor_norm <- c(vetor_norm, x, y)
    
    # Parar quando a quantidade n for alcançada ou superada
    if(length(vetor_norm) >= n)
      break
  }
  
  # OBS: O algoritmo sempre gera uma quantidade par de valores,
  # mas a função deve retornar exatamante a quantidade n de valores:
  
  vetor_norm[1:n]
  
}

mynorm(5)

# O comportamento desses valores se aproxima da normal?

hist(mynorm(30000))


# Exercício 2: Crie uma função para gerar números pseudoaleatórios
# que seguem uma distribuição exponencial a partir da função quantílica
# (inverso da acumulada) da exponencial: x = -log(1 - u)/lambda, onde
# u é uniforme entre 0 e 1, x é exponencial e lambda é o parâmetro de x.

myexp <- function(n = 1, lambda = 1){
  
  u <- runif(n,0,1)
  
  - log(1 - u)/lambda

}

myexp()

hist(myexp(1e4))
hist(myexp(1e4, 0.2))
hist(myexp(1e4, 3))

# OBS: o algoritmo que transforma observações uniformes em exponenciais
# é bem mais simples que os que transformam uniformes em normais porque
# a função de distribuição acumulada da exponencial é invertível.


# Exercício 3: Implemente outro algoritmo que gere números pseudoaleatórios
# normais, agora pelo algoritmo dado pelo método de Box-Muller:
# 1) Gere U1 e U2 uniformemente entre 0 e 1.
# 2) Gere R^2 = -2*log(U1) (R^2 é Exponencial) e S^2 = 2*pi*U2 (S^2 é Uniforme)
# 3) Retorne X = R*cos(S^2) e Y = R*sin(S^2)

normal_bm <- function(n = 1){
  
  vetor <- NULL
  
  repeat{
    u <- runif(2L,0,1)
    
    r2 <- -2*log(u[1])
    s2 <- 2*pi*u[2]
    
    x <- sqrt(r2)*cos(s2)
    y <- sqrt(r2)*sin(s2)
    
    vetor <- c(vetor,x,y)
    
    if(length(vetor) >= n)
      break
  }
  
  vetor[1:n]
}

normal_bm()

# Visualizando:
hist(normal_bm(3e4))


# Salvando arquivos --------------------------------------------


# Digamos que queremos salvar os resultados de uma função em arquivo,
# para não precisar executar tudo de novo toda fez que fechar o IDE.

observacoes <- normal_bm(3e4)

# Antes de salvar o arquivo, é importante saber qual o diretório (pasta)
# em que o arquivo será salvo. O comando getwd() retorna o diretório de trabalho:

getwd()

# Para alterar o diretório em usa, usa-se o comando setwd() com o caminho
# do diretório como argumento (o exemplo abaixo se aplica ao meu computador)

setwd("C:\\Users\\Carvalho\\Documents\\UFPB\\P3\\Softwares")

# OBS: A \ é um caractere reservado em R. Para acessá-lo normalmente, deve-se
# usar \\. Alternativamente, no endereço de um arquivo ou diretório pode-se
# usar a contrabarra (/)

# Ou alternativamente, Ctrl + Shift + H


# Após escolher onde salvar o arquivo, basta usar o comando save com
# o objeto e o nome do arquivo (incluindo o formato) a ser criado
# como argumentos.

save(observacoes, file = "vetor_dados_normalBM.RData")

# O formato .RData é conveniente por sua compressão de dados e 
# por ser criptografado (não se tem acesso a suas informações
# ao abri-lo com um editor de texto).


# Que tal checar se o arquivo foi realmente salvo?

# Cheque o diretório onde o arquivo foi salvo. Alternativamente,
# use o comando dir(), que lista todos os arquivos salvos no diretório
# atual:

dir()

open(file = "vetor_dados_normalBM.RData")


