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
AllMerge <- BMMerge
for (i in length(DFList)){
  AllMerge <- merge(AllMerge, DFList[i], by = "SEQN")
}