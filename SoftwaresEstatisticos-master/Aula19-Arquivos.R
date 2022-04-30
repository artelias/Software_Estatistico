# Introdução a softwares estatísticos
# Data: 02/09/2019
# Aula: 19
# Assunto: Salvando arquivos em R


# Salvando e alterando arquivos .csv pelo R ----------------------------------


# Arquivos de extensão .csv são arquivos de texto simples onde informações
# são armazenadas em linhas e colunas, sendo as colunas separadas por um 
# caractere pré-determinado, em geral ',' ou ';' (qualquer caractere pode
# servir de separador, desde que especificado previamente). Daí que vem o
# nome CSV: "Comma Separated Values", inglês para "valores separados por vírgula".


# Exemplo: Nesse exemplo criaremos um arquivo de texto com extensão csv.
# Note que não precisamos abrir um editor de texto para salvar as informações,


# Nossos dados são:

ID <- 1:10

nomes <- c("Pedro","Rafael", "Maria", "Walter", "Marina",
           "José", "Renata", "Sabrina", "Luiz", "Paulo")

curso <- c("Estatística", "Matemática", "Letras", "Estatistica", "Matemática", 
           "História", "Letras", "Química", "Química", "Geografia")

cre <- c(8.3, 7.7, 9.1, 7.8, 7.1, 9.4, 8.9, 8.8, 9.7, 7.3)


# Criando um data frame:

informacoes <- data.frame(ID, nomes, curso, cre)
informacoes

# OBS: podemos filtrar dados de um data frame tanto por filtros como
# pelo use da função subset

informacoes[informacoes$curso == "Química",]
subset(informacoes, curso == "Química")


subset(informacoes, (curso == "Química" | curso == "Estatística") & (cre > 8.0 & cre < 9.0) )


# Criando um nome para um  arquivo temporário (gerado pelo próprio R).

dados <- tempfile() # Gera um diretório temporário onde podemos salvar o 

# Endereço do arquivo
dados

# Você consegue encontrar esta arquivo no seu computador? (talvez seja necessário
# habilitar a visibilidade de arquivos ocultos)


# Para salvar o arquivo temporário como CSV:

write.table(x = informacoes, file = paste(dados, ".csv", sep = ""),
            append = FALSE, sep = ",", dec = ".", row.names = FALSE)

# Os argumentos do comando write.table() são:
# x: informações a serem salvas
# file: nome e endereço do arquivo a ser salvo. Se apenas o nome for informado,
#       ele é salvo no diretório atual.
# append: se o arquivo está sendo escrito a partir do zero ou está sendo editado
# sep: caractere a ser usado como separador de colunas
# dec: caractere a ser usado como seprarador de casas decimais
# row.names: se os valores da primeira coluna correspondem ao nome de cada linha
#            ou observações da primeira variável
# col.names: se aos valores d primeira linha correspondem ao nome de cada coluna
#            ou à primeira observação de cada variável


# Caso não queiramos usar o arquivo temporário, podemos salvar o arquivo em um
# diretório específico (o endereço no exemplo abaixo corresponde a uma pasta
# no meu computador, use um apropriado para você):


# Fixar o diretório em uso pelo comando setwd() ou pelo atalho Ctrl + Shift + H:
setwd("C:/Users/Carvalho/Documents/UFPB/P3/Softwares")

# Salvar o arquivo com os dados do data frame com o nome que queremos:
write.table(x = informacoes, file = "Arquivo.csv", append = FALSE,
            sep = ",", dec = ".", row.names = FALSE, col.names = TRUE)


# Visualizando o arquivo de texto:

file.show(paste(dados, ".csv", sep = ""))

file.show("Arquivo.csv")

# O argumento append do write.table informe se o arquivo está sendo escrito
# ou reescrito a partir do zero ou se um arquivo já existe e está sendo alterado.
# Vamos adicionar mais duas linhas ao nosso arquivo.

informacoes1 <- data.frame(c(11,12), c("Renato", "João"), c("Filosofia", "Atuária"), c(4.3, 10.0))

write.table(x = informacoes1, file = "Arquivo.csv",
            append = TRUE, sep = ",", dec = ".", row.names = FALSE, col.names = FALSE)


# Do mesmo jeito que podemos escrever tabelas em arquivos .csv, também podemos ler
# e armazenar elas em variáveis

df <- read.table(file = "Arquivo.csv", header = TRUE, sep = ",", dec = ".")
View(df)

# Argumentos:
# file: arquivo a se ler
# header: se o arquico tem cabeçalho (se a primeira linha corresponde ao nome
# das variáveis ou se são valores de variáveis)
# sep: caractere usado como separador de colunas no arquivo
# dec: caractere usado como separador de casas decimais no arquivo


subset(df, (cre >= 7.7 & cre <= 7.8) & (curso == "Matemática" | curso == "Estatística"))


# Lendo arquivos pela internet --------------------------------------------------


# O pacote RCurl permite a leitura de arquivos por um endereço da Internet:
install.packages("RCurl")
library(RCurl)


# Dividindo a URL para a mehlor legibilidade do código:

url1 <- 'https://chronicdata.cdc.gov/api/views'
url2 <- '/g4ie-h725/rows.csv?access=DOWNLOAD'
url <- paste(url1, url2, sep = "")

dados_cdc <- getURL(url)



link1 <- "https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey"
link2 <- "/Annual-enterprise-survey-2018-financial-year-provisional/Download-data/annual"
link3 <- "-enterprise-survey-2018-financial-year-provisional-csv.csv"
url <- paste(link1,link2,link3, sep = "")

dados <- getURL(url)

# tabela <- read.csv(textConnection(dados_cdc), header = TRUE)

# Aviso: o comando getURL() não funcionou no meu caso. Segue o código 
# com os dados obtidos convecionalmente:

dados <- read.csv(file = "U.S._Chronic_Disease_Indicators__CDI_.CSV", header = TRUE)


# O pacote tibble permite o uso de uma estrutura de dados de mesmo nome, que é
# semelhante ao data frame, aceitando muitas das operações usadas com data frames,
# mas que busca fornecer uma representação mais organizada visualmente.

install.packages("tibble")
library(tibble)

tabela_tibble <- as_tibble(dados)

rm(dados)
gc()

tabela_tibble[1:10,1:6]

View(tabela_tibble)

write.table(x = tabela_tibble, file = "tabela_tibble.csv", sep = ";")

file.show("tabela_tibble.csv")
