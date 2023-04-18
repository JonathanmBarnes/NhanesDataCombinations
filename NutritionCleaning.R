startTime <- Sys.time()
data_cleanishD1 <- data.frame()

yearHold <- seq(2012, 2020,2)
for (i in 1:length(Day1Raw)){
  if(length(Day1Raw[[i]])> 166){
    tempdata <- Day1Raw[[i]][,c(1,18:101)]
    tempdata$Year <- yearHold[i]
  } #15:29 Different Diet Data
  else{
    tempdata <- (Day1Raw[[i]][,c(1,16:99)])
    tempdata$Year <- yearHold[i]
  }
  #Testing, i'm going to lose it if this fixes it
  if (i > 1){
    colnames(tempdata) <- coltemp
  }
  data_cleanishD1 <- rbind(data_cleanishD1, tempdata)
  coltemp <- colnames(data_cleanishD1)
}

#It did.... now for part 2
data_cleanishD2 <- data.frame()

yearHold <- seq(2012, 2020,2)
for (i in 1:length(Day2Raw)){
  if(length(Day2Raw[[i]])> 83){
    tempdata <- Day2Raw[[i]][,c(1,13,16:84)]
    tempdata$Year <- yearHold[i]
  }
  else{
    tempdata <- (Day2Raw[[i]][,c(1,13:82)])
    tempdata$Year <- yearHold[i]
  }
  if (i > 1){
    colnames(tempdata) <- coltemp
  }
  data_cleanishD2 <- rbind(data_cleanishD2, tempdata)
  coltemp <- colnames(data_cleanishD2)
}
cat("Current Elapsed Time:", Sys.time() - startTime, "Seconds","\nFinished Step 1: Data Pulled From Files, Years assigned by release year")

data_cleanCombined <- data_cleanishD1[,c(1,16:86)]
coltemp <- colnames(data_cleanCombined)
colnames(data_cleanishD2) <- coltemp
data_cleanComLong <- rbind(data_cleanCombined, data_cleanishD2)

data_cleanCom <- data_cleanComLong %>%
  group_by(SEQN) %>%
  summarise_all(mean,na.rm=TRUE)

data_cleanComFull <- cbind(data_cleanishD2, data_cleanishD1[,2:15])
data_cleanComFMerge <- data_cleanComFull
cat("Current Elapsed Time:", Sys.time() - startTime, "Seconds","\nFinished Step 2: Data Frames Created")

attr(data_cleanishD1$Year, "label") <- "Year"
attr(data_cleanishD2$Year, "label") <- "Year"
attr(data_cleanComLong$Year, "label") <- "Year"
attr(data_cleanCom$Year, "label") <- "Year"
attr(data_cleanComFull$Year, "label") <- "Year"
lD1= lapply(data_cleanishD1, attr, "label")
lab= lapply(data_cleanComLong, attr, "label")
lFull = lapply(c(data_cleanishD2, data_cleanishD1[,2:15]), attr, "label")

colnames(data_cleanishD1) <- lD1
colnames(data_cleanishD2) <- lab
colnames(data_cleanComLong) <- lab
colnames(data_cleanCom) <- lab
colnames(data_cleanComFull) <- lFull
cat("Current Elapsed Time:", Sys.time() - startTime, "Seconds", "\nFinished Step 3: Assigning Labels as Column Names")

#D1Cor <- cor(x = data_cleanishD1[,1:72], y = data_cleanishD2, use = "pairwise.complete.obs")
#D2Cor <- cor(x = data_cleanishD2, use = "pairwise.complete.obs")
#cat("Current Elapsed Time:", Sys.time() - startTime, "Minutes", "\nFinished Step 4: Creating Correlation Matrices By Day")

#ComCorL <- cor(x = data_cleanComLong, use = "pairwise.complete.obs")
#ComCorFull <- cor(x = data_cleanComFull, use = "pairwise.complete.obs")
#ComCovFull <- cov(x = data_cleanComLong, use = "pairwise.complete.obs")
#cat("Current Elapsed Time:", Sys.time() - startTime, "Minutes", "\nFinished Step 4: Creating Full Correlation and Covariance Matrices")

data_cleanComLong <- data_cleanComLong %>%
  mutate(FatPercent = ((data_cleanComLong$`Total fat (gm)`* 9)/data_cleanComLong$`Energy (kcal)`)*100) %>%
  mutate(FatCalories = (data_cleanComLong$`Total fat (gm)`* 9)) %>%
  mutate(ProPercent = ((data_cleanComLong$`Protein (gm)`* 4)/data_cleanComLong$`Energy (kcal)`)*100) %>%
  mutate(SFatPercent = ((data_cleanComLong$`Total saturated fatty acids (gm)`* 9)/data_cleanComLong$`Energy (kcal)`)*100) %>%
  mutate(SFatCalories = (data_cleanComLong$`Total saturated fatty acids (gm)`* 9)) %>%
  mutate(ExcessSatFat = ((data_cleanComLong$`Total saturated fatty acids (gm)`* 9)- data_cleanComLong$`Energy (kcal)`)/9)

data_cleanCom <- data_cleanComLong %>%
  group_by(Year) %>%
  summarise_all(mean,na.rm=TRUE)

cat("Current Elapsed Time:", Sys.time() - startTime, "Minutes", "\nFinished Step 4: Created extra variables")

#DataComScale <- as.data.frame(scale(data_cleanCom[3:74]))
#DataComScale <- cbind(data_cleanCom[,1],DataComScale)
rm(data_cleanishD1, data_cleanishD2, files, tempdata, Wholedata, lab, lD1, lFull)
cat("Current Elapsed Time:", Sys.time() - startTime, "Minutes", "\nFinished Step 5/5: Finished Cleaning")