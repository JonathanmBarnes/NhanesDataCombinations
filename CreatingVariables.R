AllLab <- lapply(AllMerge, attr, "label")
AllMerge <- AllMerge %>%
  mutate(FatPercent = ((AllMerge$DR1TTFAT* 9)/AllMerge$DR1TKCAL)*100) %>%
  mutate(FatCalories = (AllMerge$DR1TTFAT* 9)) %>%
  mutate(ProPercent = ((AllMerge$DR1TPROT* 4)/AllMerge$DR1TKCAL*100)) %>%
  mutate(CarbPercent = ((AllMerge$DR1TCARB* 4)/AllMerge$DR1TKCAL*100)) %>%
  mutate(SFatPercent = ((AllMerge$DR1TSFAT* 9)/AllMerge$DR1TKCAL*100))%>%
  mutate(SFatCalories = (AllMerge$DR1TSFAT* 9)) %>%
  mutate(RFM = (64 - (20 * AllMerge$BMXHT/AllMerge$BMXWAIST) + (12 * (AllMerge$RIAGENDR-1)))) %>%
  mutate(RFMObese = ifelse(AllMerge$RIAGENDR == 2, ifelse(RFM >= 33.9, 1,0), ifelse(RFM >= 22.8, 1, 0))) %>%
  mutate(HWR = AllMerge$BMXHT/AllMerge$BMXWAIST) %>%
  mutate(BMIObese = cut(AllMerge$BMXBMI, breaks = c(-Inf, 18.5, 24.9, 29.9, 39.9, Inf),labels = c(0,1,2,3,4))) %>%
  mutate(Un18YN = ifelse(AllMerge$RIDAGEYR >= 18, 0, 1)) %>%
  mutate(Un15YN = ifelse(AllMerge$RIDAGEYR >= 15, 0, 1)) %>%
  mutate(age_groupNum = cut(AllMerge$RIDAGEYR, breaks = 16, labels = seq(1:16))) %>%
  mutate(age_group = cut(AllMerge$RIDAGEYR, breaks = 16))

CreatedLabels <- list("Percent of calories that are fat", "Total fat calories",
                      "Percent of calories that are protein", "Percent of calories that are carbohydrates",
                      "Percent of calories that are saturated fats", "Total saturated fat calories",
                      "RFM Metric","RFM Obese" ,"Height to Waist Ratio", "BMI Obese metric",
                      "Under 18", "Under 15", "Age Group Numeric")


AllLabFull <- append(AllLab, CreatedLabels)
rm(CreatedLabels)