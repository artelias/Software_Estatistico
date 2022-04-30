# Introdução a softwares estatísticos
# Data: 27/07/2019
# Aula: 13
# Assunto: Simulações de Monte Carlo


# Comando mapply()-------------------------------------


# Corra o código abaixo. Como você explicaria sua saída? E os argumentos?

mapply(rep, 1:4, 4:1)


# Leia a documentação.
?mapply


# O comando mapply() serve para passar os elementos de múltiplas
# listas ou vetores como argumentos para a função. Veja um outro
# exemplo:

l1 <- list(a = LETTERS[c(4,6,12,6)],
           b = LETTERS[c(1,5,21,1)])

l2 <- list(c = LETTERS[c(4,14,22,20)],
           d = LETTERS[c(15,15,1,15)])

mapply(paste, l1$a, l1$b, l2$c, l2$d)

# Neste exemplo foram informados 4 vetores de caracteres para a função paste().
# O mapply irá executar o comando paste() 4 vezes (comprimento dos vetores)
# usando como argumento os i-ésimos elementos de cada vetor. 


# Simulações de Monte Carlo ------------------------------------------------

# Uma simulação de Monte Carlo consiste em simular computacionalmente
# em experimento com números pseudoaleatórios inúmeras vezes, armazenando
# os resultados de cada iteração a fim se obter conclusões sobre esse experimento.



# Exercício 1: Walter está jogando um jogo com dois dados equilibrados de 6 lados.
# O jogo consiste em jogar os dois dados e somar os resultados.

# Caso o resultado seja múltiplo de 3, ele ganhará $ 6,00 e caso contrário,
# ele perderá $ 3,00. Simule 100 mil repetições e obtenha o valor esperado
# de um jogador.

# Analiticamente, temos 36 resultados possíveis, e os múltiplos de 3 são:
# Soma 3: (1,2), (2,1):                      probabilidade 2/36
# Soma 6: (1,5), (2,4), (3,3), (4,2), (5,1): probabilidade 5/36
# Soma 9: (3,6), (4,5), (5,4), (6,3):        probabilidade 4/36 
# Soma 12: (6,6):                            probabilidade 1/36

# Portanto, a probabilidade da soma das facessuperiores dos dados ser igual
# a um número múltiplo de 3 é de 12/36, ou 1/3 (aproximadamente 0,33 ou 33%).



# Para gerar nossos números pseudo aleatórios iremos utilizar o comando sample().
# Ele serve para simular uma amostra aleatória de elementos de um grupo inicial,
# retornando um vetor. Por padrão o argumento replace, que controla a reposição
# ou não nas amostras, é FALSE.
# Vamos aplicá-lo a uma única retirada do nosso experimento:

sample(x = 1:6, size = 2, replace = TRUE)


# Para reproduzir o código 100.000 vezes, podemos usar um loop.

# Vamos criar dois vetores inicialmente vazios para guardar os resultados

# Lembrando que R aceita notação científica. 100000 pode ser representado
# por 1e5, que significa "1 vezes 10 elevado a 5"

sucessos <- numeric(1e5) 
fracassos <- numeric(1e5)


for(i in 1:1e5){
  dados <- sample(x = 1:6, size = 2, replace = TRUE)
  if( (sum(dados) %% 3) == 0)
    sucessos[i] <- 1
  else
    fracassos[i] <- 1
}

# Somando os sucessos/fracassos e dividindo pelo número de repetições...

sum(sucessos)/1e5
sum(fracassos)/1e5

# ...os resultados encontrados correspondem ao esperado?



# Exercício 2: Suponha que tenhamos uma urna com bolas de mesmo tamanho
# enumeradas de 1 a 100. Considere o experimento aleatório de retirar
# uma bola e observar seu número até obtermos a bola com o número desejado,
# escolhido anteriormente de forma arbitrária.

# Neste experimento, será considerada a reposição, isto é, caso a observação
# não seja o número desejado, a bola será devolvida à urna.
# Simule no computador 10.000 repetições e obtenha a média das retiradas
# necessárias para se obter o número escolhido.

# Solução:

# Se definimos o total de retiradas até se encontrar o número desejado como uma 
# varíavel aleatória X, ou seja, repetições independentes de um experimento até
# o primeiro sucesso, temos neste experimento uma v.a. Geométrica com p = 1/100.
# Ou seja, analiticamente, nosso valor esperado para as retiradas é 1/p = 100 retiradas.


# Computacionalmente:

resultados <- numeric(1e4) # Vetor vazio para os resultados

num <- 13 # Número escolhido

for(i in 1:1e4){
  
  retiradas <- 0 
  
  repeat{ 
    bola <- sample(x =1:100L, size = 1L)
    retiradas <- retiradas + 1           
    
    if(bola == num) 
      break
  }
  
  resultados[i] <- retiradas
}

mean(resultados)


# Exercício 3: Um dono de cassino estuda disponibilizar um novo jogo
# e solicita uma consultoria estatística para saber se o jogo será
# viável para o cassino, isto é, se o valor esperado do lucro é positivo.
# Regras:

# 1) O jogador para $ 10,00 para começar a jogar e lucra 1,50 a cada lançamento

# 2) Dois dados são lançados e caso a soma seja 5,6,7,8, ou 9, o
# jogo termina imediantamente.

# 3) Se nenhum dos lançãmentos acima for obtido, o jogador continua os lançamentos
# até obter soma igual a 11 ou 12.

# Realize uma siulação de 100.000 jogos e obtenho o valor médio dos lançamentos,
# a probabilidade aproximada do jogador realizar apenas um lançamento,
# e o lucro esperado por jogador no cassino.


resultados <- numeric(1e5)
lucro <- numeric(1e5)

for(i in 1:1e5){
  
  lucro[i] <- -10
  lancamentos <- 0 
  
  repeat{
    lancamentos <- lancamentos + 1
    lucro[i] <- lucro[i] + 1.5
    dados <- sample(x =1:6, size = 2, replace = TRUE)
    
    # Para determinar se a soma é igual a um dos valores em um vetor,
    # usaremos o operador %in% (mais informações na Aula 10)
    
    # Para o primeiro lançamento
    if((dados[1] + dados[2]) %in% c(5,6,7,8,9) && lancamentos == 1)
      break
    
    # Para os outros lançamentos
    if((dados[1] + dados[2]) %in% c(11,12) && lancamentos != 1)
      break
  }
  
  resultados[i] <- lancamentos
}

# OBS: quando se lida com operações em loops, geralmente há mais de uma
# maneira correta de se chegar a um mesmo resultado


# Lucro esperado de um jogador
mean(lucro)

# Número médio de lançamentos
mean(resultados)

# Probabilidade aproximada de realizar apenas um lançamento 
length(resultados[resultados == 1])/1e5

# Para mais informações sobre os resultados, como máximo e mínimo,
# podemos usar o comando summary

summary(lucro)
summary(resultados)


# Caso queiramos uma representação visual do lucro, podemos criar
# um histograma simples

hist(lucro)
grid(lwd = 1)

# E então, que conclusões podemos tirar desse jogo do Exercício 3?

