# loading libraries 

library(data.table)
library(dplyr)
library(tidyr)
# library(car)
library(forecast)
# library(psych)
library(FactoMineR)
library(ggplot2)
# library(ggmap)
library(googleVis)

# setting working diectory
setwd("D:/Academics/Semester-III(Late Fall 2016)/CISC 520 - Data Engineering and Minng/Final Project/Data")

# loading data into R
global_climate <-  fread("GlobalTemperatures.csv",header = TRUE)
global_temp_country  <-  fread("GlobalLandTemperaturesByCountry.csv", header = TRUE)

# coverting dt column into data format
global_temp_country$dt <- as.Date(global_temp_country$dt, format = "%Y-%m-%d")
global_climate$dt <- as.Date(global_climate$dt,format = "%Y-%m-%d")

# converting into dataframes.
global_climate <- as.data.frame(global_climate)
global_temp_country <- as.data.frame(global_temp_country)

# extracting year and month from date column
global_temp_country$Year <- year(global_temp_country$dt)
global_temp_country$Month <- month(global_temp_country$dt)

global_climate$Year <- year(global_climate$dt)
global_climate$Month <- month(global_climate$dt)

# Finding structure of the data
str(global_climate)
str(global_temp_country)


# filtering data from 1900 to 2013
global_climate %>%
  filter(Year >= 1900) %>%
  filter(Year < 2013) -> global_climate_1900

global_temp_country %>%
  filter(Year >= 1900) %>%
  filter(Year < 2013) -> global_temp_country_1900

global_temp_country_1900 <- na.omit(global_temp_country_1900)

# Finding NA values 
 
sapply(unique(global_temp_country_1900), function(x)any(is.na(x)))

table(is.na(global_temp_country_1900$AverageTemperature))
table(is.na(global_climate_1900))

# computing average temperature on the world since 1900 to 2013

global_climate_1900 %>%
  group_by(Year) %>%
  summarise(AvgGlblTemp = mean(LandAverageTemperature)) -> global_climate_1900_avg

global_temp_country_1900 %>%
  group_by(Country) %>%
  summarise(AvgCountryTemp = mean(AverageTemperature)) -> global_temp_country_1900_avg

global_temp_country_1900 %>%
  group_by(Year) %>%
  summarise(AvgCountryTemp = mean(AverageTemperature)) -> global_temp_country_1900_avgTemp

global_temp_country_1900 %>%
  filter(Country == "United States") %>%
  group_by(Year) %>%
  summarise(AvgUsaTemp = mean(AverageTemperature)) -> global_temp_country_1900_USA

global_temp_country %>%
  filter(Country == "United States") %>%
  filter(Year >= 1900) -> USATemp

USATemp %>%
  group_by(Year) %>%
  summarise(AvgTemp = mean(AverageTemperature)) -> USAAvgTemp

USATempSub <- subset(USATemp, select = -c(AverageTemperatureUncertainty,Country,Month, Year))

global_temp_country_1900 %>%
  group_by(Year,Country) %>%
  summarise(AvgTemp = mean(AverageTemperature)) ->  Country_matrix


# Computing average temperature country wide

# plotting histogram and gloabal average temperatures

plot(global_climate_1900_avg$Year, global_climate_1900_avg$AvgGlblTemp, type = 'b', xlab = 'Year', ylab = 'Average Temperature', main = 'Global Teperatures from 1900', col = c('blue'))

hist(global_climate_1900_avg$AvgGlblTemp,
     breaks = 5,
     col = colors()[626],
     xlab = "Global Land Average Temperature ",
     ylab = "Cumulative Frequency",
     freq = FALSE,
     main = "Global Land Avg. Temperatures\n Histogram")
curve(dnorm(x, mean = mean(global_climate_1900_avg$AvgGlblTemp), sd = sd(global_climate_1900_avg$AvgGlblTemp)),
      col = 'red',
      lwd = 2,
      add = TRUE)

polygon(density(global_climate_1900_avg$AvgGlblTemp), col = 'red', border = 'black')


# Basic stats for global climate

summary(global_climate_1900_avg)

plot(global_climate_1900$Year, global_climate_1900$LandAverageTemperature, type = 'b', xlab = 'Year', ylab = 'Average Temperature', main = 'Global Teperatures from 1900', col = c('blue'))

hist(global_climate_1900$LandAverageTemperature,
     breaks = 50,
     col = colors()[626],
     xlab = "Global Land Average Temperature ",
     ylab = "Relative Frequency",
     # freq = FALSE,
     probability = TRUE,
     xlim = c(0,20),
     main = "Global Land Avg. Temperatures\n Histogram")
lines(density(global_climate_1900$LandAverageTemperature), col = 'red', lwd = 2)
lines(density(global_climate_1900$LandAverageTemperature, adjust = 2), lty = 'dotted', col = 'green', lwd = 2)

# Plotting box plot and bocplot matrix
boxplot.stats(global_climate_1900$LandAverageTemperature)
boxplot(global_climate_1900$LandAverageTemperature)

# sorting data according to the temperature
global_temp_country_1900_avg <-  global_temp_country_1900_avg[order(global_temp_country_1900_avg$AvgCountryTemp),]

# slicinghighest and lowest temperatures
global_temp_country_1900_avg_trimmed <- global_temp_country_1900_avg[220:243,]
global_temp_country_1900_avg_trimmedLow <- global_temp_country_1900_avg[1:20,]


# plottign highest and lowest temperatures

ggplot(data = global_temp_country_1900_avg_trimmed, mapping = aes(x = global_temp_country_1900_avg_trimmed$Country, y = global_temp_country_1900_avg_trimmed$AvgCountryTemp)) +
  geom_bar(position = "dodge", stat = "identity") +
  coord_flip() +
  ggtitle("Highest Average Temperature - country wise") +
  labs(x = "Countries", y = "Average Temperature")


ggplot(data = global_temp_country_1900_avg_trimmedLow, mapping = aes(x = global_temp_country_1900_avg_trimmedLow$Country, y = global_temp_country_1900_avg_trimmedLow$AvgCountryTemp)) +
  geom_bar(position = "dodge", stat = "identity") +
  coord_flip() +
  ggtitle("Lowest Average Temperature - country wise") +
  labs(x = "Countries", y = "Average Temperature")


plot(global_temp_country_1900_USA$Year, global_temp_country_1900_USA$AvgUsaTemp, type = 'l', col = "blue", lwd = 3, main = "USA Vs Global Temperatures", xlab = "Year", ylab = "Average Temperature")
lines(global_climate_1900_avg$Year, global_climate_1900_avg$AvgGlblTemp,  col = "red", lwd = 3)
legend(Year,legend = c("USA", "Global"))

qplot(Year, AvgUsaTemp, data = global_temp_country_1900_USA, main = "US Average Temperature 1900-2015",geom = c("point","smooth")) + aes(colour = AvgUsaTemp) + scale_color_gradient(low = "orange", high = "black")
  
#           **********************************
#           *         Correlation            *
#           **********************************

cor(global_temp_country_1900_USA$AvgUsaTemp, global_climate_1900_avg$AvgGlblTemp, method = 'pearson')
cor(global_temp_country_1900_USA$AvgUsaTemp, global_climate_1900_avg$AvgGlblTemp, method = 'spearman')
cor(global_temp_country_1900_USA$AvgUsaTemp, global_climate_1900_avg$AvgGlblTemp, method = 'kendall')

#           **********************************
#           *         Forecasting            *
#           **********************************

# converting data frame into time series object

USATempSub$AverageTemperature <- ts(USATempSub$AverageTemperature, start = c(1900,1), end = c(2013,9), frequency = 12)

summary(USATempSub)
summary(USATempSub$AverageTemperature)
describe(USATempSub$AverageTemperature)

ssfit <- stl(USATempSub, s.window = 'period')
print(ssfit)
plot(ssfit, col = '#8B4513')

monthplot(USATempSub$AverageTemperature, xlab = "Months", ylab = "Temperature (in celsius)", col = 'orange')


# estimating ARIMA model

fit_diff_ar_1 <- arima(USATempSub$AverageTemperature, order = c(15,0,0), seasonal = c(1,1,1))
fit_diff_arf_1 <- forecast(fit_diff_ar_1, h = 120)
# plot(fit_diff_arf_1, include = 120)
# plot(fit_diff_arf_1)
autoplot(fit_diff_arf_1)

# Display teh Model attributes
fit_diff_arf_1$model
fit_diff_arf_1$method
fit_diff_arf_1$level
fit_diff_arf_1$mean
fit_diff_arf_1$residuals

# 
# fit_diff_ar_2 <- ets(USATempSub$AverageTemperature)
# plot(fit_diff_ar_2)
# 
# fit_diff_arf <- forecast(fit_diff_ar_1, h = 30)
# print(fit_diff_arf)
# plot(fit_diff_arf)
# 
# plot(fit_diff_ar_1)
# 
# fit_diff_auto <- auto.arima(USATempSub$AverageTemperature)
# fit_diff_arf_auto <- forecast(fit_diff_auto, h = 30)
# print(fit_diff_arf_auto)
# # plot(fit_diff_arf_auto,include = 50)
# 
# 
# plot(fit_diff_arf)
# 
# summary(fit_diff_ar_1)
# 
# plot(fit_diff_ar_1)

# Modeling and forescasting for global temperatures  
globalTemp <- global_climate_1900

globalTempSub <- subset(globalTemp, select = -c(LandAverageTemperatureUncertainty, LandMaxTemperature, LandMaxTemperatureUncertainty, LandMinTemperature, LandMinTemperatureUncertainty, LandAndOceanAverageTemperature,LandAndOceanAverageTemperatureUncertainty,Year, Month))

globalTempSub$dt <- as.Date(globalTempSub$dt,format = "%Y-%m-%d")

globalTempSub$LandAverageTemperature <- ts(globalTempSub$LandAverageTemperature, start = c(1900,1), end = c(2015,12), frequency = 12)

plot(globalTempSub)


fit_ar_1 <- arima(globalTempSub$LandAverageTemperature, order = c(18,1,1))
fit_arf <- forecast(fit_ar_1, h = 120)
plot(fit_arf)

summary(fit_ar_1)

plot(fit_ar_1)

fit_arf <- forecast(fit_ar_1, h = 120)
print(fit_arf)

plot(fit_arf)
plot(globalTemp$LandAverageTemperature)

summary(globalTempSub)

globalTempSub

#           **********************************
#           *         Clustering            *
#           **********************************

global_temp_country_1900_avg <- global_temp_country_1900_avg[!(Country_matrix$Country %in% c("Asia", "Africa","United Kingdom (Europe)","Europe","South America","North America")),]


global_temp_country_1900_avg <- na.omit(global_temp_country_1900_avg)

# Keeping Country name as rownames
row.names(global_temp_country_1900_avg) <- global_temp_country_1900_avg[,1]



#***********************Extra Code **********************************
# acp=PCA(Country_matrix[,2:114],scale.unit=FALSE, quali.sup=1)
# plot(acp$ind$coord[,],col="white")
# text(acp$ind$coord[,1],acp$ind$coord[,2],rownames(acp$ind$coord),col=group5)
# 
# PT=aggregate(acp$ind$coord,list(group5),mean)
# points(PT$Dim.1,PT$Dim.2,pch=0)
# 
# library(tripack)
# V <- voronoi.mosaic(PT$Dim.1,PT$Dim.2)
# plot(V,add=TRUE)
# 
# p=function(x,y){which.min((PT$Dim.1-x)^2+(PT$Dim.2-y)^2)}
# vx=seq(-400,100,length=251)
# vy=seq(-10,10,length=251)
# z=outer(vx,vy,Vectorize(p))
# image(vx,vy,z,col=c(rgb(1,1,1,.6), rgb(0,1,1,.4),rgb(0,0,1,.2),rgb(1,0,1,.8),rgb(1,1,1,.2)))
# CL=c("red","black","blue","gray","orange")
# points(acp$ind$coord[,1],acp$ind$coord[,2], type="p",col=CL[group5], pch=8)



##**********************Extra Code **********************************

km <- kmeans(global_temp_country_1900_avg$AvgCountryTemp,5)
km$iter

global_temp_country_1900_avg$Cluster <- km$cluster


G4 <- gvisGeoChart(global_temp_country_1900_avg, locationvar = 'Country', colorvar = "AvgCountryTemp",options = list(dataMode = 'regions', width = 1080, height = 500, colors = "['#C1CDCD', '#e31b23']"), chartid = 'EQ')

plot(G4)

#           ****************************************************
#           *         Analysis on citites by Avnessh           *
#           ****************************************************


library(tidyr)
library(dplyr)
library(ggplot2)
library(leaflet)
library(ggmap)
library(maptools)
library(maps)
library(data.table)

setwd("~/R")

# Importing data into R
majorcity <- read.csv("GlobalLandTemperaturesByMajorCity.csv")

## Summary 
glimpse(majorcityusa)
summary(majorcity)


## How many unique Cities are in the dataset 
a <- unique(majorcity$City)
## How many unique Countries are in the dataset
b <- unique(majorcity$Country)

## Finding missing values
sum(is.na(majorcity))
## Identifying and Omitting NA's
table((is.na(majorcity1)))
majorcity1 <- na.omit(majorcity1)


## Convert Date column to Date format
typeof(majorcity$AverageTemperature)
AverageTemperature <- as.numeric(majorcity$AverageTemperature)
majorcity1 <- separate(data = majorcity, col = dt, into = c("Year", "Month", "Date"), convert = TRUE)
glimpse(majorcity1) #check data structure


## Group by Year
majorcity1 %>% 
  filter(Year>1850) %>%
  group_by(Year) %>% 
  summarise(Temp = mean(AverageTemperature)) ->majorcity2

## Plotting Average Temperature
Temp <- as.numeric(majorcity2$Temp)
sum(is.na(majorcity2)) #check to see if there are any missing values left
plot1 <- qplot(majorcity2$Year, Temp, colour = Temp, geom = c("point","smooth"), colour= Temp) + 
  scale_color_gradient(low = "blue", high = "red") + 
  labs(list(title = "Average Temperature By Year", x = "Year", y= "Average Temperature")) +
  theme(plot.title = element_text(hjust = 0.5))

## Plotting Temperature Uncertainity 
ggplot(data = majorcity1, aes(Year, AverageTemperatureUncertainty, colour = City)) + 
  geom_point() + facet_wrap(~Country, scales = "free_y") +
  ggtitle("Average Temperature Uncertainity By Year and City") +theme(plot.title = element_text(hjust = 0.5))


## Sort dataset by count of temperature recordings 
majorcity %>%
  count(City, sort = TRUE)

## Dataset Grouped by City
majorcity1 %>% 
  filter(Year>1850) %>%
  group_by(City, Country, Year, Longitude, Latitude) %>% 
  summarise(Temp = mean(AverageTemperature)) ->majorcity3
glimpse(majorcity3) #verify structure of data
sum(is.na(majorcity3)) #check for missing values


## Plotting Average Temperature by City by Country
ggplot(data = majorcity3, aes(Year, Temp)) + 
  geom_line(aes(colour = City)) + facet_wrap(~ Country) +
  ggtitle("Average Temperature By Year and City") + theme(plot.title = element_text(hjust = 0.5))


## Get latitude and longitude in R readable format
library(ggmap)
tomap <- majorcity3[ ,c(1:2,4:5)]
tomap <- unique.data.frame(tomap)  
tomap$cc <- paste(tomap$City,tomap$Country)

## Get Lat and lon information from internet
longlat <- geocode(as.character(tomap$cc)) %>% 
  mutate(loc=unique(tomap$City))


## Mapping to a World Map
majorcity3 %>% filter(Year>1850) %>% 
  group_by(City, Country, Year, Temp) %>% 
  inner_join(longlat,by=c("City"="loc")) %>% 
  mutate(LatLon=paste(lat,lon,sep=":")) -> formap


## Mapping Avg temp for Cities on World Map
formap10 <-(formap[,c(1:3,6:8)])
formap10 <- na.omit(formap10)
#formap1$T1 <- length(Temp)

## Creating the map
mp <- NULL
mapWorld <- borders("world", colour="gray50", fill="gray50") # create a layer of borders
mp <- ggplot() +   mapWorld

## Layering the cities on top
worldmap <- mp+ geom_point(data = formap10, aes(x = formap10$lon, y=formap10$lat, colour = Temp),  size = 5)+ 
  scale_colour_gradient(low = "blue", high = "red") + 
  ggtitle("Average Temperature for 100 Major Cities in the world") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(data=formap10, aes(lon, lat, label = City), size=3)



## Filtering dataset for USA
formap %>% 
  filter(Country == "United States") %>%
  group_by(City, Country, Year, lon, lat, Temp)->majorcityusa

### Plotting map of Average Temp of USA Cities
mapusa <- borders("state", colour="gray50", fill="gray50") # create a layer of borders
map1 <- ggplot() +   mapusa
#### Now Layer the cities on top
map1 <- mp1+ geom_point(data = majorcityusa, aes(x = lon, y=lat, colour = Temp))+ 
  geom_jitter(width = 0.1, height = 0.1) + geom_text(data=majorcityusa, aes(lon, lat, label = City), size=3) +
  ggtitle("USA Cities Average Temperature") + theme(plot.title = element_text(hjust = 0.5)) +
  scale_colour_gradient(low = "blue", high = "red")
map1 


### Plotting Average Temperatures for USA Cities
map2 <- ggplot(majorcityusa, aes(x = Year, y = Temp, colour = City)) + geom_point() + geom_smooth()+
  ggtitle("USA Average Temperature") + theme(plot.title = element_text(hjust = 0.5))
map2

