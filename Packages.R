library(haven)
library(tidyverse)
library(mosaic)
library(moments)
library(tidySEM)
library(lavaan)
library(psych)
library(corrplot)
library(tidyr)
library(dplyr)
library(labelled)
library(pls)
library(broom)
#library(rayshader)
#library(plotly)
#library(reshape2)
library(scales)
library(ggthemes)
DFMerge <- function(df_list, StartYear = 2020){
  df_combined <- df_list[[length(df_list)]]
  df_combined$Year <- StartYear
  for (i in 1:(length(df_list)-1)) {
    Year <- seq(2012, StartYear-2, 2)
    df_list[[i]]$Year <- Year[[i]]
    common_names <- intersect(colnames(df_combined), colnames(df_list[[i]]))
    df_combined_sub <- df_combined[, common_names]
    df_i_sub <- df_list[[i]][, common_names]
    df_combined <- rbind(df_combined_sub, df_i_sub)} 
  return(df_combined)
}