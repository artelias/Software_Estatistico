# Introducao a softwares estatisticos
# Data: 10/06/2019
# Aula: 03
# Assunto: Busca e documentação de funções e pacotes R



#O comando find() determina qual pacote R dentre os pacotes instalados
find("ls")

install.packages("AdequacyModel")

#É possível usar uma função sem carregar o pacote inteiro explicitando seu pacote
# EX:    AdequacyModel::pso()
# Isso é útil quando não se quer usar memória desnecessária, ou quando funções de
# pacotes diferentes têm mesmo nome (devido ao alto número de pacotes implementados
# em total)

# O comando help() também informa o pacote que contém uma função
?sum #base
?hist #graphics


# O comando sessionInfo() exibe informações sobre a sessão, incluindo
# a versão do R usada, o sistema operacional,
# e quais pacotes são carrgados automaticamente
sessionInfo()


# A aba "Packages" do RStudio também permite carregar,
# descarregar e remover pacotes instalados


# OBS: O R usa a bibliotecta BLAS (Basic Linear Algebra Subprograms) para
# tratar com matrizes e álgebra linar em geral. Seu código não é otimizado
# do ponto de vista computacional, por isso existem alternativas (incluindo
# uma no github do prof.), mas sua instalação vai além dos conteúdos
# abordados nesta disciplina.



# Outro comando útil para encontrar funções é o apropos(), que busca
# nomes de funções que contém um termo fornecido.
apropos("ps")
# OBS: o comando busca apenas em pacotes carregados. Caso a função que se
# deseje esteja em um pacote instalado, mas não carregado, ela não aparecerá
# nos resultados


# O comando
temp <- 1:6
temp
rm(temp)
temp

# O comando example() roda um exemplo da função informada
example(rm)


# O comando abaixo retorna uma lista com todos os objetos contidos no pacote "base"
objects(grep("base",search()))
class(search())
is.vector(search())

# OBS: O R lê as funções de dentro para fora. Leve isso em consideração quando
# ler e escrever comandos.


# O que a função grep() faz?
lista <- c("Elemento 1", "Elemento 2", "Elemento 3")
grep("2", lista)
grep("E", lista)

# Ela busca um termo em um vetor e retorna a posição (ou posições) em que ele
# ocorre. Também pode ser usada para retornar os termos nessas posições:
lista[grep("2", lista)]
lista[grep("E", lista)]


# Portanto, o comando abaixo retorna o número de f
length(objects(grep("base",search())))

# Exercício: para que serve o argumento ignore.case da função grep()?
# Rode um comando modificando esse argumento
?grep
# Por padrão, o comando grep() é Case Sensitive, isto é, diferencia
# letras maiúsculas e minúsculas. Isso é controlado pelo argumento ignore.case,
# que por padrão é informado TRUE. É preciso explicitá-lo para fazê-lo FALSE:

cores <- c("Vermelho", "Azul", "Amarelo", "Verde")
grep("verde", cores)
grep("verde", cores, ignore.case = TRUE)

# É importante saber o padrão para argumentos de certas funções para que
# elas se comportem da maneira como esperamos. Outro exemplo é o sum():
x <- c(1, 2, 3, NA)
sum(x)
sum(x, na.rm)


# O que os comandos abaixo retornam? Leia com atenção antes de rodar,
# tente entender a lógia envolvida.
length(objects(grep("AdequacyModel", search(), ignore.case = TRUE)))

objects(grep("AdequacyModel", search()))

search()[(grep("gr", search()))]

# Para fixar:
#   search(): retorna QUAIS objetos correspondem à busca
#   grep(): retorna as POSIÇÕES dos objetos que correspondem à busca


# O que fazer quando não lembrar do nome exato da função?
library(AdequacyModel)
??PSo
# O comando retorna pacotes (nome de funções, documentação, etc.) que contém
# o termo buscado. Agora tente:

??Mean       #"Mean" significa "média" em inglês

# Quantos resultados foram encontrados agora?


# O site StackOverflow é um fórum sobre programação onde perguntas sobre
# inúmeras linguagens de programação podem ser feitas e respondidas
# Muitas vezes uma dúvida sua pode já ter sido questionada (e respondida)
# nos fóruns.


# Listas ------------------------------------------------------------------

# Para construir uma lista em R, usa-se list() em vez de c().
x <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.3, 5.9))
str(x) #Estrutura de x
# Listas são uma estrutura versátil, pois podem conter outras tipos e estruturas

# Sequências
# Por padrão, o operador ":" gera seqências de iterados em 1
seq1 <- 1:10
str(seq1)
# Também funciona para números reais
seq2<- 1.7:7.7
str(seq2)
seq3 <- 1.7:6.1
str(seq3)

# Caso queira-se usar uma iteração diferente de um, usa-se o comando seq()

# Explicitando o intervalo (argumento by)
seq(from = 0, to = 5, by = 0.5)
# Explocitando o número de termos (argumento length.out)
seq(from = 3, to = 8, length.out = 9)

# OBS: Diferentemente de C, em R é possível mudar a ordem dos argumentos
# de um comando. Porém, se a ordem usada não for a definida como padrão,
# é preciso explicitar o nome do argumento.

mean(TRUE, c(1, 2, NA, 4, 5, NA)) # Não roda!
mean(na.rm = TRUE, x = c(1, 2, NA, 4, 5, NA)) # Roda normalmente retornando 3