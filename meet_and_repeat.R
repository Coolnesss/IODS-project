
bprs = read.csv('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt', sep=' ')
rats = read.csv('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt', sep = '\t')
str(rats)
str(bprs)

# Wide format means that observations made at different times are in differnet columns in the dataset. In the long format they would be in different rows.

rats$ID = as.factor(rats$ID)
rats$Group = as.factor(rats$Group)
bprs$treatment = as.factor(bprs$treatment)
bprs$subject = as.factor(bprs$subject)

library(dplyr)
library(tidyr)
BPRS = bprs

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 7)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

RATS = rats
glimpse(RATS)
# Convert to long form
RATSL <-  RATS %>% gather(key = WD, value = rats, -Group, -ID)

# Extract the week number
RATSL <-  RATSL %>% mutate(WD = as.integer(substr(WD, 3, 4)))

glimpse(RATSL)


# Now we have converted both datasets into the long format. In the long format the week and WD columns give the time of the measurement,
# and the rats and bprs columns give the value of the measurement. The other variables are some other data attached to each measurement.

write.csv(RATSL,'data/rats.csv' , row.names=FALSE)
write.csv(BPRSL,'data/brps.csv' , row.names=FALSE)

glimpse(read.csv('data/rats.csv'))