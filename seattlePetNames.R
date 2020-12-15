#Seattle Pet Names
#12/15/2020

#At the beginning of the project, usually you load the libraries you are planning to use

#install.packages("Package Name")
#library(Package Name)

#Where does our analysis Live?
#need to check working directory
getwd()
# Set working directory to your desired directory
#Example of how to change directory: setwd("C:/Users/pbutrina/Documents/")

#download Pets name data
# uploading locally stored data as .csv file
seattle_pet_data  <-  read.csv(file = "data/Seattle_Pet_Licenses.csv")

#let's look at the data - create a summary
summary(seattle_pet_data)

str(seattle_pet_data)

dim(seattle_pet_data)

head(seattle_pet_data)

names(seattle_pet_data)

#Let's find out how many species we have in our data by
#summarizing categories within Species column

table(seattle_pet_data$Species)

#Today we will try to answer the following questions:
# 1. What is the frequency of pet registrations per year?
# 2. What is the most popular dog and cat name?
# 3. What zip codes have the biggest number of pets per capita?

# 1. What is the frequency of pet registrations per year? ----------------------

#change a data format to be able to work with it
seattle_pet_data$License.Issue.Date  <-  as.Date((seattle_pet_data$License.Issue.Date),format= '%B %d %Y')

#Frequency of per registration per year - were there more per registration in 2020 comparing with other years? Can do a freq graph
seattle_pet_data$year  <-  format(seattle_pet_data$License.Issue.Date, "%Y")
year_freq  <-  table(seattle_pet_data$year)
year_freq <- year_freq[-1]

barplot(year_freq, main = "Number of Pet registrations in Seattle by year", xlab = "Year", ylab = "Number of Registrations",
        ylim = c(0,25000))


table(seattle_pet_data$year,seattle_pet_data$Species)
write.csv(table(seattle_pet_data$year,seattle_pet_data$Species))

# 2. What is the most popular dog and cat name? ----------------------

#Pet Names
#Subset data table
# you can find your pet here!
seattle_pet_data[which(seattle_pet_data$Animal.s.Name == "Brynza"),] 

#multiple categories
seattle_pet_data[which(seattle_pet_data$Animal.s.Name == "Jack"& seattle_pet_data$ZIP.Code == "98109"),] 

subset(seattle_pet_data, Animal.s.Name == "Jasper" & grepl("Golden", Primary.Breed))

#the most popular dog name, cat name, species?

#let's separate Dogs and Cats
seattle_dogs  <-  seattle_pet_data[which(seattle_pet_data$Species == "Dog"),] 
dim(seattle_dogs)

seattle_cats  <-  seattle_pet_data[which(seattle_pet_data$Species == "Cat"),]
dim(seattle_cats)

#dog names
sort(table(seattle_dogs$Animal.s.Name),decreasing=TRUE)[1:10]

#cat names
sort(table(seattle_cats$Animal.s.Name),decreasing=TRUE)[1:10]

#3. What zip codes have the biggest number of pets per capita? -----------------

#zip code with the most number of pets per capita - need to join population in each zipcode with pet names table
#link to the original data https://www.ofm.wa.gov/washington-data-research/population-demographics/population-estimates/small-area-estimates-program
population  <-  read.csv(file = "data/OFM_Population_data.csv")
str(population)

#need to transform population to integer data type and remove "," from the population numbers
population$Estimated.Total.Population.2020 <- as.integer(gsub(",","",population$Estimated.Total.Population.2020))

#group by pet licenses by the zip code
licenses_by_zipcode <- as.data.frame(table(seattle_pet_data$ZIP.Code))

#rename zipcode column
colnames(licenses_by_zipcode)[1] <- "zipcode"
colnames(licenses_by_zipcode)[2] <- "number_of_pets"

#rename columns in population table
names(population)[names(population) == "ZIP.Code.Tabulation.Area..5.Digit."] <- "zipcode"
names(population)[names(population) == "Estimated.Total.Population.2020"] <- "population"

#checking data types
str(population)
str(licenses_by_zipcode)

#transforming factor (zipcode column) in license table to character
licenses_by_zipcode$zipcode <- as.character(licenses_by_zipcode$zipcode)
population$zipcode <- as.character(population$zipcode)

#checking the zipcode data

#merge population and pet licenses
pets_and_population <- merge(licenses_by_zipcode, population, by = "zipcode")

str(pets_and_population)

pets_and_population$pets_per_capita <- as.double(pets_and_population$number_of_pets/pets_and_population$population) 
options(scipen=999)

#share of pets of total population in the zip code
pets_and_population$pets_share <- as.double(pets_and_population$number_of_pets/pets_and_population$population)*100 


#Working with strings
#Checking pandemic-related names

unique(subset(seattle_pet_data, startsWith(seattle_pet_data$Animal.s.Name, "Cov"))$Animal.s.Name)

unique(subset(seattle_pet_data, endsWith(seattle_pet_data$Animal.s.Name, "rona"))$Animal.s.Name)

#the longest name
max(nchar(seattle_pet_data$Animal.s.Name))
subset(seattle_pet_data, nchar(seattle_pet_data$Animal.s.Name)==55)$Animal.s.Name

#let's look at the top-10 longest pat names in our dataset
longest_name_length <- sort(nchar(seattle_pet_data$Animal.s.Name),decreasing=TRUE)[1:10]

subset(seattle_pet_data, nchar(seattle_pet_data$Animal.s.Name) %in% longest_name_length)$Animal.s.Name


