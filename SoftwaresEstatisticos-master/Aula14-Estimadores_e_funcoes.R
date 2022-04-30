# Introdução a softwares estatísticos
# Data: 31/07/2019
# Aula: 14
# Assunto: Estimadores e funções


# Estimadores --------------------------------------------------------

# Exercício: Seja X1, X2, ... , Xn uma amostra aleatória da variável
# aleatória X~N(mi, sigma2). Além disso, considere os seguintes 
# estimadores da variância sigma de X, sigma_c2 e S2, apresentados abaixo:

# sigma_c2 = somatório((Xi - media_amostral)^2) / n

# S2 =  somatório((Xi - media_amostral)^2) / (n - 1)

# Uma forma de compararmos dois estimadores é através do Erro Quadrático
# Médio (EQM) dos estimadores. Dessa forma, sejam theta_1 e theta_2 dois
# estimadores para um parâmetro theta desconhecido. Diremos que theta_1 
# é melhor que theta_2 se:

# EQM(theta_1) <= EQM(theta_2)

# Onde EQM(theta_) = E[(theta_c - theta)^2] (valor esperado do quadrado da
#                                           diferença entre o estimador e
#                                           o parâmetro)

# Ou também: EQM(theta_c) = Var(theta_c) + (E(theta_c) - theta)^2
#            (soma da variância e do quadrado da diferença entre o valor
#             esperado do estimador e do parâmetro. Esta diferença também
#             é chamada viés.)



# Exercício: Abaixo está representado um algoritmo para implementação
# da simulação, em que levará em consideração 20000 iterações.

# Para cada uma das 20000 iterações:
# 1) Gere uma amostra aleatória de tamanho n, tal que Xi~N(0,1) (X tem
# distribuição normal de média zero e variância 1), para todo i.
# 2) Obtenha as estimativas sigma_c2 e S2
# 3) Calcule o EQM e o viés tanto de sigma_c2 e de S2 


# Temos que os estimadores sigma_c2 e S2 correspondem à variância
# populacional e amostral, respectivamente.


variancia <- function(x, pop = FALSE){
  
  # Para o argumento "pop" (população)
  
  if(pop)
    sum((x - mean(x))^2)/length(x)
  else
    var(x) # var() é a o cálculo de variância amostral:
           # var(x) = sum((x - mean(x))^2)/(length(x) - 1)
}


# Mais informações sobre var()

?var
stats::var


# Agora os dados

N <- 2E4
n <- 20 

# Vetores de zeros

vetor_sigma2 <- numeric(N)
vetor_s2 <- numeric(N)

# Para replicação dos resultados

set.seed(0)

for(i in 1:N){
  amostra <- rnorm(n = n, mean = 0, sd = 1) # Amostra
  
  vetor_sigma2[i] <- variancia(x = amostra, pop = TRUE) # Variância Populacional
  vetor_s2[i] <- variancia(x = amostra, pop = FALSE)    # Variância Amostral

}

# Média dos estimadores. Qual deles se aproximou mais do valor
# real do parâmetro, variância de X?

mean(vetor_sigma2); mean(vetor_s2)

# Viés dos estimadores. (diferença entre o valor esperado do estimador
# e valor verdadeiro do parâmetro) 

bias_sigma2 <- mean(vetor_sigma2) - 1
bias_s2 <- mean(vetor_s2) - 1

# Em módulo:
abs(bias_sigma2); abs(bias_s2)


# Variância dos estimadores. Qual deles á mais eficiente? (variância menor)

var_sigma2 <- var(vetor_sigma2); var_s2 <- var(vetor_s2)

var_sigma2; var_s2


# Erro Quadrático Médio. Qual deles é mais consistente? (menor EQM)

eqm_sigma2 <- var_sigma2 - (bias_sigma2)^2
eqm_s2 <- var_s2 - (bias_s2)^2

eqm_sigma2; eqm_s2

# De acordo com seus conhecimentos de Probabilidade e Inferência,
# o que se esperava desses resultados?


# Funções ---------------------------------

# Sintaxe da declaração de uma função em R:

# nome_da_funcao <- function(argumentos){
#                 bloco de código da função
# }

# OBS: Sobre funções de mesmo nome: a presença de duas funções de
# mesmo nome em pacotes R instalados não causa erros, mas sua
# execução, sim. Algumas soluçoes para se contornar esse problema são:

# 1) Criar funções cujo nome não está sendo usado, como foi 
# feito anteriormente para o cálculo da variância

# 2) Explicitar o ambiente da função ao chamá-la

stats::var() # Função para cálculo de variância que vem do pacote stats

# A aba "Environment" permite ver os objetos (valores, data frames,
# funções, etc.) em uso. De acordo com seu ambiente. Assim, é possível
# utilizar duas funções de mesmo nome mas comportamentos diferentes
# desde que se expecifique de onde elas vêm.


# Apesar de ser desejável que uma função contenha argumentos que
# possam receber dados e informações de como processar as informações
# passadas, é possível que uma função não possua nenhum argumento.

funcao <- function(){
  cat(paste(c("<3", LETTERS[c(1,13,15)], " ", LETTERS[c(13,5,21)],
              " ", LETTERS[c(16,18,15,6,5,19,19,15,18)], "<3"),
            collapse = " "))
}


# Note que a criação de uma função consiste na atribuição do
# conteúdo no bloco de código que compõe a função e seus
# argumentos a um nome, como qualquer objeto da linguagem R.


# Exemplo: corra o código abaixo. Ele corresponde a uma função que
# converte o valor de uma temperatura em graus Celsius para o valor
# correspondente em graus Fahrenheit.

celsiustofar <- function(cel){ # Argumento da função: temperatura informada
  
  temperatura <- 1.8 * cel + 32 # instrução a ser executada
  
  temperatura # Resultado a ser retornado
}

# OBS1: em C, é preciso explicitar o que uma função deve retornar.
# Em R, por padrão se retorna o resultado da última operação da função.

# OBS2: Como em outros comandos, caso a função a ser criada ocupe apenas
# uma linha, os {} são opcionais. A função celsiustofar() poderia ter
# sido declarada assim:

celsiustofar <- function(cel) temperatura <- 1.8 * cel + 32


# Exercício: Considere no exemplo o vetor abaixo. Quais alterações são
# necessárias para que nossa função celsiustofar() converta todas as 
# 11 teperaturas de uma vez?

temp <- c(27.8, 19.3, 20.7, 18.29, 25.0, 25.1, 32.3,
          37.6, 32.2, 19.02, 22.75)

# Resposta: nenhuma! R é uma linguagem vetorial, ou seja, enquante em C
# poderíamos ter uma variável com apenas um valor, em R ela é na verdade
# um vetor com apenas um elemento. Portanto, diferentemente de C, em R
# não é preciso um loop para se percorrer um vetor com nossa função

celsiustofar(25)

celsiustofar(temp)


# Agora, altere a função celsiustofar() apresentada no exemplo anterior
# de modo que a função possa conveter a temperatura de graus Celsius
# para Fahrentheit ou de graus Fahrenheit para Celsius


temp_convert <- function(temp, c_para_f = TRUE){
  
  # É possível instanciar valores padrão para os argumentos de funções
  # Isso se faz quando se dá um valor na declaração da função, e este
  # será utilizado caso o usuário não o informe.
  
  
  c_para_f <- as.logical(c_para_f) # Caso c_para_f seja informado como uma
                                   # string, é possível converter para 
                                   # um valor lógico
  
  if(! is.logical(c_para_f) | is.na(c_para_f)) # Em caso de erros
    stop("Um valor lógico não foi informado.")
  
  if(c_para_f == TRUE)
    temperatura <- 1.8 * temp + 32
  
  else
    temperatura <- (temp - 32) /1.8 # Operação reversa à anterior
    
  temperatura
    
}

temp_convert(100)
temp_convert(100, TRUE)
temp_convert(100, FALSE)

# OBS: Os comando stop() e warning() servem para exibir mensagens 
# de erro ou aviso, respectivamente, no prompt do R.

stop("Exemplo de uma mensagem de erro.")

warning("Exemplo de uma mensagem de aviso.")

# A diferença está no fato de stop() interromper imediatamente a
# execução do código e warning() não, sendo exibido apenas após
# a execução do código. Eles servem para indicar para o usuário
# que a função está sendo usada de forma incorreta ou inaporpriada.

for(i in 1:5){
  cat("Iteração",i,"\n", sep = " ")
  if(i == 3)
    stop("O stop() parou o loop")
}

for(i in 1:5){
  cat("Iteração",i,"\n", sep = " ")
  if(i == 3)
    warning("O warning() não parou o loop.")
}

# Exercício: construa uma função que calcula o IMC (Índice de Massa
# corpórea) de uma pesoa e retorne o IMC e a situação da pessoa
# em relação ao peso.

# Nota: IMC = peso / (altura^2)

funcao_imc <- function(peso, altura){
  
  # A altura deverá ser informada em metros.
  # O peso deverá ser informado em kg.
  
  # Podemos fazer com que o programa não retorne nada
  # para informações negativas
  
  if(peso <= 0 || altura <= 0)
    return(NULL)
  
  if(altura >= 3)
    warning("Dados... estranhos.")
  
  imc <- peso/(altura^2)
  
  if(imc < 17)
    situacao <- "Muito abaixo do peso"
  else if(imc >= 17 && imc < 18.49)
    situacao <- "Abaixo do peso"
  else if(imc >= 18.5 && imc < 24.49)
    situacao <- "Peso normal"
  else if(imc >= 25 && imc < 29.49)
    situacao <- "Acima do peso"
  else if(imc >= 30 && imc < 34.99)
    situacao <- "Obesidade I"
  else if(imc >= 35 && imc < 39.99)
    situacao <- "Obesidade II (severa)"
  else
    situacao <- "Obesidade III (mórbida)"
  
  
  list(imc, situacao)
    
}

# OBS: caso se deseje que o programa termine e retorne algo
# antes do fim do bloco de código, basta usar a instrução return().
