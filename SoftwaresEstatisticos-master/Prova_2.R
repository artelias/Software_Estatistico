# Introdução a softwares estatísticos
# Data: 26/08/2019
# Segunda Prova

# Primeira questão ------------------------------------------------

# Implemente a simulação de n lançamentos de uma moeda honesta
# e aproxime a probabilidade de obter resultado cara.

p_moeda <- function(n){
  resultados <- numeric(n)
  for(i in 1:n)
    resultados[i] <- sample(x = c(0,1), size = 1)
  mean(resultados)
}

# Fixando a semente e aplicando a função
set.seed(0)
p_moeda(1e4)
# Resultado: Para 10.000 repetições, estima-se que a probabilidade
# de obter cara em um lançamento é de aproximadamente 0.502

# Segunda Questão --------------------------------------------------------

# Seja um experimento aleatório com as seguintes regras:
# 1) Se escolhe um número entre 2 e 400
# 2) Retira-se duas bolas numeradas de 1 a 200 de uma urna (com reposição)
# 3) As retiradas ocorrem até a soma do números retirados for igual
#    ao número fixado inicialmente.
# Simule 10000 repetições desse experimento e estime o número médio de
# retiradas esperado.

m_retiradas <- function(n, N = 1e4){
  resultados <- numeric(N)
  for(i in 1:N){
    repeat{
      retirada <- sum(sample(x = 1:200, size = 2, replace = T))
      resultados[i] <- resultados[i] + 1
      if(retirada == n)
        break
    }
  }
  mean(resultados)
}

# Fixando-se a semente e aplicando a função
set.seed(0)
m_retiradas(200)
# Resultado: Para 100.000 repetições do experimento, espera-se que
# a quantidade de retiradas até a soma ser igual ao número 200 seja,
# em média, aproximadamente 200.


# OBS: Esse número esperado varia de acordo com o número escolhido.
# Seguem alguns valores de n e suas médias, para N = 1000 e set.seed(0):
# n =  25: 1768 retiradas
# n =  50: 859 retiradas
# n = 100: 399 retiradas
# n = 150: 258 retiradas
# n = 200: 195 retiradas
# n = 250: 283 retiradas
# n = 300: 385 retiradas
# n = 350: 745 retiradas
# n = 375: 1519 retiradas 


# Terceira Questão ---------------------------------------------------

# Considere um jogo com as regras abaixo:
# 1) Um jogador paga 15 dólares para começar, e ganha 1,50 por
#   lançamento de dois dados,
# 2) Caso a soma do primeiro lançamento seja par e múltipla de 3
#    o jogo acaba imediatamente,
# 3) Caso contrário, o jogador realisa os próximos lançamentos até
#    obter soma 11 ou 12.
# Simule 100000 repetições desse experimento e estime o lucro
# esperado de um jogador.

m_jogo <- function(N = 1e5){
  lancamentos <- numeric(N)
  lucro <- numeric(N)
  for(i in 1:N){
    lucro[i] <- -15
    repeat{
      soma_dados <- sum(sample(x = 1:6, size = 2, replace = T))
      lancamentos[i] <- lancamentos[i] + 1
      lucro[i] <- lucro[i] + 1
      if((soma_dados%%6) == 0 & lancamentos[i] == 1)
        break
      if(soma_dados%in% c(11,12) & lancamentos[i] != 1)
        break
    }
  }
  mean(lucro)
}

# Fixando a semente e aplicando-se a função:
set.seed(0)
m_jogo()
# Resultado: Para 100.000 repetições spera-se que um jogador tenha,
# em média, prejuizo de 3,97 dólares por partida.


# Quarta Questão -----------------------------------------------------

# Crie uma função myderiv() que determine a derivada de uma função em 
# um ponto p, sabendo que ela é definida pelo limite de 
# (f(p + h) - f(p))/h quando h tende a zero, isto é, pode ser aproximada por
# um h suficientemente pequeno, mas diferente de zero.


myderiv <- function(f,x,h = 1e-3){
  (f(x + h) - f(x))/h
}


# Exemplos de funções:
f_polinomial_1 <- function(x){
  x^2 + x + 1
  # A derivada de (x^2 + x + 1) é (2*x + 1)
}

f_polinomial_2 <- function(x){
  x^3 - 2*x^2 + x
  # A derivada de (x^3 - 2*x^2 + x) é (3*x^2 -4*x + 1)
}

f_exponencial <- function(x){
  exp(2*x)
  # A derivada de e^(2*x) é 2*e^(2*x)
}

f_logaritmo <- function(x){
  log(3*x)
  # Derivada de ln(3x) é 1/x
}

# Função myderiv() comparada com os resultados esperados pelo Cálculo Diferencial:

myderiv(f = f_polinomial_1, x = 1)           # Espera-se f'(1) = 3
myderiv(f = f_polinomial_2, x = 1, h = 1e-4) # Espera-se f'(1) = 0
myderiv(f = f_exponencial, x = 0)            # Espera-se f'(0) = 2
myderiv(f = f_logaritmo, x = 1, h = 1e-5)    # Espera-se f'(0) = 1
