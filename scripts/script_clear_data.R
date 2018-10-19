
# Eleição em relação a camera dos deputados.
data = read.csv("https://raw.githubusercontent.com/nazareno/eleicoes-sumario-tidy/master/data/partidos_tidy_long.csv", stringsAsFactors = TRUE)
library(tidyverse)
votos_pt = data %>% filter(partido == "PT",ano %in% c(1990,1994,1998,2002,2006,2010,2014)) 
votos_pt = votos_pt %>% group_by(ano) %>% summarise(total = sum(votos))
votos_pt %>% write_csv(here::here("data/votos_pt_deputados.csv"))

# Eleição de 2014
pt_2014 = read.csv("https://raw.githubusercontent.com/nazareno/eleicoes-sumario-tidy/master/data/votos_presidente_tidy.csv")
pt_2014 = pt_2014 %>% filter(ano == 2014)
pt_2014 = pt_2014 %>% filter(turno == "Turno 2")
pt_2014 = pt_2014 %>% filter(partido == "PT")
pt_2014 = pt_2014 %>% mutate(regiao = "nordeste" ifelse(estado %in% c("Alagoas","Bahia","Ceará","Maranhão","Paraíba","Pernambuco","Piauí","Rio Grande do Norte","Sergipe"),NA))
pt_2014 = pt_2014 %>% group_by(ano,partido,turno) %>% summarise(total = sum(porcentagem_brasil))

pt_2014 = pt_2014[9:10,]
pt_2014 %>% write_csv(here::here("data/eleicao_2014_porcentagem.csv"))


#Trajetoria de lula até 2002.
porcentagem = read.csv("https://raw.githubusercontent.com/nazareno/eleicoes-sumario-tidy/master/data/votos_presidente_tidy.csv")
data_lula_1 = porcentagem %>% filter(ano %in% c(1989,2002)) 
data_lula_2 = porcentagem %>% filter(ano %in% c(1994,1998))
data_lula_1 = data_lula_1 %>% filter(turno == "Turno 2")
data_lula_1 = data_lula_1 %>% group_by(partido,ano) %>% summarise(total = sum(porcentagem_brasil))
options(digits=4)
data_lula_1 = data_lula_1[3:4,]
data_lula_2 = data_lula_2 %>% group_by(partido,ano) %>% summarise(total = sum(porcentagem_brasil))
data_lula_2 = data_lula_2[16:17,]
result = full_join(data_lula_1, data_lula_2)
result = result[2:3]
result %>% write_csv(here::here("data/votos_lula.csv"))


candidatos = read.csv("data/eleicoes-brasil-257ae4c7b59e468daf3a8d3fabfff1c7.csv")
eleitos = candidatos %>% filter(desc_sit_tot_turno %in% c("ELEITO POR MÉDIA","ELEITO POR QP","ELEITO"))
nao_eleitos = candidatos %>% filter(!(desc_sit_tot_turno %in% c("ELEITO POR MÉDIA","ELEITO POR QP","ELEITO")))
eleitos = eleitos %>% group_by(ano_eleicao) %>% summarise(eleitos = n())
nao_eleitos = nao_eleitos %>% group_by(ano_eleicao) %>% summarise(n_eleitos = n())
resultado = full_join(eleitos, nao_eleitos)
votos_pt = votos_pt[3:7,]
resultado = full_join(votos_pt,resultado)
resultado %>% write_csv(here::here("data/eleitos_n.csv"))
