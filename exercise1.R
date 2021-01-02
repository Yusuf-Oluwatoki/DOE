

library(readr)
exercise1 <- read_csv("C:/Users/user/Desktop/DOE/exercise1.csv")
exercise1$Eth<-factor(exercise1$Eth)
exercise1$Ratio<-factor(exercise1$Ratio)
levels(exercise1$Eth)
levels(exercise1$Ratio)
library(dplyr)
group_by(exercise1, Eth) %>%
  summarise(
    count = n(),
    mean = mean(CO, na.rm = TRUE),
    sd = sd(CO, na.rm = TRUE)
  )
group_by(exercise1, Ratio) %>%
  summarise(
    count = n(),
    mean = mean(CO, na.rm = TRUE),
    sd = sd(CO, na.rm = TRUE)
  )

# Compute the analysis of variance
res.aov <- aov(CO ~ Eth+Ratio, data = exercise1)
# Summary of the analysis
summary(res.aov)


