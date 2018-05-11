# read in data frames
sentBefore = read.csv('~/Documents/PDS/FinalProject/sentBefore.csv')
sentAfter = read.csv('~/Documents/PDS/FinalProject/sentAfter.csv')

sentBefore = sentBefore[, c(2, 3)]
colnames(sentBefore) = c('score', 'region')

sentAfter = sentAfter[, c(2, 3)]
colnames(sentAfter) = c('score', 'region')

sentDiff = sentAfter
sentDiff$scoreDiff = sentDiff$score - sentBefore$score
sentDiff = sentDiff[, c(2, 3)]

library(ggplot2)
library(maps)

# heat map of sentiment before election
states <- map_data("state")
map.df <- merge(states, sentBefore, by="region", all.x=T)
map.df <- map.df[order(map.df$order), ]
ggplot(map.df, aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill=score)) +
  geom_path() + 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
  coord_map()

# heat map of sentiment after election
map.df.after <- merge(states, sentAfter, by="region", all.x=T)
map.df.after <- map.df.after[order(map.df.after$order), ]
ggplot(map.df.after, aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill=score)) +
  geom_path() + 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
  coord_map()

# heat map of difference in sentiment values
map.df.diff <- merge(states, sentDiff, by="region", all.x=T)
map.df.diff <- map.df.diff[order(map.df.diff$order), ]
ggplot(map.df.diff, aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill=scoreDiff)) +
  geom_path() + 
  scale_fill_gradientn(colours=rev(heat.colors(10)),na.value="grey90")+
  coord_map()
