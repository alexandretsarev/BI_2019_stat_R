library("DAAG")
library("dplyr")
data(grog)
head(grog)
# вариант - 5 

# NA в данных нет проверено визуально глядя на датафрейм

# построим график распределения вина чтоб понять нормальное оно или нет
library("car")
qqPlot(subset(grog,grog$Country=="Australia",grog$Wine))
qqPlot(subset(grog,grog$Country=="NewZealand",grog$Wine))
# распределение в выборках не то чтобы нормальгое

grog %>% group_by(Country) %>% summarise(mean = mean(Wine))
wilcox.test(Wine~Country, data=grog) 
# различается потребление вина в двух странах, p-val 0.05
# больше пьют в австралии


# Задание 2
View(grog)
grog$data <- grog$Beer/grog$Spirit # отношение пива к душам 
Australia <- subset(grog,grog$Country=="Australia")
NewZealand <- subset(grog,grog$Country=="NewZealand")

Australia <- subset(Australia,Australia$data == max(Australia$data))
NewZealand <- subset(NewZealand,NewZealand$data == max(NewZealand$data))
result <- rbind(Australia,NewZealand)
result
