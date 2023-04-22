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
  group_by(Un15YN,RIDRETH3) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeRace <- labelled::set_variable_labels(AllMergeRace, .labels = AllLab)

AllMergeEdu <- AllMerge %>%
  group_by(DMDEDUC2) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeEdu <- labelled::set_variable_labels(AllMergeEdu, .labels = AllLab)

AllMergeYearSex <- AllMerge %>%
  group_by(Un15YN, RIAGENDR, Year) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeYearSex <- labelled::set_variable_labels(AllMergeYearSex, .labels = AllLab)

AllMergeYearRace <- AllMerge %>%
  group_by(Un15YN,RIDRETH3, Year) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeYearRace <- labelled::set_variable_labels(AllMergeYearRace, .labels = AllLab)

AllMergeAge <- AllMerge %>%
  group_by(age_group) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeAge <- labelled::set_variable_labels(AllMergeAge, .labels = AllLab)

AllMergeObese <- AllMerge %>%
  group_by(RFMObese,RIAGENDR ,Year) %>%
  add_tally() %>%
  summarise_all(mean,na.rm=TRUE)
AllMergeObese <- labelled::set_variable_labels(AllMergeObese, .labels = AllLab)