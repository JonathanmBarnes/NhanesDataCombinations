NHANES Data Exploration Overview
================

# NHANES Data Combinations and Exploration

### Attempting to explain obesity and waist trends.

## Project Introduction

This idea began as a curiosity for me as to which micronutrients are
most important in the human body and its functions biochemically.
Because of my background and what is now my degree in data analytics I
chose to look for data sets that could offer analytically insight into
my questions outside of just literature. It gave me an oppurtunity to
apply skills I’ve learned to a topic I enjoy, in addition to honing my
ability to use R. Almost immediately came across the NHANES survey out
of the CDC and the data sets they publish bi-yearly from it, I then took
up the task of combining them into a single data frame I could analyze.

After my initial exploration of the data I discovered some interesting
trends I didn’t expect and want to look closer. Namely that while
obesity is increasing, we are appearing to consume the same amount of
calories. With that said this project transitioned into what factors
influence obesity and now more specifically waist sizes increasing over
time.

The project is far from over as I aim to be able to spend more time on
it this summer and during my masters. I want to look at preforming
different clustering or dimension reduction techniques in hopes it might
discover something fun. Currently I worked to just determine what
actually plays a role or if there is correlation between obesity or
waist size and recorded metrics in the survey.

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

    Current Elapsed Time: 5.242292 Seconds 
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

    Current Elapsed Time: 0.1917319 Seconds 
    Finished Step 1: Data Pulled From Files, Years assigned by release yearCurrent Elapsed Time: 51.88396 Seconds 
    Finished Step 2: Data Frames CreatedCurrent Elapsed Time: 51.88768 Seconds 
    Finished Step 3: Assigning Labels as Column NamesCurrent Elapsed Time: 52.85201 Seconds 
    Finished Step 4: Created extra variablesCurrent Elapsed Time: 52.85215 Seconds 
    Finished Step 5/5: Finished Cleaning

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
original AllMerge, leaving a total of 129. For the most part it came
down to irrelevancy or them just not being important for what I was
trying to see.

I also implemented quick NA handling where if a specific row is missing
more then 75% of the possible data points, the row is removed. At the
point of implementation it was working however looking at it now, I’m
not sure if it is changing anything or removing rows.

## Findings

## Current Future Ideas
