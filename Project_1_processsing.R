setwd("/home/tsaralex/Documents/Bioinf/Git_Statistics/Project_1/")

library(dplyr)
library(data.table)

file_list <- unzip("Data.zip", list = TRUE)
file_list <- file_list[-1,] # первая строка содержит корневую папку, сразу от нее избавимся, нам она не нужна
file_list # ок прочитали файлы и поняли что внутри все csvшное

#прежде чем собирать все в единую таблицу, посмотрим количество столбцов и их названия
for (i in (1:nrow(file_list))){
  file_list$num_cols[i] <- length(colnames(read.table(unz("Data.zip", file_list$Name[i]), header=T, quote="\"", sep=",")))
  file_list$col_names[i] <- paste((colnames(read.table(unz("Data.zip", file_list$Name[i]), header=T, quote="\"", sep=","))),
                                  collapse = ";")
}
# собственно проверка на идентичность что количество уникальных элементов в этих столбцах одно
isTRUE(length(unique(file_list$col_names)) == length(unique(file_list$num_cols)) & length(unique(file_list$col_names)) == 1)


# удалим столбцы с количеством колонок и вектором их имена, типа они занимают память, а вдруг у нас их 15 миллионов
file_list %>% select(-c(num_cols,col_names)) -> file_list



x = fread('unzip -p Data.zip',)
#https://stackoverflow.com/questions/33341010/fread-of-file-from-archive
fre