
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
nordeste = pt_2014 %>% filter(estado %in% c("Alagoas","Bahia","Ceará","Maranhão","Paraíba","Pernambuco","Piauí","R. G. do Norte","Sergipe"))
nordeste = nordeste %>% mutate(regiao = "nordeste")
suldeste =  full_join(pt_2014[17:20,],pt_2014[44:47,])
suldeste = suldeste %>% mutate(regiao = "suldeste")
sul = full_join(pt_2014[21:23,],pt_2014[48:50,])
sul = sul %>% mutate(regiao = "sul")
centro = full_join(pt_2014[24:27,],pt_2014[51:54,])
centro = centro %>% mutate(regiao = "centro-oeste")
norte = full_join(pt_2014[1:7,],pt_2014[28:34,])
norte = norte %>% mutate(regiao = "norte")
result = full_join(norte,nordeste)
result = full_join(result,sul)
result = full_join(result,suldeste)
result = full_join(result,centro)
valores =  result %>% group_by(regiao,partido) %>% summarise(porcentage = sum(porcentagem_brasil))
result %>% write_csv(here::here("data/eleicao_2014_porcentagem.csv"))


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


candidatos = read.csv("data/eleicoes-brasil-2a0ba60d37934549b033293c6e6fcdd0.csv")
eleitos = candidatos %>% filter(desc_sit_tot_turno %in% c("ELEITO POR MÉDIA","ELEITO POR QP","ELEITO"))
nordeste = eleitos %>% filter(sigla_uf %in% c("AL","BA","CE","MA","PB","PE","PI","RN","SE"))
suldeste = eleitos %>% filter(sigla_uf %in% c("SP","MG","RJ","ES"))
sul = eleitos %>% filter(sigla_uf %in% c("RS","SC","PR"))
centro = eleitos %>% filter(sigla_uf %in% c("MT","MS","GO"))
norte = eleitos %>% filter(sigla_uf %in% c("AM","AC","RO","PA","AP","RR","TO"))
df = df %>% mutate(regiao = "distrito-federal")


nordeste = nordeste %>% mutate(regiao = "nordeste")
suldeste = suldeste %>% mutate(regiao = "suldeste")
sul = sul %>% mutate(regiao = "sul")
centro = centro %>% mutate(regiao = "centro-oeste")
norte = norte %>% mutate(regiao = "norte")
df = eleitos %>% filter(sigla_uf == "DF")

result = full_join(norte,nordeste)
result = full_join(result,sul)
result = full_join(result,suldeste)
result = full_join(result,centro)
result = full_join(result,df)
result = result %>% group_by(regiao,sigla_partido) %>% summarise(total = n())
result %>% write_csv(here::here("data/eleitos.csv"))
