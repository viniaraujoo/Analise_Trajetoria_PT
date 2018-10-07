
# Eleição em relação a camera dos deputados.
data = read.csv("https://raw.githubusercontent.com/nazareno/eleicoes-sumario-tidy/master/data/partidos_tidy_long.csv", stringsAsFactors = TRUE)
library(tidyverse)
votos_pt = data %>% filter(partido == "PT",ano %in% c(1990,1994,1998,2002,2006,2010,2014)) 
votos_pt = votos_pt %>% group_by(ano) %>% summarise(total = sum(votos))
votos_pt %>% write_csv(here::here("data/votos_pt_deputados.csv"))

# Eleição de 2014
pt_2014 = read.csv("https://raw.githubusercontent.com/nazareno/eleicoes-sumario-tidy/master/data/votos_presidente_tidy.csv")
pt_2014 = pt_2014 %>% group_by(ano,partido,turno) %>% summarise(total = sum(porcentagem_brasil))
pt_2014 = pt_2014 %>% filter(turno == "Turno 2")
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
