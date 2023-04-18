BMMerge <- DFMerge(BMRaw)
DemMerge <- DFMerge(Dem)
D1Merge <- DFMerge(Day1Raw)
D2Merge <- DFMerge(Day2Raw)
IncomeMerge <- DFMerge(IncomeRaw[1:4], StartYear = 2018)
lab= lapply(IncomeMerge, attr, "label")
IncomeRaw[[5]]$Year <- 2020
IncomeMerge <- bind_rows(IncomeMerge, IncomeRaw[[5]], )
for (i in 1:ncol(IncomeMerge)) {
  attr(IncomeMerge[,i], "label") <- lab[[i]]
}
DFList <- list(IncomeMerge, DemMerge, data_cleanComFMerge)
AllMerge <- BMMerge[1:(length(BMMerge)-1)]
for (i in 1:length(DFList)){
  DemCount <- lengths(DFList[i]) - 1
  AllMerge <- merge(AllMerge, DFList[[i]][,1:DemCount], by = "SEQN")
}
rm(BMRaw, Dem, Day1Raw, Day2Raw, IncomeRaw, DFList, lab, DemCount, startTime, yearHold, coltemp, data_cleanComLong)

AllMerge <- AllMerge %>%
  mutate(RFM = (64 - (20 * AllMerge$BMXHT/AllMerge$BMXWAIST) + (12 * (AllMerge$RIAGENDR-1)))) %>%
  mutate(Un18YN = ifelse(AllMerge$RIDAGEYR >= 18, "Yes", "No")) %>%
  mutate(Un15YN = ifelse(AllMerge$RIDAGEYR >= 15, "Yes", "No"))

AllMergeYear <- AllMerge %>%
  group_by(Year) %>%
  summarise_all(mean,na.rm=TRUE)

AllMergeSex <- AllMerge %>%
  group_by(RIAGENDR) %>%
  summarise_all(mean,na.rm=TRUE)

AllMergeRace <- AllMerge %>%
  group_by(RIDRETH3) %>%
  summarise_all(mean,na.rm=TRUE)

AllMergeRace <- AllMerge %>%
  group_by(DMDEDUC2) %>%
  summarise_all(mean,na.rm=TRUE)


