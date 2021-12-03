hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
str(gii)
# The first dataset HD gives the human development index (HDI) of 195 countries with also the life expectancy at birth, mean years of education,
# GDP and so forth
# The second one gives gender inequality index as well as birth rates, education numbers and so on

hd = as_tibble(hd)
hd = hd %>% 
  rename(
    HDI = Human.Development.Index..HDI.,
    HDIr = HDI.Rank,
    LEB = Life.Expectancy.at.Birth ,
    EYoE = Expected.Years.of.Education ,
    MYoE = Mean.Years.of.Education ,
    GNI = Gross.National.Income..GNI..per.Capita ,
    GNImHDI = GNI.per.Capita.Rank.Minus.HDI.Rank
  )

colnames(hd)

summary(gii)
gii = as_tibble(gii)
gii = gii %>% 
  rename(
    GIIRank = GII.Rank,
    GII = Gender.Inequality.Index..GII.,
    MMR = Maternal.Mortality.Ratio ,
    ABR = Adolescent.Birth.Rate ,
    parl = Percent.Representation.in.Parliament ,
    eduf = Population.with.Secondary.Education..Female.,
    edum = Population.with.Secondary.Education..Male.,
    labourf = Labour.Force.Participation.Rate..Female.,
    labourm = Labour.Force.Participation.Rate..Male.
  )

colnames(gii)

gii$edu_ratio = gii$eduf / gii$edum
gii$lab_ratio = gii$labourf / gii$labourm
gii$edu_ratio

human = merge(x = hd, y = gii, by = "Country")
dim(human)
write.csv(human, 'data/human.csv', row.names = FALSE)
print(str(read.csv('data/human.csv')))



# load to make sure names are good
human = read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep=',')
str(human)
dim(human)
# The data has 19 variables and 195 rows, with each row corresponding to a country. The dataset has different metrics
# for human educational and economic development as well as social and medical issues.
# We appended some new variables into the UN data which are the ratio of education between men and women
# and ratio of labour between men and women

library(stringr)
human$GNI = str_replace(human$GNI, pattern=",", replace ="")
human$GNI = as.numeric(human$GNI)
human$GNI

library(dplyr)
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))
dim(human)
class(human)
complete.cases(human)
# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- dplyr::filter(human, complete.cases(human))
dim(human_)
human = human_

# define the last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]
dim(human)
human$Country

rownames(human) <- human$Country
human$Country = NULL
dim(human)
human['Niger',]

write.csv(human, 'data/human.csv', row.names = FALSE)
print(str(read.csv('data/human.csv')))