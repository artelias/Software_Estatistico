# Introdução a softwares estatísticos
# Data: 22/07/2019
# Aula: 11
# Assunto: Estruturas de repetição (loops)

# Estrutura condicionais (continuação) ------------------

# Outra forma de implementar o exercício da aula passada: 

meu_salario <- function(){
  salario <- as.numeric(readline(prompt = "Entre com um salário: "))
  sexo <- tolower(readline(prompt = "Informe o sexo (m ou f): "))
  switch(sexo,
         "m" = {
           imposto = 0.15;
           cat("O salário a ser pago é ", salario - salario*imposto)
              },
         "f" = {
           imposto = 0.1;
            cat("O salário a ser pago é ", salario - salario*imposto)
              }
         )
}
meusalario


# Exercício: descreva o que as funções tolower(), toupper() e readline().
# Apresente exemplos do uso delas.

# Estruturas de repetição (loops) --------------------------------------


# Comando while():

i <- 1
while(i < 7){
  cat("i", i, "=", i, "\n",sep = " ")
  i <- i + 1
}

# Exercício: Escreva um programa que exiba a tabuada de 7 

i <- 1
while(i <= 10){
  cat("7 x ", i, " = ", 7*i, "\n")
  i <- i + 1
}


# OBS: Cuidado com loops infinitos! Uma instrução de repetição precisa de
# uma condição de término que expressa até quando ela deverá ser executada. 

# Exemplo: O código abaixo exibe o conteúdo de u enquanto
# a expressão u < 0.5 for verdadeira. Isso gera um loop infinito? Por quê?

u <- runif(n = 1, min = 0, max = 1)
while(u < 0.5){
  cat("u=", u, "\n", sep = "")
  u <- runif(n = 1, min = 0, max = 1)
}


# Comando repeat(): Repete uma instrução indefinidamente até
# uma condição interna force sua interrupção

# Exemplo:

texto <- c()
repeat{
  fr <- readline(prompt = "Introduza uma frase (vazio termina): ")
  if(fr == '')
    break
  else
    texto <- c(texto,fr)
}

# O código acima recebe cadeias de caracteres (strings) e as armazena
# em um vetor de caracteres até que uma string vazia seja informada,
# o que encerra o loop.


# A instrução break serve para finalizar estruturas de repetição.
# No exemplo anterior, quando a condição do if() for verdadeira
# a instrução break será executada e o repeat() será terminado.

# A instrução break pode ser usada em loops while() e repeat()
# assim como em for(), como veremos mais a frente.


# Outra instrução útil em estruturas de repetição é o next.
# Quando ela é executada, todas as instruções que seguem
# são ignoradas e o loop passa para a próxima iteração.

# Exemplo:

# Geramos um vetor vazio:
vetor <- c()

# Recebemos números inteiros e os armazenamos os estritamente positivos
# em um vetor até zero ser informado, ignorando valores negativos.

repeat{
  nro <- as.numeric(readline(prompt = "Introduza um número positivo (zero termina): "))
  if(nro < 0) 
    next
  else if(nro == 0)
    break
  else
    vetor <- c(vetor,nro)
}


# Comando for(): Semelhante ao comando for() em C, é uma 
# estrutura de repetição com uma variável de controle,

# Exercício: Usando a instrução de repetição for(), construa
# um programa que com um vetor de valores entre 0 e 1 some apenas
# os maiores que 0.7

set.seed(0)

vetor <- runif(n = 10, min = 0, max = 1)

soma <- 0

for(i in vetor){
  if(i > 0.7)
    soma <- soma + i
}

# OBS: veja que i não precisa ser um inteiro em uma sequência 1,2,3,...,n.
# Podemos iterar usando os elementos de um vetor.


# Sem o loop:

sum(vetor[vetor > 0.7])


# Exercício: consulte a documentação da função Sys.time(). Use-a
# para obter o tempo de execução das funções implementedas
# nos exercícios anteriores, mas para um vetor de 10.000.000 números
# pseudoaleatórios.

set.seed(0) # Fixamos a semente dos números pseudoaleatórios para que
            # os resultados sejam reproduzíveis.

vetor <- runif(n = 1e7, min = 0, max = 1)

soma <- 0


tempo_0 <- Sys.time()
for(i in vetor){
  if(i > 0.7)
    soma <- soma + i
}
Sys.time() - tempo_0


tempo_0 <- Sys.time()
sum(vetor[vetor > 0.7])
Sys.time() - tempo_0


# Benchmarking --------------------------------------------------------


# Benchmarking é o processo de executar um programa ou conjunto
# de operações a fim de avaliar o desempenho relativo de uma função
# ou objeto. O desempenho é testado por meio de um conjunto de testes
# padrões e ensaios sobre a função ou objeto.


# Isso é útil pois na estatística estamos interessados em simulações
# de dados e repetições de processos, onde é interessante saber o
# o tempo de execução ou custo computacional de trechos de código
# a fim de se detectar "gargalos" e otimizar nossas funções.


# Uma das formas eficientes de se fazer benchmarks na linguagem R
# pe usando a função microbenchmark() do pacote de mesmo nome.

install.packages("microbenchmark")

library(microbenchmark)


# Vamos usar este comando para investigar o tempo gasto no nosso código
# anterior, com e sem loops, para um vetor de 1000 números.

set.seed(0)

vetor <- runif(n = 1000, min = 0, max = 1)

soma <- 0

microbenchmark(
  
  for(i in vetor){
  if(i > 0.7)
    soma <- soma + i
  }

)

microbenchmark(sum(vetor[vetor > 0.7]))


# O microbenchmark é útil para investigar a eficiência de maneiras
# de implementar trechos curtos de códigos. Por padrão, o comando
# repete o trecho fornecido 100 vezes.
# Esse comando não deve ser usado para investigar o custo 
# computacional de blocos extensos de código.


# Conclusão: loops são estruturas computacionalmete intensivas em R.
# Eles devem ser usados apenas quando necessário, pois às vezes há
# soluções mais eficientes para se resolver uma tarefa.


# Exercício: Reescreva o trecho abaixo usando a instrução while()

for(i in 1:20){
  if(i == 10)
    next
  else
    cat("i = ", i, "\n", sep = "")
}

# Precisamos instanciar o i como 1

i <- 1

while(i <= 20){
  if(i == 10){
    i <- i + 1
    next
  }
  else{
    cat("i = ", i, "\n", sep = "")
    i <- i + 1
  }
}


# Lembra desse exercício em C?
# n = 1         n = 2        n = 3      ...
#  *             *             *
#                **            **
#                              ***

# Tente reproduzi-lo em R usando loops (while, repeat, for).

n <- as.integer(readline(prompt = "Informe um número natural: "))

for(linha in 1:n){
  for(coluna in 1:linha){
    cat("*")
  }
  cat("\n")
}

# Alternativamente:

for(linha in 1:n){
  cat(rep(x ="*", times = linha), "\n")
}


