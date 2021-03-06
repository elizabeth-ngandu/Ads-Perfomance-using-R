library(data.table)

#load our dataset
data <- fread('advertising.csv')

#preivew the first 6 rows
head(data)

#view the table
view(data)

#find out the structure of the dataset
str(data)

#dimensions of the dataset
dim(data)

#checking if there is any null values
colSums(is.na(data))

#checking for duplicates
duplicateddata<- data[duplicated(data),]
duplicateddata
#no duplicates found since the table is empty

#rows where there were no duplicates
data<- data[!duplicated(data),]
data
dim(data) #as seen earlier no duplicated rows

#checking for ouliers in various columns

boxplot(data$`Daily Time Spent on Site`) # no outliers
boxplot(data$Age) #no outliers
boxplot(data$`Area Income`) #outliers found
boxplot(data$`Daily Internet Usage`) # no outliers

#producing the outliers in vector formart
boxplot.stats(data$`Area Income`)$out

#place a variable to the outliers in the are income column
outliers<-boxplot.stats(data$`Area Income`)$out
outliers

#assign the colume with the outlier a vaiable
area_income<-data$`Area Income`

#eliminating the outliers in the area_income column
newdata<-area_income[!area_income %in% boxplot.stats(area_income)$out]

str(newdata)

#average time spent on the site
average_time<-mean(data$`Daily Time Spent on Site`)
average_time  # 65 units of time spent on the site

#average internet usage
average_internet<-mean(data$`Daily Internet Usage`)
average_internet # 180

#frequency of the daily time spent on the internet
hist(data$`Daily Time Spent on Site`)

#frequency of the daily internet usage
hist(data$`Daily Internet Usage`)

#range of time spent on the site
range(data$`Daily Time Spent on Site`) #32.60 91.43

#assigning variables
internet_usage<-data$`Daily Internet Usage`
time_spent<- data$`Daily Time Spent on Site`

cov(internet_usage, time_spent) #360.9919: indicates a positive linear relationship btn the two variables

cor(internet_usage, time_spent) #0.5186585 : indicates a average linear correlation

plot(internet_usage, time_spent, xlab = "Daily internet usage", ylab = "Daily time spent on the internet")
 


# Grouped Bar Plot
counts <- table( data$Male, data$`Clicked on Ad`)

barplot(counts, main="Gender Distribution by Clicking the ad",
        xlab="Clicked on ad", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE)
counts # majority of the gender that clicked the add was female where 269 female clicked the ad
         #while 231 male never clicked the ad

counts2 <-table(data$Male, data$Age)
counts2

#load the dplyr package
library(dplyr)
head(data)

#filter the data where to have only those people who clicked on the ad
clicked<- filter(data, `Clicked on Ad` == 1)
head(clicked)

#create a table of country and how many times people from each country clicked the ad
counts3<- table(clicked$Country)
max(counts3) # Ethiopia had the highest number of people clicking the ad (7 people)

mean(clicked$`Area Income`) #avearge area income of theose that clisked the ad is 48614

avg_time <- mean(clicked$`Daily Time Spent on Site`)
avg_time  # an average of 53 units of time spent on the site for those who clicked

avg_internet<-mean(clicked$`Daily Internet Usage`)
avg_internet # an average 145 units of of internet used for those wjo clicked on the ad

#distribution for the people who clicked the ad
hist(clicked$Age)

avg_age<- mean(clicked$Age)
avg_age # majority of the people who clicked the ad were around 40 years of age

#function for mode
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

clickers_mode<- getmode(clicked$Age)
clickers_mode #majority of the people who clicked were 45 years old

boxplot(`Daily Time Spent on Site`~ Male, data = clicked, xlab= "Gender", ylab= "`Daily Time Spent on Site") #more females spent alot of time on the site

#from the analysis:
#majority of those who clicked on the ad; were female
#more females spent a lot of time on the site
#average age of 40
#specifically 45 year olds clicked the more 
#both genders had the same count of those who did not click the ad
# an average of 53 units of time spent on the site for those who clicked
# Ethiopia had the highest number of people clicking the ad (7 people)
# an average 145 units of of internet used for those wjo clicked on the ad
