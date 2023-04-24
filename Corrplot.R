AllMergeLabelCol <- AllMerge
colnames(AllMergeLabelCol) <- AllLabFull
NonNumeric <- which(!sapply(AllMergeLabelCol, is.numeric))
FullMergeCorr <- cor(AllMergeLabelCol[,-NonNumeric], use = "pairwise.complete.obs")
FullMergeCorr[is.na(FullMergeCorr)] <- 0
#write.csv(FullMergeCorr, "CorrMatrix.csv")