data = read.csv("https://raw.githubusercontent.com/nazareno/eleicoes-sumario-tidy/master/data/partidos_tidy_long.csv", stringsAsFactors = TRUE)
library(tidyverse)
votos_pt = data %>% filter(partido == "PT",ano %in% c(1990,1994,1998,2002,2006,2010,2014)) 
votos_pt = votos_pt %>% group_by(ano) %>% summarise(total = sum(votos))
votos_pt %>% write_csv(here::here("data/votos_pt_deputados.csv"))


data_presidentes = read.csv("https://raw.githubusercontent.com/nazareno/eleicoes-sumario-tidy/master/data/votos_tidy_long.csv",encoding="UTF-8")
data_presidentes = data_presidentes %>% filter(ano %in% c(1989,1994,1998,2002))
data_presidentes_2 = data_presidentes %>% filter(turno == "Turno 2")
data_presidentes = data_presidentes %>% filter(ano %in% c(1994,1998))
data_lula_1 = data_presidentes_2 %>% group_by(candidato,ano) %>% summarise(total = sum(votos))


data_lula_1 = data_lula_1 %>% filter(!(candidato %in% c("Fernando Collor de Mello PRR (PST-PSL)","José Serra (PSDB)")))
data_lula_1 = data_lula_1[2:3,]

data_lula_2 = data_presidentes %>% group_by(candidato,ano) %>% summarise(total = sum(votos))
data_lula_2 = data_lula_2[15:16,]
teste = join(data_lula_1,data_lula_2)
data_lula_1 = data_lula_1[2:3]
data_lula_2 = data_lula_2[2:3]
result = full_join(data_lula_1, data_lula_2)
result %>% write_csv(here::here("data/votos_lula.csv"))

pt_2014 = read.csv("https://raw.githubusercontent.com/nazareno/eleicoes-sumario-tidy/master/data/votos_tidy_long.csv",encoding="UTF-8")
pt_2014 = pt_2014 %>% group_by(ano,candidato,turno) %>% summarise(total = sum(votos))
pt_2014 = pt_2014 %>% filter(turno == "Turno 2")
pt_2014 = pt_2014[9:10,]
pt_2014 %>% write_csv(here::here("data/eleicao_2014.csv"))