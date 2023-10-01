#CDC Data Visualization

library(tidyverse)
library(ggplot2)

spotify_stats <- read.csv("Spotify Final.csv")%>%
  mutate(Duration_in_Seconds = Duration/1000)

avg_dur = c()
avg_dance = c()
avg_pop = c()
avg_spch = c()
avg_val = c()
for (year in spotify_stats$Year) {
  avg_dur = c(avg_dur, mean(spotify_stats[spotify_stats$Year == year,]$Duration_in_Seconds, na.rm=TRUE))
  avg_dance = c(avg_dance, mean(spotify_stats[spotify_stats$Year == year,]$Danceability, na.rm=TRUE))
  avg_pop = c(avg_pop, mean(spotify_stats[spotify_stats$Year == year,]$Popularity, na.rm=TRUE))
  avg_spch = c(avg_spch, mean(spotify_stats[spotify_stats$Year == year,]$Speechiness, na.rm=TRUE))
  avg_val = c(avg_val, mean(spotify_stats[spotify_stats$Year == year,]$Valences, na.rm=TRUE))
}
  
averages <- data.frame(Year = spotify_stats$Year, Average_Duration = avg_dur, Average_Danceability = avg_dance, Average_Popularity = avg_pop, Average_Speechiness = avg_spch, Average_Valence = avg_val) %>% distinct()

longevity <- data.frame(matrix(ncol = 2, nrow = 0))
colnames(artist_longevity) <- c('Artist', 'Years')
for (i in 1:nrow(spotify_statistics)) {
  artist <- spotify_statistics$Artist[i]
  artist_songs <- spotify_statistics[spotify_statistics$"Artists" == artist,]
  artist_longevity <- data.frame('Artist' = artist, 'Years' = artist_songs$Year[nrow(artist_songs)] - artist_songs$Year[1])
  rbind(longevity, artist_longevity)
}

#average duration vs. Year
ggplot(data = averages,aes(x=Year, y=Average_Duration)) + 
  geom_point(color="#7eb7e8", shape="circle") + 
  geom_smooth(method = loess, se = F, color="#0072ce") +
  labs(x = "Year", y = "Average Duration(s)") +
  ggtitle("Average Duration vs. Year") +
  theme_minimal()

#duration vs. Year
ggplot(data = spotify_stats,aes(x=Year, y=Duration_in_Seconds)) + 
  geom_point(color="#7eb7e8", shape="circle") + 
  geom_smooth(method = loess, se = FALSE, color="#0072ce") +
  labs(x = "Year", y = "Duration(s)") +
  ggtitle("Duration vs. Year") +
  theme_minimal()


#average danceability vs. Year
ggplot(data = averages,aes(x=Year, y=Average_Danceability)) + 
  geom_point(color="#7eb7e8", shape="circle") + 
  geom_smooth(method = loess, se = TRUE, color="#0072ce") +
  labs(x = "Year", y = "Average Danceability") +
  ggtitle("Average Danceability vs. Year") +
  theme_minimal()

#Year vs. danceability
ggplot(data = spotify_stats,aes(x=Year, y=Danceability)) + 
  geom_point(color="#7eb7e8", shape="circle") + 
  geom_smooth(method = loess, se = FALSE, color="#0072ce") +
  labs(x = "Year", y = "Danceability") +
  ggtitle("Danceability vs. Year") +
  theme_minimal()

#Popularity vs. Year
ggplot(data = spotify_stats,aes(x=Year, y=Popularity)) + 
  geom_point(color="#7eb7e8", shape="circle") + 
  geom_smooth(method = loess, se = FALSE, color="#0072ce") +
  labs(x = "Year", y = "Popularity") +
  ggtitle("Popularity vs. Year") +
  theme_minimal()
  
#average popularity vs. Year
ggplot(data = averages,aes(x=Year, y=Average_Popularity)) + 
  geom_point(color="#7eb7e8", shape="circle") + 
  geom_smooth(method = loess, se = T, color="#0072ce") +
  labs(x = "Year", y = "Average Popularity") +
  ggtitle("Average Popularity vs. Year") +
  theme_minimal()

#valence and pop
ggplot(data = spotify_stats,aes(x=Year, y=Popularity, size = Valence)) + 
  geom_point(fill = "#7eb7e8", color = "#0072ce", shape=21) + 
  geom_smooth(method = loess, se = FALSE, color="#0072ce") +
  labs(x = "Year", y = "Popularity") +
  ggtitle("Valence, Popularity, and Time") +
  theme_minimal()

#avg speechiness and time
ggplot(data = averages,aes(x=Year, y=Average_Speechiness)) + 
  geom_point(color="#7eb7e8", shape="circle") + 
  geom_smooth(method = loess, se = F, color="#0072ce") +
  labs(x = "Year", y = "Average Speechiness") +
  ggtitle("Average Speechiness vs. Year") +
  theme_minimal()

#speechiness pop and time
ggplot(data = spotify_stats,aes(x=Year, y=Popularity, size = Speechiness)) + 
  geom_point(fill = "#7eb7e8", color = "#0072ce", shape=21) + 
  geom_smooth(method = loess, se = FALSE, color="#0072ce") +
  labs(x = "Year", y = "Popularity") +
  ggtitle("Speechiness, Popularity, and Time") +
  theme_minimal()

