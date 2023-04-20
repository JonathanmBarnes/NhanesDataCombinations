AllLab <- lapply(AllMerge, attr, "label")
AllMerge <- AllMerge %>%
  mutate(FatPercent = ((AllMerge$DR1TTFAT* 9)/AllMerge$DR1TKCAL)*100) %>%
  mutate(FatCalories = (AllMerge$DR1TTFAT* 9)) %>%
  mutate(ProPercent = ((AllMerge$DR1TPROT* 4)/AllMerge$DR1TKCAL*100)) %>%
  mutate(CarbPercent = ((AllMerge$DR1TCARB* 4)/AllMerge$DR1TKCAL*100)) %>%
  mutate(SFatPercent = ((AllMerge$DR1TSFAT* 9)/AllMerge$DR1TKCAL*100))%>%
  mutate(SFatCalories = (AllMerge$DR1TSFAT* 9)) %>%
  mutate(RFM = (64 - (20 * AllMerge$BMXHT/AllMerge$BMXWAIST) + (12 * (AllMerge$RIAGENDR-1)))) %>%
  mutate(HWR = AllMerge$BMXHT/AllMerge$BMXWAIST) %>%
  mutate(Un18YN = ifelse(AllMerge$RIDAGEYR >= 18, 0, 1)) %>%
  mutate(Un15YN = ifelse(AllMerge$RIDAGEYR >= 15, 0, 1)) %>%
  mutate(age_group = cut(AllMerge$RIDAGEYR, breaks = 16))

CreatedLabels <- list("Percent of calories that are fat", "Total fat calories",
                      "Percent of calories that are protein", "Percent of calories that are carbohydrates",
                      "Percent of calories that are saturated fats", "Total saturated fat calories",
                      "RFM Metric", "Height to Waist Ratio", "Under 18", "Under 15")


AllLabFull <- append(AllLab, CreatedLabels)
rm(AllLab, CreatedLabels)