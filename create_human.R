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
