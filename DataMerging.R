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
AllLab <- lapply(BMMerge[1:(length(BMMerge)-1)], attr, "label")
for (i in 1:length(DFList)){
  DemCount <- lengths(DFList[i]) - 1
  AllLab <- c(AllLab, lapply(DFList[[i]][,2:DemCount], attr, "label"))
  AllMerge <- merge(AllMerge, DFList[[i]][,1:DemCount], by = "SEQN", sort = F)
}
for (i in 1:ncol(AllMerge)) {
  attr(AllMerge[,i], "label") <- AllLab[[i]]
}

rm(BMRaw, Dem, Day1Raw, Day2Raw, IncomeRaw, DFList, lab, DemCount, startTime, yearHold, coltemp, data_cleanComLong, i, path,
   data_cleanCom, data_cleanCombined, data_cleanComFull, BMMerge, DemMerge, IncomeMerge, D1Merge, D2Merge, data_cleanComFMerge)
