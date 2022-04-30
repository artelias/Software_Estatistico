# Introdução a softwares estatísticos
# Data: 07/08/2019
# Aula: 15
# Assunto: Funções e Cálculo de Integrais por Monte Carlo


# Funções (continuação) ---------------------------------------

# Observe que no programa da aula anterior, se a condição avaliada
# no if() for verdadeira, a função retorna NULL e nada mais será executado.


# Seguem aqui algumas funções matemáticas e estatísticas.
# Sejam x e y vetores de dados.

# sum(x): soma de todos os elementos de x
# max(x): o maior dos elementos de x
# min(x): o menor dos elementos de x
# which.max(x): posição do maior elemento de x
# range(x): extremos de x (máximo e mínimo)

# mean(x): média dos elementos de x
# median(x): mediana
# scale(x): normaliza x (subtrai a média e divide pelo desvio padrão)
# sort(x): ordena os termos de x (po padrão, em ordem crescente)
# rank(x): cria um ranking com os elementos de x

# log(x, base): Logaritmo dos núme
# exp(x): exponencial dos elementos de x
# sqrt(x): raiz quadrada de x
# abs(x): valor absoluto de x
# round(x, n): valores de x aproximados com n casas decimais
# OBS: não confundir arredondamento com truncamento.
# Arredondar:
round(c(2.3, 1.9, 3.5))
# Truncar: descartar as casas decimais
trunc(c(2.3, 1.9, 3.5))

# cumsum(x): soma acumulada dos elementos de x
# cumprod(x): produto acumulador dos elementos de x
# match(x): retorna as posições que os elementos de x correspondem em y.
#           pode ser passado como índice para y e retornar o que os elementos de x
#           correspondem em y.
# union(x): retorna os elementos que pertencem a x ou y
# intersect(x): retorna os elementos que pertencem a x e y


# setdiff(x,y): elementos de x que não pertencem a y
# is.element(x,y): se os elementos de pertencem a y.
# semelhante ao operador %%in%%



# Algumas funções para álgebra de matrizes.
# Sejam A e B matrizes e b um vetor:

# diag(b, nrow, ncol): retorna uma matriz diagonal com
#                      os elementos de b

# t(A): retorna a matriz transposta de A

# A%*%B: produto matricial entra A e B

# det(A): retorna o determinante da matriz quadrada A

# solve(A): retorna a matriz inversa de A

# solve(A,b): resolve o sistema de equações lineares Ax = b

# eigen(A): calcula os autovalores e autovetores de A, se A for uma
#           matriz quadrada



# Exercício 1: apresente exemplos das funções apresentadas acima

# Alguns exemplos:

# sort():
sort(c(10,9,13,12))
# rank():
rank(c(3,7,4,8,2))
# union():
union(1:3, 4:8)
# intersect():
intersect(1:5, 4:8)
# setdiff():
setdiff(c(1,2,3,4), c(2,4))
# is.element():
is.element(c(1,12,5,7,19,5), 1:8)
# match():
x <- c(1,2,3,2,3,1)
y <- c("A" = 1,"B" = 2,"C" = 3)
y[match(x,y)]

b <- c(1,3)
diag(b, nrow = 4)


# Exercício 2: Refaça o exercício de estimadores usando funções



# Aproximação de intergrais por Monte Carlo ---------------------

# Imagine que queremos calcular a integral da função f(x) = sen(x)
# entre 0 e 2*pi. 
# Analiticamente, temos que a primitiva de sen(x) é -cos(x), e
# avaliando-a em 2* e 0, temos -1 -(-1) = -1 + 1 = 0

# Mas como faríamos isso computacionalmente, isto é, aproximando
# através de um algoritmo em vez de determinar a primitiva?


# Pelo cálculo integral, podemos aproximar a área sobre o gráfico de
# uma função f(x) entre x = a e x = b dividindo esse intervalo em
# n intervalos menores, avaliando a função f para x em cada um desses
# intervalos menores e multiplicando pelo tamanho desses subintervalos.
# Isso corresponde a dividir o gráfico em "retângulos" e aproximar a 
# área sobre a curva pela soma das áreas dos n retângulos.

# A integral definida de f(x) entre x = a e x = b é o limite dessa soma
# de n retângulos quando n tende ao infinito.

# Podemos simular esse cálculo gerando gerando um vetor de n números 
# pseudoaleatórios uniformes no intervalo (a,b), aplicando-os em f,
# e depois multiplicando o tamanho do intervalo pelo valor médio de f.

# Vamos voltar para nosso exemplo de f(x) = sen(x), com x entre 0 e 2*pi.

# Analiticamente, já sabemos que o valor da integral é zero. Veja agora
# como aproximamos por uma simulação de Monte Carlo.

set.seed(0)

vetor_ab <- runif(1e4, 0, 2*pi) # Aqui temos 10000 valores no intervalo

mean(sin(vetor_ab)) # Nosso Valor médio da função no intervalo

(2*pi - 0)*mean(sin(vetor_ab)) # Nossa aproximação para a integral


# Exercício: determine o valor da integral de f(x) = x^2 com x entre -1
# e 3, computacionalmente (por funções) e analiticamente (pela integral).


# Computacionalmente:

# Função que aproxima integrais recebendo o número de pontos a serem gerados,
# a função, e pontos inicial e final do intervalo.
int_mc <- function(N = 1e4, FUN, a, b){
  x <- runif(n = N, min = a, max = b)
  (b - a) * mean(FUN(x))
}

# Função f(x) = x^2
x_quadrado <- function(x){
  x ^ 2
}

# Fixando a semente
set.seed(0)

# Temos aqui nossa aproximação:
int_mc(N = 1000, x_quadrado, a = -1, b = 3)


# Analiticamente:

# A primitiva de x^2 é (x^3)/3. Avaliando em 3 e -1, temos
# 27/3 - (-1)/3 = 28/3

28/3

# Compare os resultados. Eles são próximos?


# Exercício: Vamos agora integrar a função densidade de uma v.a.
# X~Exp(1.5) de 0 a 5

x_exp <- function(x){
  lambda = 1.5
  lambda * exp( - lambda * x)
}

set.seed(0)

int_mc(N = 1000, x_exp, a = 0, b = 5)


# Exercício: Crie uma função que aproxime pi pela área delimitada
# por uma circunferência de raio 1.

# Nos exemplos anteriores, estimamos a área sobre a curva do gráfico de uma função.

# Podemos utilizar um raciocínio semelhante aqui: se considerarmos a curva 
# formada pela circunferência de raio 1 no primeiro quadrante, a proporção
# entre os pontos dentro da circunferência sobre a área total corresponde
# à área da parte da circunferência no primeiro quadrante, pi/4.

aprox_pi <- function(N = 1e4){
  
  vetor_x <- runif(n = N, min = 0, max = 1)
  
  vetor_y <- runif(n = N, min = 0, max = 1)
  
  vetor_raio <- vetor_x^2 + vetor_y^2
  
  4*length(vetor_raio[vetor_raio <= 1])/N
}

# Outra implementação do mesmo raciocínio.
# Veja que em R é possível declarar funções dentro de outras funções

aproxpi <- function(N = 1e4){
  
  x <- runif(n = N, min = 0, max = 1)
  
  y <- runif(n = N, min = 0, max = 1)
  
  # A função sucesso() checa se o ponto tem distancia ao centro
  # menor ou igual a 1
  sucesso <- function(x, y){
    ifelse(((x^2 + y^2) <= 1), TRUE, FALSE)
  }
  
  pontos_dentro <- sum(mapply(FUN = sucesso, x, y))
  
  4*pontos_dentro/N
}

set.seed(0)
aprox_pi(1e6)

set.seed(0)
aproxpi(1e6)
