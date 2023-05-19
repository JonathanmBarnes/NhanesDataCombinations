NHANES Data Combinations and Exploration
================

### Attempting to explain obesity and waist size trends using NHANES data.

## Project Introduction

This idea began as a curiosity for me as to which micronutrients are
most important in the human body and its functions biochemically.
Because of my background and what is now my degree in data analytics I
chose to look for data sets that could offer analytically insight into
my questions outside of just literature. It gave me an opportunity to
apply skills I’ve learned to a topic I enjoy, in addition to honing my
ability to use R. Almost immediately came across the NHANES survey out
of the CDC and the data sets they publish bi-yearly from it, I then took
up the task of combining them into a single data frame I could analyze.

After my initial exploration of the data I discovered some interesting
trends I didn’t expect and want to look closer. Namely that while
obesity is increasing, we are appearing to consume the same amount of
calories. With that said this project transitioned into what factors
influence obesity and now more specifically waist sizes increasing over
time. Over this semester I aimed get more data into the file and
properly clean it, in addition to completing a PCA of the data as well
as other possible regressions.

The project is far from over as I aim to be able to spend more time on
it this summer and during my masters. I want to look at preforming
different clustering or dimension reduction techniques in hopes it might
discover something fun. Currently I worked to just determine what
actually plays a role or if there is correlation between obesity or
waist size and recorded metrics in the survey. Specific visualizations
are not completed however will be added in the future.

## Files and Layout

Currently I have mostly separated files for each of the stages in the
project, they individually do something although they could made more
efficient. I do aim to improve. The R script below loads any packages
I’ve used or tried to use, individual functions I wrote for this
project.

``` r
source('Packages.R') 
```

The next, arguably most important file is contains the R coding for the
import and reading of all of the individual data sets I chose to use
from the NHANES survey. The output of this is several large lists with 5
elements. They are labeled by which NHANES survey is contained inside,
with each element representing a different survey year/release.

``` r
source('DataImport.R')
```

    Current Elapsed Time: 6.125922 Seconds 
    Data Read From Folders

## Data Set Creation and Methods

The phrase saying most of the time preforming an analysis is spent in
cleaning unfortunately holds true. I’ve lost track at the total time
spent on cleaning, merging, and creating.

One of the many annoyances with the NHANES data is that most things are
separate requiring the merging into a single frame. what made it worse
was that I was exploring over the last 10 years, so I had five times as
many files as opposed to a single year. The native NHANES files all
contain a variable name, typically 6-7 letters and numbers, as well as
description of each variable. Throughout the process of combining and
merging the data I worked to keep both to aid in readability.

By the end I had 5 files from the following categories or sections from
the CDC: Nutrition Day 1 and 2, Income, Demographics, Body Measurements,
and Physical Activity.

``` r
source('NutritionCleaning.R')
```

    Current Elapsed Time: 0.3438408 Seconds 
    Finished Step 1: Data Pulled From Files, Years assigned by release yearCurrent Elapsed Time: 1.096871 Seconds 
    Finished Step 2: Data Frames CreatedCurrent Elapsed Time: 1.096987 Seconds 
    Finished Step 3: Assigning Labels as Column NamesCurrent Elapsed Time: 1.117783 Seconds 
    Finished Step 4: Created extra variablesCurrent Elapsed Time: 1.117788 Seconds 
    Finished Step 5/5: Finished Cleaning

``` r
source('DataMerging.R')
```

The two files above handle this task. The nutrition cleaning file was my
original file that only combined the nutritional data since that was at
the time all I was concerned about.

The Data merging script takes a simpler function (written in the
Packages.R script) and combines all of the other files together to
create an AllMerge file. It also removes many of the old created files,
the main whole file was taking up over 150 MB of data itself.

The remaining file before any creation or removal contains 155
dimensions and a total of 41297 individual records.

## Additional Cleaning and Additional Variables

``` r
source('CreatingVariables.R')
source('CreatingGroupedDFs.R')
```

From that created data frame I then chose to create a number of extra
variables from previously exist variables. Previous research and
experience loosing weight had led me to look at diet consumption and
macronutreient consumption so I created metrics using dplyr that labeled
what percent of the diet was fats, proteins, and carbohydrates. I also
looked at saturated fats.

Following exploration of those variables and additional from NHANES, I
created variables for the following:

- RFM Metric - Newer alternative calculation for predicting body fat
  percentage. Works better then BMI

- RFM Obese - Binary variable that depicts if someone is obese or not
  based on the RFM metric and the cut off point for their specific sex

- Weight to Waist Size - Ratio for Weight to Waist, testing if this
  would be efficient when compared to height to waist

- BMR - Basal Metabolic rate based on listed height and weigh of subject

- BMR - Kcal - measurement of BMR subtracting the total number of
  calories consumed.

- Height to Waist Ratio - Simple ratio of height to waist size. From my
  findings general consensus lists a ratio of .5 or under as healthy.

- BMI Obese metric - Just like with RFM, a variable showing obesity
  however it is broken down 0:4 to show what stage they are. Someone who
  is underweight is a 0, normal is 1, overweight is 2, obese is 3, and
  clinically obese would be 4.

- Under 18 - Binary to show if someone is over or under 18, used to
  separate children data from adults since it was skewing and affecting
  the averages.

- Under 15 - Binary for over or under 15 years of age. This was the year
  where the rate of growth showed slowing in both height and weight,
  lessening the impact in averages with adults.

- Age Group Numeric - Separated age into 18 groupings. the groups span
  about 5 years of age but gave a glimpse into dietary changes in
  different age groups. It helped explain some things, for example
  caffeine looked to increase obesity. However when you looked at the
  data by age it was that caffeine consumption increased with age and
  there happened to be a lot of older people who were obese driving up
  the average.

Other important cleaning done here was the removal of 43 rows from the
original AllMerge data frame, leaving a total of 129 dimensions. For the
most part it came down to irrelevancy or them just not being important
for what I was trying to see.

I also implemented quick NA handling where if a specific row is missing
more then 75% of the possible data points, the row is removed. At the
point of implementation it was working however looking at it now, I’m
not sure if it is changing anything or removing rows.

## Findings

So far in my explorations I’ve been able to come to the single
conclusion that things just don’t make sense. At the beginning I was
assuming that I would see a trend of more calories being eaten overtime
and there was not particularly a significant change which was odd
considering that we were still increasing in obesity rates. A partial
explanation here would be we are on average eating more then we need so
we will end up storing more, but it led me to questions as what else is
missing or included in our diet that is leading to an increase in
adoposity at least in America. Genetics and so many other factors
ultimately play into this

In a general sense we seem to be lacking in vitamin consumption across
the board which biochemically could be acting as a catalyst for the
obesity we’re seeing. There is little specific dietary trends which also
could point to why things are getting worse. We know sugar consumption
can lead to storage of fat, we also know that metabolism tends to slow
as we age. In the data it was showing that children consume
significantly more sugar then an adult could contribute to their
obesity, but also if they are setting a foundation where they hold more
weight it makes it harder to loose.

In line with my goals I preformed a PCA using the prcomp function.

``` r
AllMerge[is.na(AllMerge)] <- 0
NonNumeric <- which(!sapply(AllMerge, is.numeric))
PCA <- prcomp(AllMerge[,-NonNumeric])
PCA <- summary(PCA)
tidy(t(PCA$importance[,1:6]))
```

    # A tibble: 6 × 1
      x[,"Standard deviation"] [,"Proportion of Variance"] [,"Cumulative Proportio…¹
                         <dbl>                       <dbl>                     <dbl>
    1                   17877.                     0.757                       0.757
    2                    7886.                     0.147                       0.904
    3                    4687.                     0.052                       0.956
    4                    2702.                     0.0173                      0.973
    5                    2310.                     0.0126                      0.986
    6                    1392.                     0.00459                     0.990
    # ℹ abbreviated name: ¹​[,"Cumulative Proportion"]

``` r
intercept <- lm(HWR~1, data = AllMerge[,-c(1:10, 119:123,125:129, 84)])

glm <- lm(HWR~., data = AllMerge[,-c(1:10, 119:123,125:129, 84)])
Stepwise <- step(intercept, trace=0, steps = 10, direction = "both", scope = formula(glm))
tidy(Stepwise)
```

    # A tibble: 11 × 5
       term          estimate   std.error statistic  p.value
       <chr>            <dbl>       <dbl>     <dbl>    <dbl>
     1 (Intercept)  0.453     0.00304        149.   0       
     2 PAQ650       0.0329    0.00168         19.6  6.07e-85
     3 FatPercent   0.00128   0.0000665       19.2  5.07e-82
     4 DRQSDT1      0.0679    0.00330         20.6  1.14e-93
     5 RIDRETH1    -0.0135    0.000643       -21.0  1.00e-97
     6 DMDEDUC2     0.00738   0.000563        13.1  3.37e-39
     7 RIDAGEYR     0.000665  0.0000493       13.5  1.89e-41
     8 PAQ620      -0.0160    0.00145        -11.0  2.93e-28
     9 DR1TMOIS     0.0000107 0.000000827     13.0  1.60e-38
    10 DR1TMAGN    -0.0000872 0.00000755     -11.5  9.22e-31
    11 CarbPercent  0.000442  0.0000475        9.30 1.54e-20

``` r
glance(Stepwise)
```

    # A tibble: 1 × 12
      r.squared adj.r.squared sigma statistic p.value    df logLik     AIC     BIC
          <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>  <dbl>   <dbl>   <dbl>
    1     0.121         0.120 0.161      566.       0    10 16846. -33668. -33564.
    # ℹ 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

- Vigorous Rec activities

- Fat Percent

- On weight loss or low cal diet

- Race/Hispanic Origin

- Education level (over 20)

- Age in Years

- Moderate work activity

- Moisture

- Magnesium

- Carbohydrate Percent

## Current Future Ideas
