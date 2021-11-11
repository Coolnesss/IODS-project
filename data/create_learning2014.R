# Chang 

data = read.csv('https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt', header = TRUE, sep = "\t")
print(dim(data))
print(str(data))
# it has 60 dimensions and 183 samples
# There are stuff like age, gender 
# Some fields are named weirdly
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

analysis = data[c('Age', 'gender', 'Attitude', 'Points')]
analysis['stra'] = rowMeans(data[strategic_questions])
analysis['deep'] = rowMeans(data[deep_questions])
analysis['surf'] = rowMeans(data[surface_questions])
analysis = analysis[analysis['Points'] != 0, ]
print(dim(analysis))
print(str(analysis))

setwd('~/IODS-project')
getwd()

write.csv(analysis, 'data/data.csv', row.names = FALSE)

analysis = read.csv('data/data.csv', header = TRUE)
print(dim(analysis))
print(str(analysis))
