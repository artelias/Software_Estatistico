# Introdução a softwares estatísticos
# Data: 14/08/2019
# Aula: 16
# Assunto: Implementando funções com Monte Carlo


# Resolvendo problemas com funções e Monte Carlo ----------------------------


# Revise o assunto de estimadores abordado na aula 14. Crie uma função que 
# abranja todo o exercício anterior, isto é, que calcule estimativas para
# a variância de uma v.a. normal recebendo como argumentos o número de iterações,
# o tamanho das amostras aleatórias, e os parâmetros reais mi (média) e 
# sigma (desvio padrão).

estimadores_de_variancia <- function(N = 2e4, n = 20, mi = 0, sigma_2 = 1){
  
  
  # Vamos definir a função para variância populacional e amostral,
  # assim como no exemplo
  variancia <- function(x, pop = FALSE){
    
    if(pop)
      # variancia populaiocnal (estimador sigma2)
      sum((x - mean(x))^2)/length(x)
    else
      # Variância amostral (estimador S2)
      var(x)
  }
  
  # Vamos criar um vetor de zeros onde armazenaremos os valores de cada amostra
  amostra <- numeric(n)
  
  # Vamostambém criar vetores de zeros, onde armazenaremos os valores dos
  # estimadores em cada amostra.
  vetor_sigma2 <- numeric(N)
  vetor_s2 <- numeric(N)
  
  
  for(i in 1:N){
    
    # Geramos n valores pseudoaleatórios de acordo com os parâmetros
    # informads pelo usuário:
    amostra <-  rnorm(n = n, mean = mi, sd = sqrt(sigma_2))
    
    # Esimativa de sigma2 para a amostra
    vetor_sigma2[i] <- variancia(amostra, T)
    
    # Esimativa de S2 para a amostra
    vetor_s2[i] <- variancia(amostra, F)
  }
  
  # Ao final da função, ela deve retornar uma lista com o valor esperado,
  # viés, variância e erro quadrático médio dos indicadores sigma2 e S2.
  
  list(Valor_Esperador_Sigma2 = mean(vetor_sigma2),
       Valor_Esperado_S2 = mean(vetor_s2),
       Vies_Sigma2 = abs(mean(vetor_sigma2) - sigma_2),
       Vies_S2 = abs(mean(vetor_s2) - sigma_2),
       Variancia_Sigma2 = var(vetor_sigma2),
       Variancia_S2 = var(vetor_s2),
       Erro_Quadratico_medio_Sigma2 = (abs(mean(vetor_sigma2) - mi) + var(vetor_sigma2)),
       Erro_Quadratico_medio_S2 = (abs(mean(vetor_s2) - mi) + var(vetor_s2)))
  
}

# Avaliando nossos estimadores simulando 10000 amostras de tamanho 20 de
# uma v.a. Normal padrão.
set.seed(0)
estimadores_de_variancia(1e4,20)

# Nossa função também funciona para v.a. normal de média diferente de 0 e 
# variância diferente de 1
set.seed(0)
estimadores_de_variancia(1e4,20, 10,3)


# Exercício 2: Crie uma função que simule o arremesso de dois
# dados equilibrados e estime a probabilidade da soma das faces
# ser par, através de um número grande de lançamentos.


soma_par <- function(N = 1e4){
  
  checa_par <- function(x){
    if((x %% 2) == 0L)
      TRUE
    else
      FALSE
    }
  
  sucessos <- logical(N)
  
  for(i in 1:N){
    amostra <- sum(sample(x = 1L:6L,size = 2,replace = T))
    # Amostra de 2 números entre 1 e 6, com reposição
    sucessos[i] <- checa_par(amostra)
  }
  sum(sucessos)/N
}


# Analiticamente, sabemos que a probabilidade da soma das faces dados
# ser par é 1/2 ou 0.5, e o valor estimado pelas simulações é:

set.seed(0)
soma_par(1e5)
