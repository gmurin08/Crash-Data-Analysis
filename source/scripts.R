#Import necessary library to connect with mysql
library(RMariaDB)
# The connection method below uses a password stored in a settings file.

# Giving R the correct directory for the mysql config data
rmariadb.settingsfile<-"Z:\\SNHU Coursework\\DAT-375\\Week 3\\M3 Assignment\\boro.cnf"

# Connecting to the tweet db from mysql and assigning to an object
rmariadb.db<-"boro"
boroDb<-dbConnect(RMariaDB::MariaDB(),default.file=rmariadb.settingsfile,
                   group=rmariadb.db)

#set the appropriate working directory to find our csv file
#setwd("Z:\\SNHU Coursework\\DAT-375\\Week 3\\M3 Assignment")

#read the csv data into a variable to be passed into mysql
#tweetData <- read.csv(file="boros.csv",
#                      header=TRUE, sep=",")

#write the csv data into mysql database
#dbWriteTable(tweetDb, value = tweetData, row.names = FALSE, 
#             name = "boro", append=TRUE)

#query to determine the number of tweets per user
query<-paste("SELECT NYCBOROUGH, COUNT('ViolationCode')AS num_crashes
FROM boro
GROUP BY NYCBOROUGH
ORDER BY num_crashes desc
LIMIT 3;" , sep=",")

#pass the query into sql and store result as a dataframe
rs = dbSendQuery(boroDb, query)

result <- dbFetch(rs)

boros <- result
print(result)

dbClearResult(rs)
dbDisconnect(boroDb)





