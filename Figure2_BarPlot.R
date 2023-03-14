########################################################################################################
# WordCloud R_AN.R
########################################################################################################
# Imports screening and citation management results from screening tool review and creates figure.
########################################################################################################

########################################################################################################
# Initial Set-Up
########################################################################################################
# Clear Variables
rm(list=ls(all=TRUE))

# Load packages (load if needed)
test<-require(RColorBrewer)   
if (test == FALSE) {
  install.packages("RColorBrewer")
  require(RColorBrewer)
}
test<-require(wordcloud)   
if (test == FALSE) {
  install.packages("wordcloud")
  require(wordcloud)
}
test<-require(SnowballC)   
if (test == FALSE) {
  install.packages("SnowballC")
  require(SnowballC)
}
test<-require(tm)   
if (test == FALSE) {
  install.packages("tm")
  require(tm)
}
test<-require(ggplot2)   
if (test == FALSE) {
  install.packages("ggplot2")
  require(ggplot2)
}
rm(test)

#######################################################################################################
# Load Data
#######################################################################################################
##### load screening data #####

text <- readLines(c("screening tools.txt"))

# Load the data as a corpus
docs <- Corpus(VectorSource(text))

inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, ",")

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
screen <- data.frame(word = names(v),freq=v)
head(screen, 10)
rm(text, v, docs, dtm, m)

##### load citation management data #####
text <- readLines(c("citation tools.txt"))

# Load the data as a corpus
docs <- Corpus(VectorSource(text))

inspect(docs)

docs <- tm_map(docs, toSpace, ",")

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
cite <- data.frame(word = names(v),freq=v)
head(cite, 10)

rm(text, v, docs, dtm, m, toSpace)

#######################################################################################################
# Process Data
#######################################################################################################
##### reshape data as needed #####
cite$stage <- "Citation Management"
screen$stage <- "Screening"

df <- rbind(cite, screen)

#######################################################################################################
# Create Figure
#######################################################################################################
fig <- ggplot(df, aes(y=freq, x=word)) + 
  geom_bar(position="dodge", stat="identity") +
  # ggtitle("Studying 4 species..") +
  facet_wrap(~stage, scale="free") +
  # theme_ipsum() +
  theme(legend.position="none") +
  xlab("") + ylab("Frequency") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.8, hjust=0.5))

#######################################################################################################
# Save Output
#######################################################################################################
ggsave(filename = "screeningtool_fig.jpeg", plot = fig, device = "jpeg", width = 6.5, height = 4, units = "in")
