# Introdução a softwares estatísticos
# Data: 04/09/2019
# Aula: 20
# Assunto: Gráficos 



# Gráficos ----------------------------------------------------------------

# Na linguagem R, temos acessos a inúmeros pacotes para criação de gráficos.
# Alguns incluem:

# graphics: vem no R base
# ggplot2: gráficos mais sofisticados que os do graphics
# plotly: gráficos interativos



# Gráfico Boxplot: o gráfico boxplot é útil para estatísticos por
# representar os quartis de uma distribuição de dados. Um retângulo
# representa as observações entre o primeiro e terceiro quartis,
# que é cortado por uma linha mais grossa que representa o 
# segundo quartil (a mediana). O gráfico também representa os limites
# superior e inferior e outliers (se existirem) do conjunto de dados.

set.seed(0)
dados <- rnorm(100)
boxplot(dados, main = c("Boxplot"), ylab = c("Domínio dos Dados"))


# Além de gerar os gráficos na aba Plots do R Studio, também é possível
# salvá-los como pdf, o que permite maior qualidade de imagem na hora
# de adicioná-los um documento TeX, por exemplo.

# Para isso se usa o comando pdf() para criar o arquivo, e após
# a execução do códigos do gráfico fecha-se o editor de pdf com o dev.off()


pdf(file= "boxplot_1.pdf", width = 9, height = 9, paper = "special",
    family = "Bookman", pointsize = 14)

# OBS: os argumentos acima corresponde a informaçoes sobre o pdf:
# tamanho da folha, tipo e tamanho da fonte. 

set.seed(0)
dados <- rnorm(100)
boxplot(dados, main = c("Boxplot"), ylab = c("Domínio dos Dados"))

dev.off()

# Procure pelo arquivo de nome boxplo_1.pdf no seu diretório em uso.



# Veja como alterar o pointsize muda o arquivo resultante:

pdf(file= "boxplot_2.pdf", width = 9, height = 9, paper = "special",
    family = "Bookman", pointsize = 7)

set.seed(0)
dados <- rnorm(100)
boxplot(dados, main = c("Boxplot"), ylab = c("Domínio dos Dados"))

dev.off()





dados <- iris


pdf(file= "boxplot_3.pdf", width = 9, height = 9, paper = "special",
    family = "Bookman", pointsize = 14)


boxplot(Petal.Width ^ Species, data = iris, ylab = c("Domínio dos Dados"),
        xlab = c("Categorias"))

dev.off()



# Gráfico de Barras -----------------------------------------------------


# Estude a documentação da função barplot(). Depois, use o data frame iris
# (vem com R base) para construir um gráfico de barras para a variável Species
# tal que a variável Petal.Width é maior que 1 e 3.2 < Sepal.Width <= 4.5

?barplot

dados <- iris


pdf(file= "boxplot_3.pdf", width = 9, height = 9, paper = "special",
    family = "Bookman", pointsize = 14)

barplot(table(subset(dados, (Petal.Width > 1) & (3.2 < Sepal.Width) &
                       (Sepal.Width <= 4.5))$Species),
        ylab = c("Domínio dos Dados"),
        xlab = c("Categorias"))

dev.off()


barplot(table(subset(dados, Petal.Width > 1 & 
                       3.2 < Sepal.Width & Sepal.Width <= 4.5)$Species),
        ylab = c("Frequência"), xlab = c("Categorias"), 
        col = c("gray90", "gray60", "gray40"))

# Plotagem de superfíceis tridimentsionais ------------------------------

# Algumas das funções a seguir requerem o pacote plot3D:

install.packages("plot3D")

library(plot3D)

# Função de duas variáveis que correpsponde à superfície que
# queremos gerar:
rosenbrock <- function(x,y){
  100 * (y - x * x)^2 + (1 - x)^2
}

# Forma 1:

# Geramos um vetor com os alguns valores de X a serem usados
x <- seq(-100,100, length = 30)

# Geramos um vetor com os alguns valores de Y a serem usados
y <- x

# Cruzamos os dois pelo comando outer(), aplicando a função desejada
# na região do plano XY.
z <- outer(X = x, Y = y, rosenbrock)

# OBS: o comando outer() cruza os valores de dois vetores com uma função
# e gera uma matriz, usando um vetor como linha e outro como coluna:
# Exemplo: o comando abaixo gera uma matriz 5 x 3 cujos elementos são
# o produto dos índices:
outer(1:5, 1:3, '*')


# Gerando o gráfico em um pdf
pdf(file= "plot_3d.pdf", width = 9, height = 9, paper = "special",
    family = "Bookman", pointsize = 14)

# O comando persp() gera uma imagem de uma superfície tridimentsional
# em perspectiva a partir de um conjunto de vetores que representam
# os valores nos eixos X, Y e Z dos pontos a serem usados para
# aproximar a superfície. Os argumentos theta e pi representam
# os ângulos sob os quais a figura é vista (como as coordenadas esféricas
# em Cálculo 3)

persp(x,y,z,theta = 3, phi = 40, expand = 0.5, col = "lightblue")

dev.off()


# Tente experimentar com esse algoritmo. Veja a superfície de outros ângulos
# ou tente gerar outras superfícies.
persp(x,y,z,theta = 0, phi = 0, expand = 0.5, col = "lightblue")

persp(x,y,z,theta = 0, phi = 180, expand = 0.5, col = "lightblue")




paraboloide <- function(x,y){
  x^2 + y^2
}
x <- seq(-10,10, length = 30)
y <- x
z <- outer(X = x, Y = y, paraboloide)
persp(x,y,z,theta = 3, phi = 40, expand = 0.5, col = "gray80")



# Forma 2:

# O comando mesh() gera uma lista com pares de valores de X e Y que pretendemos usar:
M <- mesh(seq(-100,100,length.out = 500), seq(-100,100,length.out = 500))

# Podemos obter os valores de x e Y de nossos pontos a partir dessa lista:
x <- M$x; y <- M$y

# Aplicamos a função
z <- rosenbrock(x,y)

# Aplicamos o comando surf3D, Assim como o persp(), ele gera uma imagem de uma
# superfície, mas em vez de representar a profundidade por uma "rede" de linhas
# que percorrem a superfície, ele 

surf3D(x,y,z,inttype = 1, bty = "b2", phi = 40, theta = 3)


pdf(file= "plot_3d.pdf", width = 9, height = 9, paper = "special",
       family = "Bookman", pointsize = 14)

surf3D(x,y,z,inttype = 1, bty = "b2", phi = 40, theta = 3)

dev.off()



mesa_holder <- function(x,y){
  -abs(sin(x)*cos(y)*exp(abs(1 - sqrt(x^2 + y^2)/pi)))
}

M <- mesh(seq(-10,10,length.out = 200), seq(-10,10,length.out = 200))

x <- M$x; y <- M$y

z <- mesa_holder(x,y)

surf3D(x,y,z,inttype = 1, bty = "b2", phi = 40, theta = 3)


pdf(file= "plot_mesa_holder_3d.pdf", width = 9, height = 9, paper = "special",
    family = "Bookman", pointsize = 14)

surf3D(x,y,z,inttype = 1, bty = "b2", phi = 40, theta = 3)

dev.off()





mesa_holder <- function(x,y){
  -abs(sin(x)*cos(y)*exp(abs(1 - sqrt(x^2 + y^2)/pi)))
}

M <- mesh(seq(-10,10,length.out = 400), seq(-10,10,length.out = 400))

x <- M$x; y <- M$y

z <- mesa_holder(x,y)

surf3D(x,y,z,inttype = 1, bty = "b2", phi = 40, theta = 3)


pdf(file= "plot_mesa_holder_3d_2.pdf", width = 9, height = 9, paper = "special",
    family = "Bookman", pointsize = 14)

surf3D(x,y,z,inttype = 1, bty = "b2", phi = 220, theta = 45)

dev.off()





paraboloide <- function(x,y) x^2 + y^2

x <- seq(-10,10, length = 20)
y <- seq(-10,10, length = 20)
z <- outer(x,y,paraboloide)

persp(x,y,z,theta = 90, phi = 0, expand = 0.5, col = "lightblue")


colors()

set.seed(1L)

x <- rnorm(100,4,2)
y <- rnorm(100, 0, 1.3)

hist(x, border = NA, col = "violetred3")

hist(y, add = T, border = NA, col = rgb(0.3, 0.2, 0.5, 0.8))

text(2,10, "Histogramas")

title("Título")
