# Introdução a softwares estatísticos
# Data: 16/09/2019
# Aula: 23
# Assunto: Gráficos 


# Gráficos (continuação) -------------------------------------------

# No R, o padrão inicial de cores é definido por preto (black), vermelho
# (red), verde (green3), azul (blue), ciano (cyan), magenta (magenta),
# amarelo (yellow), e cinza (gray). Pode-se visualizar esses tons
# pelo código abaixo:

barplot(rep(1,length(palette())), col = palette(),
        names.arg = palette(), main = "Palheta de cores", border = F,
        axes = F)

# A função palette() retorna o nome das cores consideradas como padrão
# na palheta de cores. É possível fazer alterações nessa seleção.

# Outra maneira de obter mais cores para se usar é criando rampas
# entre cores, gerando tons intermediários entre elas, aumentando
# o número de cores à disposição.

# Exemplo: o código a seguir gera uma rampa de cores entre o ciano
# e o azul em um gráfico de setores

rampa <- colorRampPalette(colors = c("cyan", "blue")) # Rampa de cores

cores <- rampa(20) # Queremos considerar 20 cores entre ciano e azul
x <- rep(1,times = length(cores))
names(x) <- as.character(cores) # Nomes das cores (dados em hexadecimal)
pie(x = x, col = cores, border = F, cex = 0.7) # Grágico de setores


# É possível contruir rampas muito grandes de cores. 
# Veja os exemplos onde alteramos o número de cores na rampa:

rampa1 <- colorRampPalette(colors = c("cyan", "blue"))
cores <- rampa(200)
x <- rep(1,times = length(cores))
pie(x = x, col = cores, border = F, cex = 0.7, labels = NA)

rampa <- colorRampPalette(colors = c("cyan", "blue"))
cores <- rampa(2000)
x <- rep(1,times = length(cores))
pie(x = x, col = cores, border = F, cex = 1.2, labels = NA)

class(rampa)



# Exercício 1: Com a função colorRampPalette() é possível
# escolher mais de duas cores para criar uma rampa de cores
# Construa um gráfico de setores considerando uma rampa de
# 2 mil cores entre o vermelho, ciano, azul, verde, amarelo
# magenta, e vermelho novamente:

rampa <- colorRampPalette(colors = c("red","cyan", "blue", "green",
                                     "yellow", "magenta", "red"))
cores <- rampa(2000)
x <- rep(1,times = length(cores))
pie(x = x, col = cores, border = F, cex = 1.2, labels = NA)


# OBS: Sistemas de cores buscam transforma o espectro de luz visível
# em algo discreto que posa ser representado num computador. Existem
# vários sistemas, e a função colorRampPalette() permite que usemaos
# o RBG ("Red, Green, Blue", as cores primárias desse sistema) que
# proporciona cores mais uniformes.
# Como pode ser visto no primeiro gráfico de setores, os nomes das
# cores são dados por números hexadecimais, onde cada par corresponde
# ao valor da intensidade de cada cor primária utilizada (vermelho, verde
# e azul). Cada intensidade assume valores entre 0 (00, masi escuro) e
# 255 (FF, mais claro). Assim, o sistema RGB pode representar 256^3 cores,
# ou aproximadamente 16,7 milhões.


# Exercício 2: Construa um gráfico de barras (pelo barplot()) com
# as cores primárias do sistema de representação de cores RGB
# usando a notação hexadecimal das cores.

barplot(c(1,1,1), col = c("#FF0000", "#00FF00","#0000FF"),
        names.arg = c("Vermelho", "Verde", "Azul"),
        main = "Cores Primárias do Sistema RGB", border = F, axes = F)


# Exercício 3: Construa um gráfico de barras com as cores secundárias
# do sistema RGB usando a notação hexadecimal.

barplot(c(1,1,1), col = c("#FFFF00", "#00FFFF","#FF00FF"),
        names.arg = c("Amarelo", "Ciano", "Magenta"),
        main = "Cores Secundárias do Sistema RGB", border = F, axes = F)


# Exercício 4: Usando os dados obtidos por "set.seed(0); rnorm(1000, 0, 1)"
# construa um gráfico tipo histograma onde valores menores que -1.625 
# ou maiores que 1.625 receberam nível maior de transparência.

set.seed(0)
dados<- rnorm(1000, 0, 1)
histograma <- hist(dados)

plot.new()
plot.window(xlim = c(-5,5), ylim = c(0,0.5))
axis(1, at = -5:5);axis(2)
title(xlab = "Dados", ylab = "Frequência", main = "Histograma de dados")
mtext("Introdução a Softwares Estatísticos - UFPB")

cores <- ifelse(histograma$mids <= -1.625, rgb(1,0,0,0.2), 
                ifelse(histograma$mids >= 1.625, rgb(1,0,0,0.2), 
                       rgb(1,0,0,0.7)))

hist(dados, probability = T, add = T, col = cores, border = F)

abline(v = 0, lty = 2)


# Agora plote a densidade da normal nesse histograma:

# Criamos uma sequência de valores de x que usaremos
# para desenhar a curva:
x <- seq(-5,5, length.out = 1e3)
# Os valores de x serão aplicados numa normal com média e desvio
# padrão (a dnorm() recebe o desvio como argumento, e não a variância)
# vindos da distrbuição dos dados:
y <- dnorm(x, mean(dados), sd(dados))

lines(x, y, col = "red", lwd = 2)

     
# E agora para duas distribuições em um mesmo gráfico:

set.seed(0)
dados1 <- rnorm(1000, -1.5, 1.5)
dados2 <- rnorm(1000, 2.5, 0.8)

plot.new()
plot.window(xlim = c(-5,5), ylim = c(0,0.6))
axis(1, at = -5:5);axis(2, at = c(0,0.2,0.4,0.6))
title(xlab = "Dados", ylab = "Frequência", main = "Histograma de Normais")
mtext("Introdução a Softwares Estatísticos - UFPB")

hist(dados1, probability = T, add = T, col = rgb(0,0.25,0,0.6), border = F)
hist(dados2, probability = T, add = T, col = rgb(0,0,1,0.6), border = F)

abline(v = 0, lty = 2)

x <- seq(-5,5, length.out = 1e3)
y1 <- dnorm(x, mean(dados1), sd(dados1))
y2 <- dnorm(x, mean(dados2), sd(dados2))

lines(x, y1, col = "darkgreen", lwd = 2)
lines(x, y2, col = "blue", lwd = 2)


# Legendas (incompleto) ---------------------------------------------------



# Adicionando uma legenda ao gráfico produzido pelo código anterior

legend(x = -3.5, y = 0.5, legend = c(expression(N(mu == 0,sigma^2 == 1)),
                                     expression(N(mu == 0,sigma^2 == 1))),
       bg = "#EFEFEF", title = exp)

demo(plotmath)
