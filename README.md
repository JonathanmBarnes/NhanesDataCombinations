NHANES Data Combinations and Exploration
================

### Attempting to explain obesity and waist size trends using NHANES data.

## Project Introduction

This idea began as a curiosity for me as to which micronutrients are
most important in the human body and its functions biochemically.
Because of my background in statistics, computer sciences, and what is
now my degree in data analytics I chose to look for data sets that could
offer analytically insight into my questions outside of just literature.
It gave me an opportunity to apply skills I’ve learned to a topic I
enjoy, in addition to honing my ability to use R. Almost immediately
came across the NHANES survey out of the CDC and the data sets they
publish bi-yearly from it, I then took up the task of combining them
into a single data frame I could analyze.

After my initial exploration of the data I discovered some interesting
trends I didn’t expect and wanted to look closer. Namely that while
obesity is increasing we appear to consume the same amount of calories.
With that said this project transitioned into what factors influence
obesity and now more specifically waist sizes increasing over time. It
very much is a find the needle idea but it was not only entertaining but
informational.

Over this semester I aimed get more data into the file and properly
clean it, in addition to completing a PCA of the data as well as other
possible regressions. I was helped and advised by Dr. Okamoto during the
semester and greatly appreciate his insight.

The project is not complete and I aim to be able to spend more time on
it during my masters. I want to look at preforming different clustering
methods, dimension reduction techniques, and more ways to deal with
multivariate data in hopes it might discover something fun. Currently I
worked to just determine what actually plays a role and if there is
correlation between obesity or waist size, and recorded metrics in the
survey. Some visualizations are present but not all however they will be
added in the future.

## Files and Layout

Currently I have separated files for each of the stage in the project,
they individually do something although they could made more efficient.
I do aim to improve that. All of them can be found in the repository for
more specific detail on what they do or what is included.

The R script below loads any packages I’ve used or tried to use, and
then individual functions I wrote for this project.

``` r
source('Packages.R') 
```

The next, arguably most important file is contains the R coding for the
import and reading of all of the individual data sets from the main data
folder. The output of this is several large lists with 5 elements. They
are labeled by which NHANES survey is contained inside, with each
element representing a different survey year/release.

``` r
source('DataImport.R')
```

    Current Elapsed Time: 5.151193 Seconds 
    Data Read From Folders

## Data Set Creation and Methods

The phrase most of the time preforming an analysis is spent in cleaning
unfortunately holds true. I’ve lost track at the total time spent on
cleaning, merging, and creating but am happy the difficult parts are
done for now.

One of the many annoyances with the NHANES data is that most things are
separate files requiring the merging into a single data frame. what made
it worse was that I was exploring over the last 10 years, so I had five
times as many files as opposed to a single year. The native NHANES files
all contain a variable name, typically 6-7 letters or numbers, as well
as a written description of each variable as a label attribute.
Throughout the process of combining and merging the data I worked to
keep both to aid in readability.

By the end I had 5 merged files from the following categories or
sections from the CDC: Nutrition Day 1 and 2, Income, Demographics, Body
Measurements, and Physical Activity.

``` r
source('NutritionCleaning.R')
```

    Current Elapsed Time: 0.1759861 Seconds 
    Finished Step 1: Data Pulled From Files, Years assigned by release yearCurrent Elapsed Time: 53.32734 Seconds 
    Finished Step 2: Data Frames CreatedCurrent Elapsed Time: 53.33024 Seconds 
    Finished Step 3: Assigning Labels as Column NamesCurrent Elapsed Time: 54.28219 Seconds 
    Finished Step 4: Created extra variablesCurrent Elapsed Time: 54.28241 Seconds 
    Finished Step 5/5: Finished Cleaning

``` r
source('DataMerging.R')
```

The two files above handle this task. The nutrition cleaning file was my
original file that only combined the nutritional data since that was at
the time all I was concerned about. It is extremely inefficient and at
some point I hope to remove it entirely.

The Data merging script takes a simpler function (written in the
Packages.R script) and combines all of the other files together to
create an AllMerge file. The primary merge function in R didn’t work
leading to me writing my own. Since the variable names remain the same
over the years I was to determine which exist in each data frame and
merge them, and then matching respondent id. The file also removes many
of the old created files to help with an issue of RStudio crashing.

The remaining file before any creation or removal contains 155
dimensions and a total of 41297 individual records.

## Additional Cleaning and Additional Variables

``` r
source('CreatingVariables.R')
source('CreatingGroupedDFs.R')
```

Using the created data frame I then chose to create additional extra
variables from previously existing variables. Previous research and
experience loosing weight had led me to look at diet consumption and
macronutreient consumption, I created metrics using dplyr that
calculated what percent of the diet was fats, proteins, and
carbohydrates. I also looked at saturated fats.

Following exploration of those variables and additional files from
NHANES, I created variables for the following:

##### New Variables

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
conclusion that data just doesn’t make sense. At the beginning I was
assuming that I would see a trend of more calories being eaten overtime
and there was not particularly a significant change which was odd
considering that we were still increasing in obesity rates. A partial
explanation here would be we are on average eating more then we need so
we will end up storing more, but it led me to questions as what else is
missing or included in our diet or lifestyle that is leading to an
increase in adoposity. Genetics and so many other factors ultimately
play into this.

In a general sense, we seem to be lacking in vitamin consumption across
the board. Biochemically this could be acting as a catalyst for the
obesity we’re seeing. There was specific dietary trends which also could
point to why things are getting worse. We know sugar consumption can
lead to storage of fat, we also know that metabolism tends to slow as we
age. In the data it was showing that children consume significantly more
sugar, in excess of 10 grams more then an adult. This could contribute
to their obesity, but also if they are setting a foundation where they
hold more weight earlier in their lives it makes it harder to loose
later in life.

##### Other Things to note:

Waist size has increased about four centimeters over the 10 year span,
with the height to waist ratio raising from .577 to .602. We also on
average are four kilo’s heavier. Finding this more confirmed that we in
fact still seeing this increase in obesity in the US, interestingly
those who were considered to have a healthy obesity level appeared to
consume more calories. Well then I thought, maybe they’re exercising
more and they didn’t appear to be by that much on average. It added to
the list of things not particularly adding up.

##### PCA

In line with my goals I preformed a PCA using the prcomp function in R.

``` r
AllMerge[is.na(AllMerge)] <- 0
AllMerge <- AllMerge[,-1]
NonNumeric <- which(!sapply(AllMerge, is.numeric))
PCA <- prcomp(AllMerge[,-NonNumeric])
PCASum <- summary(PCA)
tidy(t(PCASum$importance[,1:12]))
```

    # A tibble: 12 × 1
       x[,"Standard deviation"] [,"Proportion of Variance"] [,"Cumulative Proporti…¹
                          <dbl>                       <dbl>                    <dbl>
     1                    7889.                     0.605                      0.605
     2                    4688.                     0.214                      0.819
     3                    2702.                     0.0710                     0.890
     4                    2310.                     0.0519                     0.941
     5                    1399.                     0.0190                     0.960
     6                     822.                     0.00657                    0.967
     7                     772.                     0.0058                     0.973
     8                     706.                     0.00484                    0.978
     9                     687.                     0.00459                    0.982
    10                     637.                     0.00394                    0.986
    11                     565.                     0.0031                     0.989
    12                     440.                     0.00188                    0.991
    # ℹ abbreviated name: ¹​[,"Cumulative Proportion"]

``` r
fviz_pca_var(PCA,
             col.var = "contrib", select.var = list(contrib = 7),geom = c("point", "text"),
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),repel = TRUE)
```

![](Readme_files/figure-commonmark/unnamed-chunk-6-1.png)

``` r
fviz_pca_var(PCA, axes = c(2,3),
             col.var = "contrib", select.var = list(contrib = 15),geom = c("point", "text"),
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),repel = TRUE)
```

![](Readme_files/figure-commonmark/unnamed-chunk-7-1.png)

``` r
fviz_pca_var(PCA, axes = c(3,4),
             col.var = "contrib", select.var = list(contrib = 10),geom = c("point", "text"),
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),repel = TRUE)
```

![](Readme_files/figure-commonmark/unnamed-chunk-8-1.png)

The function pops out 125 PC’s for each dimension however the top
tweleve will explain 99% of the variability, with the first 5 containing
over 96%.

As shown in the charts (which I’m not sure I fully understand) Lycopene
is way out to the left. I’m planning at going back and scaling the
variables to see how things are changed, however for now because it
gives an error message I will not.

I didn’t find this are beneficial as I maybe though it would be.

##### Stepwise Regression

I next ran a stepwise regression and simple linear model on the data.
Height to Waist ratio (HTW) was set as the response variable; additional
columns were removed due to their direct explanation or contribution to
the ratio (Ex: Height or the weight of someone)

``` r
intercept <- lm(HWR~1, data = AllMerge[,-c(1:9, 118:122,124:128, 83)])

glm <- lm(HWR~., data = AllMerge[,-c(1:9, 118:122,124:128, 83)])
Stepwise <- step(intercept, trace=0, steps = 10, direction = "both", scope = formula(glm))
glance(glm)
```

    # A tibble: 1 × 12
      r.squared adj.r.squared sigma statistic p.value    df logLik     AIC     BIC
          <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>  <dbl>   <dbl>   <dbl>
    1     0.133         0.131 0.160      60.9       0   104 17146. -34081. -33166.
    # ℹ 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

``` r
glance(Stepwise)
```

    # A tibble: 1 × 12
      r.squared adj.r.squared sigma statistic p.value    df logLik     AIC     BIC
          <dbl>         <dbl> <dbl>     <dbl>   <dbl> <dbl>  <dbl>   <dbl>   <dbl>
    1     0.121         0.120 0.161      566.       0    10 16846. -33668. -33564.
    # ℹ 3 more variables: deviance <dbl>, df.residual <int>, nobs <int>

``` r
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

Overall the base linear model only explained 13.3% and the stepwise
model which only contained 10 variables explained 12.1%. I will need to
go and access model fit and assumptions which don’t look optimal. I also
will need to separate children from adults in the data frames when
running the models due to their points being noticeably different and
impactful.

``` r
par(mfrow = c(2, 2))
plot(Stepwise)
```

![](Readme_files/figure-commonmark/unnamed-chunk-10-1.png)

The variables below were included in the model based on the output from
the stepwise regression. Because of the 40,000 different data points it
makes plotting them individually difficult and I still haven’t
determined the best way to visualize all these variables without taking
up a ton of space.

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

Most of this makes sense in terms of how they may affect ones HTW. I
found it particularly interesting that magnesium was the specific
micronutrient included since it was not significant when running the
model all at once.

As for the other variables I want to look closer at ethnicity but also
Vigorous Rec activities. Ethnicity makes sense to me due to dietary
differences and even possible genetic differences within groups of
people. As for Vigorous rec, in the model it actually has a positive
coefficient so I will want to look and see if that is completely correct
or not.

## Current Future Ideas

I’ve spoken a bit on some of what I would like to explore above. Other
aspects I would like to try are different clustering methods, splines,
and possibly exploring more computationally intensive methods in python
as I better learn analytics packages.

I also want to start focusing on more literature surrounding the topic,
I will likely have more access to free material at the university of
Minnesota.
