AllMerge <- AllMerge %>%
  mutate(FatPercent = ((AllMerge$DR1TTFAT* 9)/AllMerge$DR1TKCAL)*100) %>%
  mutate(FatCalories = (AllMerge$DR1TTFAT* 9)) %>%
  mutate(ProPercent = ((AllMerge$DR1TPROT* 4)/AllMerge$DR1TKCAL*100)) %>%
  mutate(CarbPercent = ((AllMerge$DR1TCARB* 4)/AllMerge$DR1TKCAL*100)) %>%
  mutate(SFatPercent = ((AllMerge$DR1TSFAT* 9)/AllMerge$DR1TKCAL*100))%>%
  mutate(SFatCalories = (AllMerge$DR1TSFAT* 9)) %>%
  mutate(ExcessSatFat = ((AllMerge$DR1TSFAT* 9)- AllMerge$DR1TKCAL)/9) %>%
  mutate(RFM = (64 - (20 * AllMerge$BMXHT/AllMerge$BMXWAIST) + (12 * (AllMerge$RIAGENDR-1)))) %>%
  mutate(Un18YN = ifelse(AllMerge$RIDAGEYR >= 18, "Yes", "No")) %>%
  mutate(Un15YN = ifelse(AllMerge$RIDAGEYR >= 15, "Yes", "No")) %>%
  mutate(age_group = cut(AllMerge$RIDAGEYR, breaks = 16))

AllMergeYear <- AllMerge %>%
  group_by(Un15YN,Year) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeYear <- labelled::set_variable_labels(AllMergeYear, .labels = AllLab)

AllMergeSex <- AllMerge %>%
  group_by(Un15YN, RIAGENDR) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeSex <- labelled::set_variable_labels(AllMergeSex, .labels = AllLab)

AllMergeRace <- AllMerge %>%
  group_by(RIDRETH3) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeRace <- labelled::set_variable_labels(AllMergeRace, .labels = AllLab)

AllMergeEdu <- AllMerge %>%
  group_by(DMDEDUC2) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeEdu <- labelled::set_variable_labels(AllMergeEdu, .labels = AllLab)

AllMergeYearSex <- AllMerge %>%
  group_by(RIAGENDR, Year) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeYearSex <- labelled::set_variable_labels(AllMergeYearSex, .labels = AllLab)

AllMergeYearRace <- AllMerge %>%
  group_by(RIDRETH3, Year) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeYearRace <- labelled::set_variable_labels(AllMergeYearRace, .labels = AllLab)

AllMergeAge <- AllMerge %>%
  group_by(age_group) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeAge <- labelled::set_variable_labels(AllMergeAge, .labels = AllLab)
