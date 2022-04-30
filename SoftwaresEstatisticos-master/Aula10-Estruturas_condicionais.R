# Introdução a softwares estatísticos
# Data: 17/07/2019
# Aula: 10
# Assunto: Estruturas condicionais


# OBS: Operadores infixos ------------------------------------------

# Em R existem os chamados "operadores infixos", cujos argumentos
# não precisam estar contidos por ().

2 + 3

# Observe que todo operador infixo também pode ser chamado de
# forma convencional
'+'(2,3)

# Exemplo: o operador %in% verifica se os elementos de um vetor também
# ocorrem em outro. 
c(1,2,7) %in% c(1,2,3,4,5)
c("Pedro", "Rafael") %in% c("Rafael", "João", "José")


# Interação com o usuário --------------------------------------


# Assim como C, R também possui funções para interagir com o usuário,
# como o print(), que exibe valores em tela.


for(i in 1:10) 1:10
# Todas as atribuições de valores a i serão feitas na memória, mas
# nada será exibido

for(i in 1:10) print(i)
# Agora cada atribuição será exibida.

# Exemplo:
for(x in c(1,2,3)) print("String de caracteres")


# OBS: não confundir exibição na tela e retorno. Retorno é tudo que pode
# ser utilizado (armazenado em uma variável, passado como argumento
# de função, etc.)


# A função print() exibe apenas uma string ou o valor de um objeto.
# Já cat() é uma função mais versátil, pois é possível intercalar objetos
# e strings, assim como exibir o valor de múltiplos objetos.

nota <- 7
cat("Joãozinho: Professor,\nqual a foi a minha nota?
    Professor: Sua nota foi", nota, "\nJoãozinho:\t...", sep = " ")

# Para mais informação, leia as documentações das funçoes print() e cat():
?print
?cat


# R também possui permite a inserção de valores pelo usuário
# pela função scan():

x <- scan(n = 3)

y <- scan(what = character())

cat(y)


# Estruturas condicionais ------------------------------------------------

# O R possui estrutura condicional, o if(). Funciona semelhantemente
# como em C.
x <- 7
z <- x

if(x > 0){
  cat('x é positivo.')
  y <- x/z
} else{
  cat('x não é positivo')
  y <- z
}
y

# OBS: A boa identação (recuo) de um código deixa-o mais legível por
# ressaltar a sua estrutura. Por exemplo, no código acima a identação
# deixa vísivel quais linhas de comando pertencem ao bloco if e quais
# pertencem ao bloco else.

# O atalho Ctrl + Shift + A serve para identar automaticamente um
# bloco de código selecionado.


# Também é possível aninhar estruturas if():

idade <- 30
if(idade < 18){
  grupo <- 1
} else if(idade < 35{
  grupo <- 2
} else if(idade < 65){
  grupo <- 3
} else{
  grupo <- 4
}
    
grupo

# OBS: chamamos de bloco de instrução o código contido em um {}.
# Apesar do código acima ter apenas uma linha por bloco, um bloco
# pode conter várias linhas de código e, assim como em C, podemos
# omitir o {} o bloco é apenas uma linha. R também permite
# que todo o comando if() else esteja contido em uma única linha

nota <- 7
if(nota > 7) cat("Aluno> =(") else cat("Aluno: =)")


# A função ifelse() é um comando if() else resumido.
# Ela recebe três argumentos: a condição, a expressão a ser
# retornada caso a condição seja atendida, e o retorno caso
# a condição não seja atendida.

set.seed(2) # Fixamos a semente usada na geração de números aleatórios
          
x <- rnorm(n = 5, mean = 0, sd = 1)
sig <- ifelse(x < 0, "-", "+")
sig


# O comando set.seed() serve para fixar um conjunto de números pseudo
# aleatórios a serem gerados. Isso permite que os resultados de
# um teste possam ser reproduzidos com o mesmo resultado.


# Uma outra instrução instrução condicional que poderá ser utilizada
# para escolher uma de várias alternativas possíveis é a instrução switch().
# Ela consiste em uma série de argumentos que a depender de uma condição
# (primeiro argumento) que serão ou não executados.

set.seed(0)
          
expressao <- 1
          
vetor_normal <- rnorm(10)
          
switch (EXPR = expressao,
        round(mean(vetor_normal),1),
        round(median(vetor_normal))
)

# Quando o nome dos cases não é especificado, por padrão o R os
# nomeia usando o número do case. No código acima, o primeiro
# caso é a média dos números em vetor_normal arredondada para a primeira
# casa decimal e o segundo é a mediana, também arredondada.


# OBS: se o case fornecido não existe, o comando switch() não resulta
# em erros, mas retorna NULL. Deve-se ter isso em mente quando se
# atribui o retorno do switch() a uma variável.


# Exemplo: escreva um programa que calcule o imposto pago por mulheres
# e por homens, sabendo que as mulheres pagam 10% e os homens pagam 5% a mais.

sexo <- "M"

salario <- 5e03

# Usando o if() else:

if(sexo == "M" || sexo == "m"){ 
  imposto <- salario*0.15
  cat("O imposto a pagar é: ", imposto)
} else { 
  imposto <- salario*0.10
  cat("O imposto a pagar é:", imposto)
}


# Usando o switch():

imposto <- switch (EXPR = sexo,
        "M" = salario*0.15,
        "F" = salario*0.1
)
cat("O imposto a pagar é:", imposto)

# Usando o ifelse()

imposto <- ifelse(sexo == "M"|| sexo == "m", salario*0.15, salario*0.1)
cat("O imposto a pagar é:", imposto)
