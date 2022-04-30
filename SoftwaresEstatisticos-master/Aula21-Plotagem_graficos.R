# Introdução a softwares estatísticos
# Data: 09/09/2019
# Aula: 21
# Assunto: Gráficos 


# Gáficos (continuação) --------------------------------------------------

# Corra o código abaixo.

plot.new() # Cria um novo gráfico em branco
plot.window(xlim = c(0,1), ylim = c(5,10)) # Estabelece a altura e largura do gráfico
abline(a = 6, b = 3) # Gera o gráfico de uma função linear (y = b*x + a) e outras retas
axis(1) # Plotar o eixo X
axis(2) # Plotar o eixo Y
title(main = "Título principal")
title(xlab = "Eixo X")
title(ylab = "Eixo Y")
box() # "Fecha" o gráfico
grid() # Desenha uma "malha" no gráfico.


# Exercício: Use a função abline() para adicionar ao gráfico anterior uma
# linha vertical em x = 0 e uma horizontal em y = 0. Adicione também no
# gráfico as retas y = 2*x + 4 e y = 3*x + 2 com cores diferentes. Construa
# o gráfico omitindo a chamada da função box(). Dica: construa o gráfico
# com x e y entre -10 e 10.

plot.new()
plot.window(xlim = c(-10,10), ylim = c(-10,10))


# O comando axis() aceita o argumento at, que indica onde as marcações no
# eixo deverão ser feitas
axis(1, at = -10:10)
axis(2, at = -10:10)

grid()

# O comando abline() aceita alguns outros argumentos opcionais:
# h ou v: gera uma reta horizontal nas coordenadas informadas
# argumentos gráficos: col (cores), lwd (espessura de linha),
# lty (tipo de linha), etc.

abline(a = 4, b = 2, col = "red", lwd = 2)
abline(a = 2, b = 3, col = "blue", lwd = 2)
abline(h = 0, v = 0, lwd = 2)

title(main = "Gráfico de retas")
title(xlab = "Eixo X")
title(ylab = "Eixo Y")

# OBS: a ordem em que os comandos são executados altera o resultado.



# Operador '...':
# As reticências (...) servem para indicar uma lista de argumentos opcionais
# de uma função. Os argumentos opcionais são representados também
# por '...' na função e usados no argumento de funções interiores.


# Exemplo 1: f1() recebe dois valores e realiza uma operação com eles antes
# de plotar um ponto.

f1 <- function(x, y, ...){
  
  z <- sqrt(x) + y
  
  plot(z, ...)
}

# Argumentos adicionais podem ser informados, e serão usados pelo
# plot() dentro de f1().

f1(1,1)
f1(2,2, pch = 10) # pch controla o caractere usado para representar um ponto
f1(0,2, col = "blue")
f1(1,0, pch = 20, col = "green")


# Exemplo 2:

f2 <- function(x, a = 1L){
  if(x >= 0)
    sqrt(x) * a
  else
    x^2 + a
}

f3 <- function(f, y, b = 0, ...){
  f(y, ...) + b
}

f3(f = f2, b = 3, y = 7)
f3(f = f2, b = 3, y = 7, a = 2L)



f4 <- function(f, y, b, ...){
  
  # O comando '...length()' retorna a quantidade de argumentos opcionais informados
  n <- ...length()
  
  if(n >= 3)
    stop("O número de argumentos adicionais poderá ser no máximo 2.")
  if(n == 2)
    ..1 + ..2 # os comandos "..1" e "..2" acessam o valor do primeiro e segundo
              # argumentos opcionais
  else
    f(x = y, ...)
}

f4(f = f2, y = 4, b = 1)
f4(f = f2, y = 2, a = 2)
f4(f = f2, y = 2, a = 2, 2,3)
f4(f = f2, y = 2, a = 2,2,3,2)


# Exercício: use a função points() para adicionar ao gráfico do exercício
# anterior um ponto na intersecção das duas retas.

# COmandos anteriores:
plot.new()
plot.window(xlim = c(-10,10), ylim = c(-10,10))
axis(1, at = -10:10)
axis(2, at = -10:10)
grid()
abline(a = 4, b = 2, col = "red", lwd = 2)
abline(a = 2, b = 3, col = "blue", lwd = 2)
abline(h = 0, v = 0, lwd = 2)
title(main = "Gráfico de retas")
title(xlab = "Eixo X")
title(ylab = "Eixo Y")

# Comando points():
points(x = 2, y = 8, pch = 19, col = "green")



# Assim como vários comandos R, o points() aceita vetores como argumentos.
# Isso pode ser usado para representar o gráfico de uma função através de
# uma série de pontos.

funcao_reta <- function(x) 2*x + 4

line_points <- function(f, n = 50, lower = -10, upper = 10, ...){
  x <- seq(lower, upper, length.out = 100L)
  y <- f(x)

  plot.new()
  plot.window(xlim = c(lower,upper), ylim = c(lower,upper))
  axis(1, at = lower:upper); axis(2, at = lower:upper)

  grid()
  
  abline(h = 0, v = 0, lwd = 2)

  title(main = "Gráfico de pontos")
  title(xlab = "Eixo X")
  title(ylab = "Eixo Y")
  
  points(x, y, ...)
}

line_points(funcao_reta, col = "purple", pch = 20)

# OBS 1: O uso de rgb() como valor do argumento col permite escolha mais precisa de cores
# do que simplesmente usar o nome delas. Ele recebe três valores antre 0 e 1 que
# representam o brilho de cada uma das cores primárias usada para gerar a resultante.
# Cores geradas pelo rgb() também podem ter sua transparência alterada, pelo argumento
# alpha, também um número entre 0 e 1.

# OBS 2: o argumento cex representa o tamanho relativo de símbolos e texto de gráficos
# em relação ao normal.

line_points(sin, n = 30 , lower = -6, upper = 6,
            col = rgb(0,0,0, alpha = 0.4), pch = 19, cex = 3)

line_points(cos, n = 30 , lower = -6, upper = 6,
            col = rgb(0,0,0, alpha = 0.6), pch = 19, cex = 3)


f_quadratica <- function(x) x^2 - 1

line_points(f_quadratica, n = 30 , lower = -2, upper = 2,
            col = rgb(0.25,0,0.15, alpha = 0.6), pch = 19, cex = 1)
