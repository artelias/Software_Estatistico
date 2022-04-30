# Introdução a softwares estatísticos
# Data: 18/09/2019
# Aula: 24
# Assunto: Terceira Prova 

# Questão 1 ---------------------------------------------------------------

# Implemente uma função em R que gere números pseudoaleatórios  que seguem
# o seguinte algoritmo (método polar):

# 1) Gerar duas observações que seguem uma uniforme entre 0 e 1, U1 e U2.
# 2) Transformar U1 e U2 em U'1 = 2*U1 - 1  e U'2 = 2*U2 -1
# 3) Fazer W = (U'1)^2 e (U'2)^2. Caso W>1, voltar ao passo 1)
# 4) Fazer X = raiz de -(log(W)/W)*U'1 e Y = raiz de -(log(W)/W)*U'2
# 5) X e Y seguirão uma normal padrão.


normal <- function(n = 1){
  
  vetor_norm <- NULL
  
  repeat{

    u <- runif(n = 2L, min = 0, max = 1)

    u_1 <- 2*u[1] - 1
    u_2 <- 2*u[2] - 1
    w <- u_1^2 + u_2^2

    if(w > 1)
      next
    
    x = sqrt(-log(w)/w)*u_1
    y = sqrt(-log(w)/w)*u_2
    
    vetor_norm <- c(vetor_norm, x, y)
    if(length(vetor_norm) >= n)
      break
  }
  
  vetor_norm[1:n]
  
}



# Questão 2 ---------------------------------------------------------------



# Questão 3 ---------------------------------------------------------------



empirical1 <- function(x,...){
  plot.new()
  plot.window(xlim = range(x), ylim = c(0,1))
  axis(1);axis(2)
  title(xlab = "x", ylab = "Probabilidade",
        main = "Gráfico da Distribuição Empírica")
  
  grid(lwd = 2)
  
  
  
  t <- seq(min(x),max(x),length.out = length(x))
  
  y <- numeric(length(x))
  
  for(i in 1:length(x)){
    y[i] <- length(subset(x, x <= t[i]))/length(x)
  }  
  
  lines(t,y,...)
}

# Uma maneira mais direta, mas que exige connhecimento da função
# quantile:

?quantile

empirical2 <- function(x,...){
  plot.new()
  plot.window(xlim = range(x), ylim = c(0,1))
  axis(1);axis(2)
  title(xlab = "x", ylab = "Probabilidade",
        main = "Gráfico da Distribuição Empírica")
  
  grid(lwd = 2)
  
  mtext("Dados")
  
  lines(quantile(x, probs = seq(0,1,length.out = length(x))),
        seq(0,1,length.out = length(x)),...)
}


# Testando:

set.seed(0)

x <- rnorm(100,0,1)

empirical1(x, lwd = 2, col = "blue")

empirical2(x, lwd = 2, col = "purple")



# Questão 4 ---------------------------------------------------------------

# Implemente uma função que plot o gráfico de uma circunferência.
# Algumas especificações são:

# 1) A circunferência será centrada na origem e o plano abrange todo o
#    raio da cicunferência. Este deverá ser recebido como argumento
#    (por padrão 1)
# 2) O gráfico tem título e subtítulo (o raio será exibido no subtítulo)
# 3) A circunferência é cortada por dois segmentos de reta (um horizontal
#      e outro vertical) que passam pela origem. Um ponto marca a origem.
# 4) A função recebe argumentos gráficos opcionaos para a curva da
#     circunferência, e apenas para a curva.

# Dica: Uma circunferência de raio 2 no plano xy e centrada na origem
# é expressa pela equação x^2 + y^2 = r^2, e o caractere do ponto
# na origem é o 19.


circunferencia <- function(r = 1,...){
  plot.new()
  plot.window(xlim = c(-r,r), ylim = c(-r,r))
  axis(1);axis(2)
  title(xlab = "x", ylab = "y",
        main = "Gráfico de Cicunferência")
  mtext(paste("r = ", r, sep = ""))
  
  x <- seq(from = -r, to = r, length.out = 1e3)
  y1 <- sqrt(r^2 - x^2)
  y2 <- -y1
  
  lines(x,y1,...)
  lines(x,y2,...)
  
  segments(x0 = 0, y0 = -r, x1 = 0, y1 = r)
  segments(x0 = -r, y0 = 0, x1 = r, y1 = 0)
  
  points(0,0,pch = 19)
}

# Teste:
circunferencia(3,col = "red", lwd = 2, lty = 2)






      