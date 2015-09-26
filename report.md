---
title: "Predicting the manner in which man do the exercise"
---

# Predicting the manner in which man do the exercise

## Synopsis

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement - a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, our goal is to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website [here](http://groupware.les.inf.puc-rio.br/har) - see the section on the Weight Lifting Exercise Dataset.

## Exploring the data

The training data for this project are available [here](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv).
The test data are available [here](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv).
The data for this project come from this [source](http://groupware.les.inf.puc-rio.br/har).

Let's load dataset and look at the data primary features:

```r
data <- read.table("data\\pml-training.csv", header = TRUE, sep = ",", colClasses = c( rep("character", 6), rep("numeric", 5), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 42), rep("character", 6), rep("numeric", 12), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 23), rep("character", 6), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 2), rep("character", 1), rep("numeric", 19), rep("character", 1) ))

dim(data)
```

```
## [1] 19622   160
```

```r
head(data)
```

```
##   X user_name raw_timestamp_part_1 raw_timestamp_part_2   cvtd_timestamp
## 1 1  carlitos           1323084231               788290 05/12/2011 11:23
## 2 2  carlitos           1323084231               808298 05/12/2011 11:23
## 3 3  carlitos           1323084231               820366 05/12/2011 11:23
## 4 4  carlitos           1323084232               120339 05/12/2011 11:23
## 5 5  carlitos           1323084232               196328 05/12/2011 11:23
## 6 6  carlitos           1323084232               304277 05/12/2011 11:23
##   new_window num_window roll_belt pitch_belt yaw_belt total_accel_belt
## 1         no         11      1.41       8.07    -94.4                3
## 2         no         11      1.41       8.07    -94.4                3
## 3         no         11      1.42       8.07    -94.4                3
## 4         no         12      1.48       8.05    -94.4                3
## 5         no         12      1.48       8.07    -94.4                3
## 6         no         12      1.45       8.06    -94.4                3
##   kurtosis_roll_belt kurtosis_picth_belt kurtosis_yaw_belt
## 1                                                         
## 2                                                         
## 3                                                         
## 4                                                         
## 5                                                         
## 6                                                         
##   skewness_roll_belt skewness_roll_belt.1 skewness_yaw_belt max_roll_belt
## 1                                                                      NA
## 2                                                                      NA
## 3                                                                      NA
## 4                                                                      NA
## 5                                                                      NA
## 6                                                                      NA
##   max_picth_belt max_yaw_belt min_roll_belt min_pitch_belt min_yaw_belt
## 1             NA                         NA             NA             
## 2             NA                         NA             NA             
## 3             NA                         NA             NA             
## 4             NA                         NA             NA             
## 5             NA                         NA             NA             
## 6             NA                         NA             NA             
##   amplitude_roll_belt amplitude_pitch_belt amplitude_yaw_belt
## 1                  NA                   NA                   
## 2                  NA                   NA                   
## 3                  NA                   NA                   
## 4                  NA                   NA                   
## 5                  NA                   NA                   
## 6                  NA                   NA                   
##   var_total_accel_belt avg_roll_belt stddev_roll_belt var_roll_belt
## 1                   NA            NA               NA            NA
## 2                   NA            NA               NA            NA
## 3                   NA            NA               NA            NA
## 4                   NA            NA               NA            NA
## 5                   NA            NA               NA            NA
## 6                   NA            NA               NA            NA
##   avg_pitch_belt stddev_pitch_belt var_pitch_belt avg_yaw_belt
## 1             NA                NA             NA           NA
## 2             NA                NA             NA           NA
## 3             NA                NA             NA           NA
## 4             NA                NA             NA           NA
## 5             NA                NA             NA           NA
## 6             NA                NA             NA           NA
##   stddev_yaw_belt var_yaw_belt gyros_belt_x gyros_belt_y gyros_belt_z
## 1              NA           NA         0.00         0.00        -0.02
## 2              NA           NA         0.02         0.00        -0.02
## 3              NA           NA         0.00         0.00        -0.02
## 4              NA           NA         0.02         0.00        -0.03
## 5              NA           NA         0.02         0.02        -0.02
## 6              NA           NA         0.02         0.00        -0.02
##   accel_belt_x accel_belt_y accel_belt_z magnet_belt_x magnet_belt_y
## 1          -21            4           22            -3           599
## 2          -22            4           22            -7           608
## 3          -20            5           23            -2           600
## 4          -22            3           21            -6           604
## 5          -21            2           24            -6           600
## 6          -21            4           21             0           603
##   magnet_belt_z roll_arm pitch_arm yaw_arm total_accel_arm var_accel_arm
## 1          -313     -128      22.5    -161              34            NA
## 2          -311     -128      22.5    -161              34            NA
## 3          -305     -128      22.5    -161              34            NA
## 4          -310     -128      22.1    -161              34            NA
## 5          -302     -128      22.1    -161              34            NA
## 6          -312     -128      22.0    -161              34            NA
##   avg_roll_arm stddev_roll_arm var_roll_arm avg_pitch_arm stddev_pitch_arm
## 1           NA              NA           NA            NA               NA
## 2           NA              NA           NA            NA               NA
## 3           NA              NA           NA            NA               NA
## 4           NA              NA           NA            NA               NA
## 5           NA              NA           NA            NA               NA
## 6           NA              NA           NA            NA               NA
##   var_pitch_arm avg_yaw_arm stddev_yaw_arm var_yaw_arm gyros_arm_x
## 1            NA          NA             NA          NA        0.00
## 2            NA          NA             NA          NA        0.02
## 3            NA          NA             NA          NA        0.02
## 4            NA          NA             NA          NA        0.02
## 5            NA          NA             NA          NA        0.00
## 6            NA          NA             NA          NA        0.02
##   gyros_arm_y gyros_arm_z accel_arm_x accel_arm_y accel_arm_z magnet_arm_x
## 1        0.00       -0.02        -288         109        -123         -368
## 2       -0.02       -0.02        -290         110        -125         -369
## 3       -0.02       -0.02        -289         110        -126         -368
## 4       -0.03        0.02        -289         111        -123         -372
## 5       -0.03        0.00        -289         111        -123         -374
## 6       -0.03        0.00        -289         111        -122         -369
##   magnet_arm_y magnet_arm_z kurtosis_roll_arm kurtosis_picth_arm
## 1          337          516                                     
## 2          337          513                                     
## 3          344          513                                     
## 4          344          512                                     
## 5          337          506                                     
## 6          342          513                                     
##   kurtosis_yaw_arm skewness_roll_arm skewness_pitch_arm skewness_yaw_arm
## 1                                                                       
## 2                                                                       
## 3                                                                       
## 4                                                                       
## 5                                                                       
## 6                                                                       
##   max_roll_arm max_picth_arm max_yaw_arm min_roll_arm min_pitch_arm
## 1           NA            NA          NA           NA            NA
## 2           NA            NA          NA           NA            NA
## 3           NA            NA          NA           NA            NA
## 4           NA            NA          NA           NA            NA
## 5           NA            NA          NA           NA            NA
## 6           NA            NA          NA           NA            NA
##   min_yaw_arm amplitude_roll_arm amplitude_pitch_arm amplitude_yaw_arm
## 1          NA                 NA                  NA                NA
## 2          NA                 NA                  NA                NA
## 3          NA                 NA                  NA                NA
## 4          NA                 NA                  NA                NA
## 5          NA                 NA                  NA                NA
## 6          NA                 NA                  NA                NA
##   roll_dumbbell pitch_dumbbell yaw_dumbbell kurtosis_roll_dumbbell
## 1      13.05217      -70.49400    -84.87394                       
## 2      13.13074      -70.63751    -84.71065                       
## 3      12.85075      -70.27812    -85.14078                       
## 4      13.43120      -70.39379    -84.87363                       
## 5      13.37872      -70.42856    -84.85306                       
## 6      13.38246      -70.81759    -84.46500                       
##   kurtosis_picth_dumbbell kurtosis_yaw_dumbbell skewness_roll_dumbbell
## 1                                                                     
## 2                                                                     
## 3                                                                     
## 4                                                                     
## 5                                                                     
## 6                                                                     
##   skewness_pitch_dumbbell skewness_yaw_dumbbell max_roll_dumbbell
## 1                                                              NA
## 2                                                              NA
## 3                                                              NA
## 4                                                              NA
## 5                                                              NA
## 6                                                              NA
##   max_picth_dumbbell max_yaw_dumbbell min_roll_dumbbell min_pitch_dumbbell
## 1                 NA                                 NA                 NA
## 2                 NA                                 NA                 NA
## 3                 NA                                 NA                 NA
## 4                 NA                                 NA                 NA
## 5                 NA                                 NA                 NA
## 6                 NA                                 NA                 NA
##   min_yaw_dumbbell amplitude_roll_dumbbell amplitude_pitch_dumbbell
## 1                                       NA                       NA
## 2                                       NA                       NA
## 3                                       NA                       NA
## 4                                       NA                       NA
## 5                                       NA                       NA
## 6                                       NA                       NA
##   amplitude_yaw_dumbbell total_accel_dumbbell var_accel_dumbbell
## 1                                          37                 NA
## 2                                          37                 NA
## 3                                          37                 NA
## 4                                          37                 NA
## 5                                          37                 NA
## 6                                          37                 NA
##   avg_roll_dumbbell stddev_roll_dumbbell var_roll_dumbbell
## 1                NA                   NA                NA
## 2                NA                   NA                NA
## 3                NA                   NA                NA
## 4                NA                   NA                NA
## 5                NA                   NA                NA
## 6                NA                   NA                NA
##   avg_pitch_dumbbell stddev_pitch_dumbbell var_pitch_dumbbell
## 1                 NA                    NA                 NA
## 2                 NA                    NA                 NA
## 3                 NA                    NA                 NA
## 4                 NA                    NA                 NA
## 5                 NA                    NA                 NA
## 6                 NA                    NA                 NA
##   avg_yaw_dumbbell stddev_yaw_dumbbell var_yaw_dumbbell gyros_dumbbell_x
## 1               NA                  NA               NA                0
## 2               NA                  NA               NA                0
## 3               NA                  NA               NA                0
## 4               NA                  NA               NA                0
## 5               NA                  NA               NA                0
## 6               NA                  NA               NA                0
##   gyros_dumbbell_y gyros_dumbbell_z accel_dumbbell_x accel_dumbbell_y
## 1            -0.02             0.00             -234               47
## 2            -0.02             0.00             -233               47
## 3            -0.02             0.00             -232               46
## 4            -0.02            -0.02             -232               48
## 5            -0.02             0.00             -233               48
## 6            -0.02             0.00             -234               48
##   accel_dumbbell_z magnet_dumbbell_x magnet_dumbbell_y magnet_dumbbell_z
## 1             -271              -559               293               -65
## 2             -269              -555               296               -64
## 3             -270              -561               298               -63
## 4             -269              -552               303               -60
## 5             -270              -554               292               -68
## 6             -269              -558               294               -66
##   roll_forearm pitch_forearm yaw_forearm kurtosis_roll_forearm
## 1         28.4         -63.9        -153                      
## 2         28.3         -63.9        -153                      
## 3         28.3         -63.9        -152                      
## 4         28.1         -63.9        -152                      
## 5         28.0         -63.9        -152                      
## 6         27.9         -63.9        -152                      
##   kurtosis_picth_forearm kurtosis_yaw_forearm skewness_roll_forearm
## 1                                                                  
## 2                                                                  
## 3                                                                  
## 4                                                                  
## 5                                                                  
## 6                                                                  
##   skewness_pitch_forearm skewness_yaw_forearm max_roll_forearm
## 1                                                           NA
## 2                                                           NA
## 3                                                           NA
## 4                                                           NA
## 5                                                           NA
## 6                                                           NA
##   max_picth_forearm max_yaw_forearm min_roll_forearm min_pitch_forearm
## 1                NA                               NA                NA
## 2                NA                               NA                NA
## 3                NA                               NA                NA
## 4                NA                               NA                NA
## 5                NA                               NA                NA
## 6                NA                               NA                NA
##   min_yaw_forearm amplitude_roll_forearm amplitude_pitch_forearm
## 1                                     NA                      NA
## 2                                     NA                      NA
## 3                                     NA                      NA
## 4                                     NA                      NA
## 5                                     NA                      NA
## 6                                     NA                      NA
##   amplitude_yaw_forearm total_accel_forearm var_accel_forearm
## 1                                        36                NA
## 2                                        36                NA
## 3                                        36                NA
## 4                                        36                NA
## 5                                        36                NA
## 6                                        36                NA
##   avg_roll_forearm stddev_roll_forearm var_roll_forearm avg_pitch_forearm
## 1               NA                  NA               NA                NA
## 2               NA                  NA               NA                NA
## 3               NA                  NA               NA                NA
## 4               NA                  NA               NA                NA
## 5               NA                  NA               NA                NA
## 6               NA                  NA               NA                NA
##   stddev_pitch_forearm var_pitch_forearm avg_yaw_forearm
## 1                   NA                NA              NA
## 2                   NA                NA              NA
## 3                   NA                NA              NA
## 4                   NA                NA              NA
## 5                   NA                NA              NA
## 6                   NA                NA              NA
##   stddev_yaw_forearm var_yaw_forearm gyros_forearm_x gyros_forearm_y
## 1                 NA              NA            0.03            0.00
## 2                 NA              NA            0.02            0.00
## 3                 NA              NA            0.03           -0.02
## 4                 NA              NA            0.02           -0.02
## 5                 NA              NA            0.02            0.00
## 6                 NA              NA            0.02           -0.02
##   gyros_forearm_z accel_forearm_x accel_forearm_y accel_forearm_z
## 1           -0.02             192             203            -215
## 2           -0.02             192             203            -216
## 3            0.00             196             204            -213
## 4            0.00             189             206            -214
## 5           -0.02             189             206            -214
## 6           -0.03             193             203            -215
##   magnet_forearm_x magnet_forearm_y magnet_forearm_z classe
## 1              -17              654              476      A
## 2              -18              661              473      A
## 3              -18              658              469      A
## 4              -16              658              469      A
## 5              -17              655              473      A
## 6               -9              660              478      A
```

```r
summary(data)
```

```
##       X              user_name         raw_timestamp_part_1
##  Length:19622       Length:19622       Length:19622        
##  Class :character   Class :character   Class :character    
##  Mode  :character   Mode  :character   Mode  :character    
##                                                            
##                                                            
##                                                            
##                                                            
##  raw_timestamp_part_2 cvtd_timestamp      new_window       
##  Length:19622         Length:19622       Length:19622      
##  Class :character     Class :character   Class :character  
##  Mode  :character     Mode  :character   Mode  :character  
##                                                            
##                                                            
##                                                            
##                                                            
##    num_window      roll_belt        pitch_belt          yaw_belt      
##  Min.   :  1.0   Min.   :-28.90   Min.   :-55.8000   Min.   :-180.00  
##  1st Qu.:222.0   1st Qu.:  1.10   1st Qu.:  1.7600   1st Qu.: -88.30  
##  Median :424.0   Median :113.00   Median :  5.2800   Median : -13.00  
##  Mean   :430.6   Mean   : 64.41   Mean   :  0.3053   Mean   : -11.21  
##  3rd Qu.:644.0   3rd Qu.:123.00   3rd Qu.: 14.9000   3rd Qu.:  12.90  
##  Max.   :864.0   Max.   :162.00   Max.   : 60.3000   Max.   : 179.00  
##                                                                       
##  total_accel_belt kurtosis_roll_belt kurtosis_picth_belt
##  Min.   : 0.00    Length:19622       Length:19622       
##  1st Qu.: 3.00    Class :character   Class :character   
##  Median :17.00    Mode  :character   Mode  :character   
##  Mean   :11.31                                          
##  3rd Qu.:18.00                                          
##  Max.   :29.00                                          
##                                                         
##  kurtosis_yaw_belt  skewness_roll_belt skewness_roll_belt.1
##  Length:19622       Length:19622       Length:19622        
##  Class :character   Class :character   Class :character    
##  Mode  :character   Mode  :character   Mode  :character    
##                                                            
##                                                            
##                                                            
##                                                            
##  skewness_yaw_belt  max_roll_belt     max_picth_belt  max_yaw_belt      
##  Length:19622       Min.   :-94.300   Min.   : 3.00   Length:19622      
##  Class :character   1st Qu.:-88.000   1st Qu.: 5.00   Class :character  
##  Mode  :character   Median : -5.100   Median :18.00   Mode  :character  
##                     Mean   : -6.667   Mean   :12.92                     
##                     3rd Qu.: 18.500   3rd Qu.:19.00                     
##                     Max.   :180.000   Max.   :30.00                     
##                     NA's   :19216     NA's   :19216                     
##  min_roll_belt     min_pitch_belt  min_yaw_belt       amplitude_roll_belt
##  Min.   :-180.00   Min.   : 0.00   Length:19622       Min.   :  0.000    
##  1st Qu.: -88.40   1st Qu.: 3.00   Class :character   1st Qu.:  0.300    
##  Median :  -7.85   Median :16.00   Mode  :character   Median :  1.000    
##  Mean   : -10.44   Mean   :10.76                      Mean   :  3.769    
##  3rd Qu.:   9.05   3rd Qu.:17.00                      3rd Qu.:  2.083    
##  Max.   : 173.00   Max.   :23.00                      Max.   :360.000    
##  NA's   :19216     NA's   :19216                      NA's   :19216      
##  amplitude_pitch_belt amplitude_yaw_belt var_total_accel_belt
##  Min.   : 0.000       Length:19622       Min.   : 0.000      
##  1st Qu.: 1.000       Class :character   1st Qu.: 0.100      
##  Median : 1.000       Mode  :character   Median : 0.200      
##  Mean   : 2.167                          Mean   : 0.926      
##  3rd Qu.: 2.000                          3rd Qu.: 0.300      
##  Max.   :12.000                          Max.   :16.500      
##  NA's   :19216                           NA's   :19216       
##  avg_roll_belt    stddev_roll_belt var_roll_belt     avg_pitch_belt   
##  Min.   :-27.40   Min.   : 0.000   Min.   :  0.000   Min.   :-51.400  
##  1st Qu.:  1.10   1st Qu.: 0.200   1st Qu.:  0.000   1st Qu.:  2.025  
##  Median :116.35   Median : 0.400   Median :  0.100   Median :  5.200  
##  Mean   : 68.06   Mean   : 1.337   Mean   :  7.699   Mean   :  0.520  
##  3rd Qu.:123.38   3rd Qu.: 0.700   3rd Qu.:  0.500   3rd Qu.: 15.775  
##  Max.   :157.40   Max.   :14.200   Max.   :200.700   Max.   : 59.700  
##  NA's   :19216    NA's   :19216    NA's   :19216     NA's   :19216    
##  stddev_pitch_belt var_pitch_belt    avg_yaw_belt      stddev_yaw_belt  
##  Min.   :0.000     Min.   : 0.000   Min.   :-138.300   Min.   :  0.000  
##  1st Qu.:0.200     1st Qu.: 0.000   1st Qu.: -88.175   1st Qu.:  0.100  
##  Median :0.400     Median : 0.100   Median :  -6.550   Median :  0.300  
##  Mean   :0.603     Mean   : 0.766   Mean   :  -8.831   Mean   :  1.341  
##  3rd Qu.:0.700     3rd Qu.: 0.500   3rd Qu.:  14.125   3rd Qu.:  0.700  
##  Max.   :4.000     Max.   :16.200   Max.   : 173.500   Max.   :176.600  
##  NA's   :19216     NA's   :19216    NA's   :19216      NA's   :19216    
##   var_yaw_belt        gyros_belt_x        gyros_belt_y     
##  Min.   :    0.000   Min.   :-1.040000   Min.   :-0.64000  
##  1st Qu.:    0.010   1st Qu.:-0.030000   1st Qu.: 0.00000  
##  Median :    0.090   Median : 0.030000   Median : 0.02000  
##  Mean   :  107.487   Mean   :-0.005592   Mean   : 0.03959  
##  3rd Qu.:    0.475   3rd Qu.: 0.110000   3rd Qu.: 0.11000  
##  Max.   :31183.240   Max.   : 2.220000   Max.   : 0.64000  
##  NA's   :19216                                             
##   gyros_belt_z      accel_belt_x       accel_belt_y     accel_belt_z    
##  Min.   :-1.4600   Min.   :-120.000   Min.   :-69.00   Min.   :-275.00  
##  1st Qu.:-0.2000   1st Qu.: -21.000   1st Qu.:  3.00   1st Qu.:-162.00  
##  Median :-0.1000   Median : -15.000   Median : 35.00   Median :-152.00  
##  Mean   :-0.1305   Mean   :  -5.595   Mean   : 30.15   Mean   : -72.59  
##  3rd Qu.:-0.0200   3rd Qu.:  -5.000   3rd Qu.: 61.00   3rd Qu.:  27.00  
##  Max.   : 1.6200   Max.   :  85.000   Max.   :164.00   Max.   : 105.00  
##                                                                         
##  magnet_belt_x   magnet_belt_y   magnet_belt_z       roll_arm      
##  Min.   :-52.0   Min.   :354.0   Min.   :-623.0   Min.   :-180.00  
##  1st Qu.:  9.0   1st Qu.:581.0   1st Qu.:-375.0   1st Qu.: -31.77  
##  Median : 35.0   Median :601.0   Median :-320.0   Median :   0.00  
##  Mean   : 55.6   Mean   :593.7   Mean   :-345.5   Mean   :  17.83  
##  3rd Qu.: 59.0   3rd Qu.:610.0   3rd Qu.:-306.0   3rd Qu.:  77.30  
##  Max.   :485.0   Max.   :673.0   Max.   : 293.0   Max.   : 180.00  
##                                                                    
##    pitch_arm          yaw_arm          total_accel_arm var_accel_arm   
##  Min.   :-88.800   Min.   :-180.0000   Min.   : 1.00   Min.   :  0.00  
##  1st Qu.:-25.900   1st Qu.: -43.1000   1st Qu.:17.00   1st Qu.:  9.03  
##  Median :  0.000   Median :   0.0000   Median :27.00   Median : 40.61  
##  Mean   : -4.612   Mean   :  -0.6188   Mean   :25.51   Mean   : 53.23  
##  3rd Qu.: 11.200   3rd Qu.:  45.8750   3rd Qu.:33.00   3rd Qu.: 75.62  
##  Max.   : 88.500   Max.   : 180.0000   Max.   :66.00   Max.   :331.70  
##                                                        NA's   :19216   
##   avg_roll_arm     stddev_roll_arm    var_roll_arm       avg_pitch_arm    
##  Min.   :-166.67   Min.   :  0.000   Min.   :    0.000   Min.   :-81.773  
##  1st Qu.: -38.37   1st Qu.:  1.376   1st Qu.:    1.898   1st Qu.:-22.770  
##  Median :   0.00   Median :  5.702   Median :   32.517   Median :  0.000  
##  Mean   :  12.68   Mean   : 11.201   Mean   :  417.264   Mean   : -4.901  
##  3rd Qu.:  76.33   3rd Qu.: 14.921   3rd Qu.:  222.647   3rd Qu.:  8.277  
##  Max.   : 163.33   Max.   :161.964   Max.   :26232.208   Max.   : 75.659  
##  NA's   :19216     NA's   :19216     NA's   :19216       NA's   :19216    
##  stddev_pitch_arm var_pitch_arm       avg_yaw_arm       stddev_yaw_arm   
##  Min.   : 0.000   Min.   :   0.000   Min.   :-173.440   Min.   :  0.000  
##  1st Qu.: 1.642   1st Qu.:   2.697   1st Qu.: -29.198   1st Qu.:  2.577  
##  Median : 8.133   Median :  66.146   Median :   0.000   Median : 16.682  
##  Mean   :10.383   Mean   : 195.864   Mean   :   2.359   Mean   : 22.270  
##  3rd Qu.:16.327   3rd Qu.: 266.576   3rd Qu.:  38.185   3rd Qu.: 35.984  
##  Max.   :43.412   Max.   :1884.565   Max.   : 152.000   Max.   :177.044  
##  NA's   :19216    NA's   :19216      NA's   :19216      NA's   :19216    
##   var_yaw_arm         gyros_arm_x        gyros_arm_y     
##  Min.   :    0.000   Min.   :-6.37000   Min.   :-3.4400  
##  1st Qu.:    6.642   1st Qu.:-1.33000   1st Qu.:-0.8000  
##  Median :  278.309   Median : 0.08000   Median :-0.2400  
##  Mean   : 1055.933   Mean   : 0.04277   Mean   :-0.2571  
##  3rd Qu.: 1294.850   3rd Qu.: 1.57000   3rd Qu.: 0.1400  
##  Max.   :31344.568   Max.   : 4.87000   Max.   : 2.8400  
##  NA's   :19216                                           
##   gyros_arm_z       accel_arm_x       accel_arm_y      accel_arm_z     
##  Min.   :-2.3300   Min.   :-404.00   Min.   :-318.0   Min.   :-636.00  
##  1st Qu.:-0.0700   1st Qu.:-242.00   1st Qu.: -54.0   1st Qu.:-143.00  
##  Median : 0.2300   Median : -44.00   Median :  14.0   Median : -47.00  
##  Mean   : 0.2695   Mean   : -60.24   Mean   :  32.6   Mean   : -71.25  
##  3rd Qu.: 0.7200   3rd Qu.:  84.00   3rd Qu.: 139.0   3rd Qu.:  23.00  
##  Max.   : 3.0200   Max.   : 437.00   Max.   : 308.0   Max.   : 292.00  
##                                                                        
##   magnet_arm_x     magnet_arm_y     magnet_arm_z    kurtosis_roll_arm 
##  Min.   :-584.0   Min.   :-392.0   Min.   :-597.0   Length:19622      
##  1st Qu.:-300.0   1st Qu.:  -9.0   1st Qu.: 131.2   Class :character  
##  Median : 289.0   Median : 202.0   Median : 444.0   Mode  :character  
##  Mean   : 191.7   Mean   : 156.6   Mean   : 306.5                     
##  3rd Qu.: 637.0   3rd Qu.: 323.0   3rd Qu.: 545.0                     
##  Max.   : 782.0   Max.   : 583.0   Max.   : 694.0                     
##                                                                       
##  kurtosis_picth_arm kurtosis_yaw_arm   skewness_roll_arm 
##  Length:19622       Length:19622       Length:19622      
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##                                                          
##                                                          
##                                                          
##                                                          
##  skewness_pitch_arm skewness_yaw_arm    max_roll_arm    
##  Length:19622       Length:19622       Min.   :-73.100  
##  Class :character   Class :character   1st Qu.: -0.175  
##  Mode  :character   Mode  :character   Median :  4.950  
##                                        Mean   : 11.236  
##                                        3rd Qu.: 26.775  
##                                        Max.   : 85.500  
##                                        NA's   :19216    
##  max_picth_arm       max_yaw_arm     min_roll_arm    min_pitch_arm    
##  Min.   :-173.000   Min.   : 4.00   Min.   :-89.10   Min.   :-180.00  
##  1st Qu.:  -1.975   1st Qu.:29.00   1st Qu.:-41.98   1st Qu.: -72.62  
##  Median :  23.250   Median :34.00   Median :-22.45   Median : -33.85  
##  Mean   :  35.751   Mean   :35.46   Mean   :-21.22   Mean   : -33.92  
##  3rd Qu.:  95.975   3rd Qu.:41.00   3rd Qu.:  0.00   3rd Qu.:   0.00  
##  Max.   : 180.000   Max.   :65.00   Max.   : 66.40   Max.   : 152.00  
##  NA's   :19216      NA's   :19216   NA's   :19216    NA's   :19216    
##   min_yaw_arm    amplitude_roll_arm amplitude_pitch_arm amplitude_yaw_arm
##  Min.   : 1.00   Min.   :  0.000    Min.   :  0.000     Min.   : 0.00    
##  1st Qu.: 8.00   1st Qu.:  5.425    1st Qu.:  9.925     1st Qu.:13.00    
##  Median :13.00   Median : 28.450    Median : 54.900     Median :22.00    
##  Mean   :14.66   Mean   : 32.452    Mean   : 69.677     Mean   :20.79    
##  3rd Qu.:19.00   3rd Qu.: 50.960    3rd Qu.:115.175     3rd Qu.:28.75    
##  Max.   :38.00   Max.   :119.500    Max.   :360.000     Max.   :52.00    
##  NA's   :19216   NA's   :19216      NA's   :19216       NA's   :19216    
##  roll_dumbbell     pitch_dumbbell     yaw_dumbbell     
##  Min.   :-153.71   Min.   :-149.59   Min.   :-150.871  
##  1st Qu.: -18.49   1st Qu.: -40.89   1st Qu.: -77.644  
##  Median :  48.17   Median : -20.96   Median :  -3.324  
##  Mean   :  23.84   Mean   : -10.78   Mean   :   1.674  
##  3rd Qu.:  67.61   3rd Qu.:  17.50   3rd Qu.:  79.643  
##  Max.   : 153.55   Max.   : 149.40   Max.   : 154.952  
##                                                        
##  kurtosis_roll_dumbbell kurtosis_picth_dumbbell kurtosis_yaw_dumbbell
##  Length:19622           Length:19622            Length:19622         
##  Class :character       Class :character        Class :character     
##  Mode  :character       Mode  :character        Mode  :character     
##                                                                      
##                                                                      
##                                                                      
##                                                                      
##  skewness_roll_dumbbell skewness_pitch_dumbbell skewness_yaw_dumbbell
##  Length:19622           Length:19622            Length:19622         
##  Class :character       Class :character        Class :character     
##  Mode  :character       Mode  :character        Mode  :character     
##                                                                      
##                                                                      
##                                                                      
##                                                                      
##  max_roll_dumbbell max_picth_dumbbell max_yaw_dumbbell   min_roll_dumbbell
##  Min.   :-70.10    Min.   :-112.90    Length:19622       Min.   :-149.60  
##  1st Qu.:-27.15    1st Qu.: -66.70    Class :character   1st Qu.: -59.67  
##  Median : 14.85    Median :  40.05    Mode  :character   Median : -43.55  
##  Mean   : 13.76    Mean   :  32.75                       Mean   : -41.24  
##  3rd Qu.: 50.58    3rd Qu.: 133.22                       3rd Qu.: -25.20  
##  Max.   :137.00    Max.   : 155.00                       Max.   :  73.20  
##  NA's   :19216     NA's   :19216                         NA's   :19216    
##  min_pitch_dumbbell min_yaw_dumbbell   amplitude_roll_dumbbell
##  Min.   :-147.00    Length:19622       Min.   :  0.00         
##  1st Qu.: -91.80    Class :character   1st Qu.: 14.97         
##  Median : -66.15    Mode  :character   Median : 35.05         
##  Mean   : -33.18                       Mean   : 55.00         
##  3rd Qu.:  21.20                       3rd Qu.: 81.04         
##  Max.   : 120.90                       Max.   :256.48         
##  NA's   :19216                         NA's   :19216          
##  amplitude_pitch_dumbbell amplitude_yaw_dumbbell total_accel_dumbbell
##  Min.   :  0.00           Length:19622           Min.   : 0.00       
##  1st Qu.: 17.06           Class :character       1st Qu.: 4.00       
##  Median : 41.73           Mode  :character       Median :10.00       
##  Mean   : 65.93                                  Mean   :13.72       
##  3rd Qu.: 99.55                                  3rd Qu.:19.00       
##  Max.   :273.59                                  Max.   :58.00       
##  NA's   :19216                                                       
##  var_accel_dumbbell avg_roll_dumbbell stddev_roll_dumbbell
##  Min.   :  0.000    Min.   :-128.96   Min.   :  0.000     
##  1st Qu.:  0.378    1st Qu.: -12.33   1st Qu.:  4.639     
##  Median :  1.000    Median :  48.23   Median : 12.204     
##  Mean   :  4.388    Mean   :  23.86   Mean   : 20.761     
##  3rd Qu.:  3.434    3rd Qu.:  64.37   3rd Qu.: 26.356     
##  Max.   :230.428    Max.   : 125.99   Max.   :123.778     
##  NA's   :19216      NA's   :19216     NA's   :19216       
##  var_roll_dumbbell  avg_pitch_dumbbell stddev_pitch_dumbbell
##  Min.   :    0.00   Min.   :-70.73     Min.   : 0.000       
##  1st Qu.:   21.52   1st Qu.:-42.00     1st Qu.: 3.482       
##  Median :  148.95   Median :-19.91     Median : 8.089       
##  Mean   : 1020.27   Mean   :-12.33     Mean   :13.147       
##  3rd Qu.:  694.65   3rd Qu.: 13.21     3rd Qu.:19.238       
##  Max.   :15321.01   Max.   : 94.28     Max.   :82.680       
##  NA's   :19216      NA's   :19216      NA's   :19216        
##  var_pitch_dumbbell avg_yaw_dumbbell   stddev_yaw_dumbbell
##  Min.   :   0.00    Min.   :-117.950   Min.   :  0.000    
##  1st Qu.:  12.12    1st Qu.: -76.696   1st Qu.:  3.885    
##  Median :  65.44    Median :  -4.505   Median : 10.264    
##  Mean   : 350.31    Mean   :   0.202   Mean   : 16.647    
##  3rd Qu.: 370.11    3rd Qu.:  71.234   3rd Qu.: 24.674    
##  Max.   :6836.02    Max.   : 134.905   Max.   :107.088    
##  NA's   :19216      NA's   :19216      NA's   :19216      
##  var_yaw_dumbbell   gyros_dumbbell_x    gyros_dumbbell_y  
##  Min.   :    0.00   Min.   :-204.0000   Min.   :-2.10000  
##  1st Qu.:   15.09   1st Qu.:  -0.0300   1st Qu.:-0.14000  
##  Median :  105.35   Median :   0.1300   Median : 0.03000  
##  Mean   :  589.84   Mean   :   0.1611   Mean   : 0.04606  
##  3rd Qu.:  608.79   3rd Qu.:   0.3500   3rd Qu.: 0.21000  
##  Max.   :11467.91   Max.   :   2.2200   Max.   :52.00000  
##  NA's   :19216                                            
##  gyros_dumbbell_z  accel_dumbbell_x  accel_dumbbell_y  accel_dumbbell_z 
##  Min.   : -2.380   Min.   :-419.00   Min.   :-189.00   Min.   :-334.00  
##  1st Qu.: -0.310   1st Qu.: -50.00   1st Qu.:  -8.00   1st Qu.:-142.00  
##  Median : -0.130   Median :  -8.00   Median :  41.50   Median :  -1.00  
##  Mean   : -0.129   Mean   : -28.62   Mean   :  52.63   Mean   : -38.32  
##  3rd Qu.:  0.030   3rd Qu.:  11.00   3rd Qu.: 111.00   3rd Qu.:  38.00  
##  Max.   :317.000   Max.   : 235.00   Max.   : 315.00   Max.   : 318.00  
##                                                                         
##  magnet_dumbbell_x magnet_dumbbell_y magnet_dumbbell_z  roll_forearm      
##  Min.   :-643.0    Min.   :-3600     Min.   :-262.00   Min.   :-180.0000  
##  1st Qu.:-535.0    1st Qu.:  231     1st Qu.: -45.00   1st Qu.:  -0.7375  
##  Median :-479.0    Median :  311     Median :  13.00   Median :  21.7000  
##  Mean   :-328.5    Mean   :  221     Mean   :  46.05   Mean   :  33.8265  
##  3rd Qu.:-304.0    3rd Qu.:  390     3rd Qu.:  95.00   3rd Qu.: 140.0000  
##  Max.   : 592.0    Max.   :  633     Max.   : 452.00   Max.   : 180.0000  
##                                                                           
##  pitch_forearm     yaw_forearm      kurtosis_roll_forearm
##  Min.   :-72.50   Min.   :-180.00   Length:19622         
##  1st Qu.:  0.00   1st Qu.: -68.60   Class :character     
##  Median :  9.24   Median :   0.00   Mode  :character     
##  Mean   : 10.71   Mean   :  19.21                        
##  3rd Qu.: 28.40   3rd Qu.: 110.00                        
##  Max.   : 89.80   Max.   : 180.00                        
##                                                          
##  kurtosis_picth_forearm kurtosis_yaw_forearm skewness_roll_forearm
##  Length:19622           Length:19622         Length:19622         
##  Class :character       Class :character     Class :character     
##  Mode  :character       Mode  :character     Mode  :character     
##                                                                   
##                                                                   
##                                                                   
##                                                                   
##  skewness_pitch_forearm skewness_yaw_forearm max_roll_forearm
##  Length:19622           Length:19622         Min.   :-66.60  
##  Class :character       Class :character     1st Qu.:  0.00  
##  Mode  :character       Mode  :character     Median : 26.80  
##                                              Mean   : 24.49  
##                                              3rd Qu.: 45.95  
##                                              Max.   : 89.80  
##                                              NA's   :19216   
##  max_picth_forearm max_yaw_forearm    min_roll_forearm  min_pitch_forearm
##  Min.   :-151.00   Length:19622       Min.   :-72.500   Min.   :-180.00  
##  1st Qu.:   0.00   Class :character   1st Qu.: -6.075   1st Qu.:-175.00  
##  Median : 113.00   Mode  :character   Median :  0.000   Median : -61.00  
##  Mean   :  81.49                      Mean   : -0.167   Mean   : -57.57  
##  3rd Qu.: 174.75                      3rd Qu.: 12.075   3rd Qu.:   0.00  
##  Max.   : 180.00                      Max.   : 62.100   Max.   : 167.00  
##  NA's   :19216                        NA's   :19216     NA's   :19216    
##  min_yaw_forearm    amplitude_roll_forearm amplitude_pitch_forearm
##  Length:19622       Min.   :  0.000        Min.   :  0.0          
##  Class :character   1st Qu.:  1.125        1st Qu.:  2.0          
##  Mode  :character   Median : 17.770        Median : 83.7          
##                     Mean   : 24.653        Mean   :139.1          
##                     3rd Qu.: 39.875        3rd Qu.:350.0          
##                     Max.   :126.000        Max.   :360.0          
##                     NA's   :19216          NA's   :19216          
##  amplitude_yaw_forearm total_accel_forearm var_accel_forearm
##  Length:19622          Min.   :  0.00      Min.   :  0.000  
##  Class :character      1st Qu.: 29.00      1st Qu.:  6.759  
##  Mode  :character      Median : 36.00      Median : 21.165  
##                        Mean   : 34.72      Mean   : 33.502  
##                        3rd Qu.: 41.00      3rd Qu.: 51.240  
##                        Max.   :108.00      Max.   :172.606  
##                                            NA's   :19216    
##  avg_roll_forearm   stddev_roll_forearm var_roll_forearm  
##  Min.   :-177.234   Min.   :  0.000     Min.   :    0.00  
##  1st Qu.:  -0.909   1st Qu.:  0.428     1st Qu.:    0.18  
##  Median :  11.172   Median :  8.030     Median :   64.48  
##  Mean   :  33.165   Mean   : 41.986     Mean   : 5274.10  
##  3rd Qu.: 107.132   3rd Qu.: 85.373     3rd Qu.: 7289.08  
##  Max.   : 177.256   Max.   :179.171     Max.   :32102.24  
##  NA's   :19216      NA's   :19216       NA's   :19216     
##  avg_pitch_forearm stddev_pitch_forearm var_pitch_forearm 
##  Min.   :-68.17    Min.   : 0.000       Min.   :   0.000  
##  1st Qu.:  0.00    1st Qu.: 0.336       1st Qu.:   0.113  
##  Median : 12.02    Median : 5.516       Median :  30.425  
##  Mean   : 11.79    Mean   : 7.977       Mean   : 139.593  
##  3rd Qu.: 28.48    3rd Qu.:12.866       3rd Qu.: 165.532  
##  Max.   : 72.09    Max.   :47.745       Max.   :2279.617  
##  NA's   :19216     NA's   :19216        NA's   :19216     
##  avg_yaw_forearm   stddev_yaw_forearm var_yaw_forearm    gyros_forearm_x  
##  Min.   :-155.06   Min.   :  0.000    Min.   :    0.00   Min.   :-22.000  
##  1st Qu.: -26.26   1st Qu.:  0.524    1st Qu.:    0.27   1st Qu.: -0.220  
##  Median :   0.00   Median : 24.743    Median :  612.21   Median :  0.050  
##  Mean   :  18.00   Mean   : 44.854    Mean   : 4639.85   Mean   :  0.158  
##  3rd Qu.:  85.79   3rd Qu.: 85.817    3rd Qu.: 7368.41   3rd Qu.:  0.560  
##  Max.   : 169.24   Max.   :197.508    Max.   :39009.33   Max.   :  3.970  
##  NA's   :19216     NA's   :19216      NA's   :19216                       
##  gyros_forearm_y     gyros_forearm_z    accel_forearm_x   accel_forearm_y 
##  Min.   : -7.02000   Min.   : -8.0900   Min.   :-498.00   Min.   :-632.0  
##  1st Qu.: -1.46000   1st Qu.: -0.1800   1st Qu.:-178.00   1st Qu.:  57.0  
##  Median :  0.03000   Median :  0.0800   Median : -57.00   Median : 201.0  
##  Mean   :  0.07517   Mean   :  0.1512   Mean   : -61.65   Mean   : 163.7  
##  3rd Qu.:  1.62000   3rd Qu.:  0.4900   3rd Qu.:  76.00   3rd Qu.: 312.0  
##  Max.   :311.00000   Max.   :231.0000   Max.   : 477.00   Max.   : 923.0  
##                                                                           
##  accel_forearm_z   magnet_forearm_x  magnet_forearm_y magnet_forearm_z  
##  Min.   :-446.00   Min.   :-1280.0   Min.   :-896.0   Length:19622      
##  1st Qu.:-182.00   1st Qu.: -616.0   1st Qu.:   2.0   Class :character  
##  Median : -39.00   Median : -378.0   Median : 591.0   Mode  :character  
##  Mean   : -55.29   Mean   : -312.6   Mean   : 380.1                     
##  3rd Qu.:  26.00   3rd Qu.:  -73.0   3rd Qu.: 737.0                     
##  Max.   : 291.00   Max.   :  672.0   Max.   :1480.0                     
##                                                                         
##     classe         
##  Length:19622      
##  Class :character  
##  Mode  :character  
##                    
##                    
##                    
## 
```

## Data cleaning

Let's use only numeric variables for building our prediction model:

```r
data_columns <- sapply(data, is.numeric)
data_columns['classe'] = TRUE
data <- data[data_columns]
data$classe <- as.factor(data$classe)

dim(data)
```

```
## [1] 19622   120
```

## Data slicing


```r
library(caret)
train_data_index <- createDataPartition(y=data$classe, p = 0.7, list=FALSE)
train_data <- data[train_data_index,]
test_data <- data[-train_data_index,]

dim(train_data)
```

```
## [1] 13737   120
```

```r
dim(test_data)
```

```
## [1] 5885  120
```

## Data preprocessing

As we have lot's of NA values let's impute them using K-Nearest Neighbour method:

```r
preprocess_data <- train_data[,-120]
imputed_data <- predict(preProcess(preprocess_data, method="knnImpute"), preprocess_data)

head(imputed_data)
```

```
##   num_window roll_belt pitch_belt   yaw_belt total_accel_belt max_roll_belt max_picth_belt min_roll_belt min_pitch_belt amplitude_roll_belt amplitude_pitch_belt
## 1  -1.690008 -1.006576  0.3480126 -0.8753465        -1.074412    -0.8950059      -1.122617    -0.8585801     -0.9706869          -0.1446679           -0.7685509
## 2  -1.690008 -1.006576  0.3480126 -0.8753465        -1.074412    -0.8950059      -1.122617    -0.8585801     -0.9706869          -0.1446679           -0.7685509
## 5  -1.685983 -1.005460  0.3480126 -0.8753465        -1.074412    -0.8950059      -1.122617    -0.8585801     -0.9706869          -0.1446679           -0.7685509
## 7  -1.685983 -1.006416  0.3489046 -0.8753465        -1.074412    -0.8950059      -1.122617    -0.8585801     -0.9706869          -0.1446679           -0.7685509
## 8  -1.685983 -1.006416  0.3506885 -0.8753465        -1.074412    -0.8950059      -1.122617    -0.8585801     -0.9706869          -0.1446679           -0.7685509
## 9  -1.685983 -1.006257  0.3520265 -0.8753465        -1.074412    -0.8950059      -1.122617    -0.8585801     -0.9706869          -0.1446679           -0.7685509
##   var_total_accel_belt avg_roll_belt stddev_roll_belt var_roll_belt avg_pitch_belt stddev_pitch_belt var_pitch_belt avg_yaw_belt stddev_yaw_belt var_yaw_belt
## 1           -0.3899523     -1.050573       -0.5265916    -0.3334814      0.2721774        -0.7578951      -0.420775   -0.8813024      -0.1312001  -0.07880739
## 2           -0.3899523     -1.050573       -0.5265916    -0.3334814      0.2721774        -0.7578951      -0.420775   -0.8813024      -0.1312001  -0.07880739
## 5           -0.3899523     -1.050573       -0.5265916    -0.3334814      0.2721774        -0.7578951      -0.420775   -0.8813024      -0.1312001  -0.07880739
## 7           -0.3899523     -1.050573       -0.5265916    -0.3334814      0.2721774        -0.7578951      -0.420775   -0.8813024      -0.1312001  -0.07880739
## 8           -0.3899523     -1.050573       -0.5265916    -0.3334814      0.2721774        -0.7578951      -0.420775   -0.8813024      -0.1312001  -0.07880739
## 9           -0.3899523     -1.050573       -0.5265916    -0.3334814      0.2721774        -0.7578951      -0.420775   -0.8813024      -0.1312001  -0.07880739
##   gyros_belt_x gyros_belt_y gyros_belt_z accel_belt_x accel_belt_y accel_belt_z magnet_belt_x magnet_belt_y magnet_belt_z  roll_arm pitch_arm   yaw_arm total_accel_arm
## 1   0.03263543   -0.5069318    0.4597325   -0.5179062   -0.9185765    0.9449887    -0.9108852     0.1561814     0.5000874 -2.012381 0.8800663 -2.248578       0.8218532
## 2   0.12918177   -0.5069318    0.4597325   -0.5515426   -0.9185765    0.9449887    -0.9729618     0.4052710     0.5305994 -2.012381 0.8800663 -2.248578       0.8218532
## 5   0.12918177   -0.2507242    0.4597325   -0.5179062   -0.9885746    0.9649070    -0.9574426     0.1838580     0.6679037 -2.012381 0.8670513 -2.248578       0.8218532
## 7   0.12918177   -0.5069318    0.4597325   -0.5515426   -0.9535755    0.9350296    -0.9264044     0.1561814     0.5305994 -2.012381 0.8605438 -2.248578       0.8218532
## 8   0.12918177   -0.5069318    0.4597325   -0.5515426   -0.9185765    0.9350296    -0.8953661     0.2668879     0.5000874 -2.012381 0.8572900 -2.248578       0.8218532
## 9   0.12918177   -0.5069318    0.4597325   -0.4842697   -0.9885746    0.9649070    -0.8488087     0.2392113     0.5153434 -2.012381 0.8540362 -2.248578       0.8218532
##   var_accel_arm avg_roll_arm stddev_roll_arm var_roll_arm avg_pitch_arm stddev_pitch_arm var_pitch_arm avg_yaw_arm stddev_yaw_arm var_yaw_arm gyros_arm_x gyros_arm_y
## 1    -0.9765807    -1.374191      -0.5792468   -0.2124852      0.659491         -1.06846    -0.6571461   -1.712027     -0.9810791   -0.449516 -0.03329546   0.3128213
## 2    -0.9765807    -1.374191      -0.5792468   -0.2124852      0.659491         -1.06846    -0.6571461   -1.712027     -0.9810791   -0.449516 -0.02325794   0.2894085
## 5    -0.9765807    -1.374191      -0.5792468   -0.2124852      0.659491         -1.06846    -0.6571461   -1.712027     -0.9810791   -0.449516 -0.03329546   0.2777021
## 7    -0.9765807    -1.374191      -0.5792468   -0.2124852      0.659491         -1.06846    -0.6571461   -1.712027     -0.9810791   -0.449516 -0.03329546   0.2777021
## 8    -0.9765807    -1.374191      -0.5792468   -0.2124852      0.659491         -1.06846    -0.6571461   -1.712027     -0.9810791   -0.449516 -0.02325794   0.2894085
## 9    -0.9765807    -1.374191      -0.5792468   -0.2124852      0.659491         -1.06846    -0.6571461   -1.712027     -0.9810791   -0.449516 -0.02325794   0.2777021
##   gyros_arm_z accel_arm_x accel_arm_y accel_arm_z magnet_arm_x magnet_arm_y magnet_arm_z max_roll_arm max_picth_arm max_yaw_arm min_roll_arm min_pitch_arm min_yaw_arm
## 1  -0.5261982   -1.253614   0.6921101  -0.3981152    -1.261033    0.8930634    0.6380993   0.07692282     -2.002049   0.1443035     1.202068     -1.136242    2.253408
## 2  -0.5261982   -1.264632   0.7011935  -0.4131204    -1.263286    0.8930634    0.6288494   0.07692282     -2.002049   0.1443035     1.202068     -1.136242    2.253408
## 5  -0.4900583   -1.259123   0.7102769  -0.3981152    -1.274552    0.8930634    0.6072664   0.07692282     -2.002049   0.1443035     1.202068     -1.136242    2.253408
## 7  -0.4900583   -1.259123   0.7102769  -0.4131204    -1.272299    0.8880867    0.6165163   0.07692282     -2.002049   0.1443035     1.202068     -1.136242    2.253408
## 8  -0.4900583   -1.259123   0.7102769  -0.4056178    -1.270046    0.8980402    0.6195996   0.07692282     -2.002049   0.1443035     1.202068     -1.136242    2.253408
## 9  -0.5261982   -1.253614   0.6921101  -0.3906126    -1.263286    0.9129703    0.6442658   0.07692282     -2.002049   0.1443035     1.202068     -1.136242    2.253408
##   amplitude_roll_arm amplitude_pitch_arm amplitude_yaw_arm roll_dumbbell pitch_dumbbell yaw_dumbbell max_roll_dumbbell max_picth_dumbbell min_roll_dumbbell
## 1          -1.151796           -1.044232         -1.600823    -0.1480144      -1.618997    -1.046500         -1.552585          -1.232908        -0.6750437
## 2          -1.151796           -1.044232         -1.600823    -0.1468933      -1.622887    -1.044524         -1.552585          -1.232908        -0.6750437
## 5          -1.151796           -1.044232         -1.600823    -0.1433549      -1.617223    -1.046247         -1.552585          -1.232908        -0.6750437
## 7          -1.151796           -1.044232         -1.600823    -0.1469474      -1.612316    -1.049232         -1.552585          -1.232908        -0.6750437
## 8          -1.151796           -1.044232         -1.600823    -0.1523143      -1.615030    -1.049201         -1.552585          -1.232908        -0.6750437
## 9          -1.151796           -1.044232         -1.600823    -0.1465524      -1.617132    -1.047005         -1.552585          -1.232908        -0.6750437
##   min_pitch_dumbbell amplitude_roll_dumbbell amplitude_pitch_dumbbell total_accel_dumbbell var_accel_dumbbell avg_roll_dumbbell stddev_roll_dumbbell var_roll_dumbbell
## 1         -0.7259633              -0.9603134               -0.9692617             2.274545          -0.497543        0.03508663           -0.8035312        -0.4358817
## 2         -0.7259633              -0.9603134               -0.9692617             2.274545          -0.497543        0.03508663           -0.8035312        -0.4358817
## 5         -0.7259633              -0.9603134               -0.9692617             2.274545          -0.497543        0.03508663           -0.8035312        -0.4358817
## 7         -0.7259633              -0.9603134               -0.9692617             2.274545          -0.497543        0.03508663           -0.8035312        -0.4358817
## 8         -0.7259633              -0.9603134               -0.9692617             2.274545          -0.497543        0.03508663           -0.8035312        -0.4358817
## 9         -0.7259633              -0.9603134               -0.9692617             2.274545          -0.497543        0.03508663           -0.8035312        -0.4358817
##   avg_pitch_dumbbell stddev_pitch_dumbbell var_pitch_dumbbell avg_yaw_dumbbell stddev_yaw_dumbbell var_yaw_dumbbell gyros_dumbbell_x gyros_dumbbell_y gyros_dumbbell_z
## 1          -1.524988            -0.9483979         -0.4890391        -1.081046          -0.9035923       -0.4699165       -0.0874465       -0.1006046       0.04406856
## 2          -1.524988            -0.9483979         -0.4890391        -1.081046          -0.9035923       -0.4699165       -0.0874465       -0.1006046       0.04406856
## 5          -1.524988            -0.9483979         -0.4890391        -1.081046          -0.9035923       -0.4699165       -0.0874465       -0.1006046       0.04406856
## 7          -1.524988            -0.9483979         -0.4890391        -1.081046          -0.9035923       -0.4699165       -0.0874465       -0.1006046       0.04406856
## 8          -1.524988            -0.9483979         -0.4890391        -1.081046          -0.9035923       -0.4699165       -0.0874465       -0.1006046       0.04406856
## 9          -1.524988            -0.9483979         -0.4890391        -1.081046          -0.9035923       -0.4699165       -0.0874465       -0.1006046       0.04406856
##   accel_dumbbell_x accel_dumbbell_y accel_dumbbell_z magnet_dumbbell_x magnet_dumbbell_y magnet_dumbbell_z roll_forearm pitch_forearm yaw_forearm max_roll_forearm
## 1        -3.044815      -0.06414950        -2.122647        -0.6770659         0.2250387        -0.7948016  -0.05146125     -2.650588   -1.668160        -2.819957
## 2        -3.029981      -0.06414950        -2.104433        -0.6653251         0.2341784        -0.7876300  -0.05238741     -2.650588   -1.668160        -2.819957
## 5        -3.029981      -0.05174300        -2.113540        -0.6623899         0.2219921        -0.8163166  -0.05516590     -2.650588   -1.658464        -2.819957
## 7        -3.015147      -0.06414950        -2.113540        -0.6535844         0.2311318        -0.8306599  -0.05609207     -2.650588   -1.658464        -2.819957
## 8        -3.044815      -0.07655601        -2.131755        -0.6653251         0.2463647        -0.8593465  -0.05701823     -2.647037   -1.658464        -2.819957
## 9        -3.015147      -0.06414950        -2.104433        -0.6477140         0.2219921        -0.7948016  -0.05794439     -2.647037   -1.658464        -2.819957
##   max_picth_forearm min_roll_forearm min_pitch_forearm amplitude_roll_forearm amplitude_pitch_forearm total_accel_forearm var_accel_forearm avg_roll_forearm
## 1         -1.178562        -2.865854         0.2699387             -0.9428944              -0.9288648           0.1298356        -0.9682201       0.01273296
## 2         -1.178562        -2.865854         0.2699387             -0.9428944              -0.9288648           0.1298356        -0.9682201       0.01273296
## 5         -1.178562        -2.865854         0.2699387             -0.9428944              -0.9288648           0.1298356        -0.9682201       0.01273296
## 7         -1.178562        -2.865854         0.2699387             -0.9428944              -0.9288648           0.1298356        -0.9682201       0.01273296
## 8         -1.178562        -2.865854         0.2699387             -0.9428944              -0.9288648           0.1298356        -0.9682201       0.01273296
## 9         -1.178562        -2.865854         0.2699387             -0.9428944              -0.9288648           0.1298356        -0.9682201       0.01273296
##   stddev_roll_forearm var_roll_forearm avg_pitch_forearm stddev_pitch_forearm var_pitch_forearm avg_yaw_forearm stddev_yaw_forearm var_yaw_forearm gyros_forearm_x
## 1          -0.7196721       -0.6016844          -3.00881           -0.9148218        -0.5571281      -0.6084538         -0.8635243      -0.6503828      -0.1997886
## 2          -0.7196721       -0.6016844          -3.00881           -0.9148218        -0.5571281      -0.6084538         -0.8635243      -0.6503828      -0.2149798
## 5          -0.7196721       -0.6016844          -3.00881           -0.9148218        -0.5571281      -0.6084538         -0.8635243      -0.6503828      -0.2149798
## 7          -0.7196721       -0.6016844          -3.00881           -0.9148218        -0.5571281      -0.6084538         -0.8635243      -0.6503828      -0.2149798
## 8          -0.7196721       -0.6016844          -3.00881           -0.9148218        -0.5571281      -0.6084538         -0.8635243      -0.6503828      -0.2149798
## 9          -0.7196721       -0.6016844          -3.00881           -0.9148218        -0.5571281      -0.6084538         -0.8635243      -0.6503828      -0.1997886
##   gyros_forearm_y gyros_forearm_z accel_forearm_x accel_forearm_y accel_forearm_z magnet_forearm_x magnet_forearm_y
## 1     -0.02383931     -0.08545522        1.406708       0.1892283       -1.151046        0.8558533        0.5337368
## 2     -0.02383931     -0.08545522        1.406708       0.1892283       -1.158270        0.8529655        0.5475819
## 5     -0.02383931     -0.08545522        1.390039       0.2043047       -1.143821        0.8558533        0.5357147
## 7     -0.02383931     -0.08545522        1.423378       0.1992792       -1.151046        0.8529655        0.5436262
## 8     -0.02967525     -0.07575314        1.412265       0.1992792       -1.136597        0.8789555        0.5456040
## 9     -0.02383931     -0.08545522        1.412265       0.1942537       -1.143821        0.8587411        0.5317590
```

```r
summary(imputed_data)
```

```
##    num_window         roll_belt         pitch_belt          yaw_belt        total_accel_belt  max_roll_belt      max_picth_belt    min_roll_belt       min_pitch_belt    
##  Min.   :-1.73026   Min.   :-1.4882   Min.   :-2.43805   Min.   :-1.77223   Min.   :-1.4615   Min.   :-0.92305   Min.   :-1.2211   Min.   :-1.800420   Min.   :-1.42168  
##  1st Qu.:-0.85269   1st Qu.:-1.0114   1st Qu.: 0.06481   1st Qu.:-0.81143   1st Qu.:-1.0744   1st Qu.:-0.85789   1st Qu.:-1.1226   1st Qu.:-0.823784   1st Qu.:-1.07680  
##  Median :-0.03148   Median : 0.7882   Median : 0.22447   Median :-0.01827   Median : 0.7319   Median :-0.01097   Median : 0.6001   Median : 0.008117   Median : 0.80675  
##  Mean   : 0.00000   Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.0000   Mean   :-0.04140   Mean   :-0.1173   Mean   :-0.015184   Mean   :-0.03887  
##  3rd Qu.: 0.86622   3rd Qu.: 0.9317   3rd Qu.: 0.65262   3rd Qu.: 0.25833   3rd Qu.: 0.8610   3rd Qu.: 0.15499   3rd Qu.: 0.7232   3rd Qu.: 0.176974   3rd Qu.: 0.85981  
##  Max.   : 1.74379   Max.   : 1.5534   Max.   : 2.67739   Max.   : 1.98924   Max.   : 2.2802   Max.   : 1.96924   Max.   : 2.1014   Max.   : 1.967366   Max.   : 1.62915  
##  amplitude_roll_belt amplitude_pitch_belt var_total_accel_belt avg_roll_belt      stddev_roll_belt  var_roll_belt     avg_pitch_belt    stddev_pitch_belt 
##  Min.   :-0.14858    Min.   :-0.9389      Min.   :-0.4166      Min.   :-1.49866   Min.   :-0.5600   Min.   :-0.3335   Min.   :-2.2993   Min.   :-0.93687  
##  1st Qu.:-0.13555    1st Qu.:-0.5131      1st Qu.:-0.3545      1st Qu.:-1.05026   1st Qu.:-0.4597   1st Qu.:-0.3308   1st Qu.: 0.1154   1st Qu.:-0.54909  
##  Median :-0.11320    Median :-0.4279      Median :-0.3367      Median : 0.73425   Median :-0.4095   Median :-0.3261   Median : 0.2111   Median :-0.37011  
##  Mean   :-0.08156    Mean   :-0.2812      Mean   :-0.2056      Mean   :-0.06109   Mean   :-0.2497   Mean   :-0.1860   Mean   : 0.0026   Mean   :-0.23914  
##  3rd Qu.:-0.08460    3rd Qu.:-0.1725      3rd Qu.:-0.2835      3rd Qu.: 0.88508   3rd Qu.:-0.2757   3rd Qu.:-0.3059   3rd Qu.: 0.6398   3rd Qu.:-0.07181  
##  Max.   :11.57825    Max.   : 4.1703      Max.   : 6.9004      Max.   : 1.40481   Max.   : 5.3787   Max.   : 8.5996   Max.   : 2.6213   Max.   : 5.02910  
##  var_pitch_belt     avg_yaw_belt       stddev_yaw_belt     var_yaw_belt       gyros_belt_x      gyros_belt_y      gyros_belt_z      accel_belt_x       accel_belt_y    
##  Min.   :-0.4311   Min.   :-1.380327   Min.   :-0.13280   Min.   :-0.07881   Min.   :-4.7947   Min.   :-7.2964   Min.   :-5.5250   Min.   :-3.84791   Min.   :-3.4735  
##  1st Qu.:-0.3899   1st Qu.:-0.844663   1st Qu.:-0.12322   1st Qu.:-0.07880   1st Qu.:-0.1122   1st Qu.:-0.5069   1st Qu.:-0.2884   1st Qu.:-0.51791   1st Qu.:-0.9536  
##  Median :-0.3281   Median : 0.005758   Median :-0.10565   Median :-0.07874   Median : 0.1775   Median :-0.2507   Median : 0.1272   Median :-0.31609   Median : 0.2014  
##  Mean   :-0.1890   Mean   :-0.024274   Mean   :-0.07241   Mean   :-0.05151   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000  
##  3rd Qu.:-0.1636   3rd Qu.: 0.171386   3rd Qu.:-0.08329   3rd Qu.:-0.07847   3rd Qu.: 0.5636   3rd Qu.: 0.9022   3rd Qu.: 0.4597   3rd Qu.: 0.02028   3rd Qu.: 1.0764  
##  Max.   : 7.9117   Max.   : 1.960077   Max.   :13.96813   Max.   :15.37298   Max.   : 9.7838   Max.   : 7.6917   Max.   : 7.2757   Max.   : 3.04756   Max.   : 4.6813  
##   accel_belt_z     magnet_belt_x      magnet_belt_y     magnet_belt_z        roll_arm         pitch_arm          yaw_arm           total_accel_arm    var_accel_arm    
##  Min.   :-2.0129   Min.   :-1.62477   Min.   :-6.6246   Min.   :-4.1988   Min.   :-2.7294   Min.   :-2.7056   Min.   :-2.5140224   Min.   :-2.33095   Min.   :-0.9819  
##  1st Qu.:-0.8875   1st Qu.:-0.72466   1st Qu.:-0.3420   1st Qu.:-0.4458   1st Qu.:-0.6777   1st Qu.:-0.6947   1st Qu.:-0.5888536   1st Qu.:-0.80232   1st Qu.:-0.4517  
##  Median :-0.7979   Median :-0.32116   Median : 0.2115   Median : 0.3933   Median :-0.2475   Median : 0.1480   Median : 0.0007119   Median : 0.05754   Median :-0.2273  
##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000000   Mean   : 0.00000   Mean   :-0.1278  
##  3rd Qu.: 0.9948   3rd Qu.: 0.06682   3rd Qu.: 0.4606   3rd Qu.: 0.6069   3rd Qu.: 0.8169   3rd Qu.: 0.5124   3rd Qu.: 0.6615283   3rd Qu.: 0.63077   3rd Qu.: 0.1280  
##  Max.   : 1.7716   Max.   : 6.52278   Max.   : 2.2043   Max.   : 9.6842   Max.   : 2.2343   Max.   : 3.0275   Max.   : 2.5154463   Max.   : 3.78357   Max.   : 3.8892  
##   avg_roll_arm      stddev_roll_arm     var_roll_arm      avg_pitch_arm       stddev_pitch_arm   var_pitch_arm       avg_yaw_arm       stddev_yaw_arm    
##  Min.   :-2.69708   Min.   :-0.59346   Min.   :-0.21254   Min.   :-2.872897   Min.   :-1.09598   Min.   :-0.65753   Min.   :-2.79122   Min.   :-0.98575  
##  1st Qu.:-0.51703   1st Qu.:-0.36265   1st Qu.:-0.20208   1st Qu.:-0.413899   1st Qu.:-0.42580   1st Qu.:-0.48111   1st Qu.:-0.65981   1st Qu.:-0.52900  
##  Median :-0.21627   Median :-0.22473   Median :-0.18189   Median : 0.040869   Median : 0.10106   Median :-0.10800   Median :-0.10494   Median :-0.10869  
##  Mean   : 0.03989   Mean   :-0.07855   Mean   :-0.06163   Mean   :-0.008103   Mean   : 0.04822   Mean   : 0.03105   Mean   :-0.05506   Mean   :-0.09008  
##  3rd Qu.: 0.94861   3rd Qu.: 0.14755   3rd Qu.:-0.08695   3rd Qu.: 0.244315   3rd Qu.: 0.60912   3rd Qu.: 0.41676   3rd Qu.: 0.56446   3rd Qu.: 0.36696  
##  Max.   : 2.21492   Max.   : 7.68101   Max.   :10.57836   Max.   : 2.868090   Max.   : 3.48356   Max.   : 5.61768   Max.   : 2.41553   Max.   : 6.68461  
##   var_yaw_arm        gyros_arm_x        gyros_arm_y         gyros_arm_z        accel_arm_x        accel_arm_y       accel_arm_z       magnet_arm_x      magnet_arm_y    
##  Min.   :-0.44954   Min.   :-3.23025   Min.   :-3.667349   Min.   :-4.61000   Min.   :-1.77695   Min.   :-3.1593   Min.   :-4.2019   Min.   :-1.7477   Min.   :-2.7350  
##  1st Qu.:-0.38538   1st Qu.:-0.67570   1st Qu.:-0.623689   1st Qu.:-0.61655   1st Qu.:-1.00021   1st Qu.:-0.7976   1st Qu.:-0.5332   1st Qu.:-1.1056   1st Qu.:-0.8189  
##  Median :-0.21706   Median : 0.01689   Median : 0.008455   Median :-0.07445   Median : 0.09053   Median :-0.1617   Median : 0.1796   Median : 0.2239   Median : 0.2262  
##  Mean   :-0.10891   Mean   : 0.00000   Mean   : 0.000000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
##  3rd Qu.: 0.08514   3rd Qu.: 0.76469   3rd Qu.: 0.465004   3rd Qu.: 0.81098   3rd Qu.: 0.79014   3rd Qu.: 0.9737   3rd Qu.: 0.6973   3rd Qu.: 1.0035   3rd Qu.: 0.8234  
##  Max.   :12.98944   Max.   : 2.41084   Max.   : 3.637434   Max.   : 4.91285   Max.   : 2.72923   Max.   : 2.4997   Max.   : 2.7155   Max.   : 1.3302   Max.   : 2.1173  
##   magnet_arm_z      max_roll_arm      max_picth_arm       max_yaw_arm       min_roll_arm      min_pitch_arm        min_yaw_arm        amplitude_roll_arm
##  Min.   :-2.7720   Min.   :-3.15517   Min.   :-2.97265   Min.   :-2.9522   Min.   :-2.37438   Min.   :-2.530887   Min.   :-1.495152   Min.   :-1.18220  
##  1st Qu.:-0.5274   1st Qu.:-0.39441   1st Qu.:-0.64767   1st Qu.:-0.6585   1st Qu.:-0.62982   1st Qu.:-0.544107   1st Qu.:-0.574453   1st Qu.:-0.39032  
##  Median : 0.4223   Median :-0.07490   Median :-0.26746   Median :-0.1042   Median :-0.06179   Median :-0.001035   Median :-0.157946   Median : 0.15007  
##  Mean   : 0.0000   Mean   : 0.01025   Mean   :-0.08033   Mean   :-0.1363   Mean   :-0.02975   Mean   :-0.008438   Mean   : 0.005145   Mean   : 0.04016  
##  3rd Qu.: 0.7244   3rd Qu.: 0.37906   3rd Qu.: 0.72904   3rd Qu.: 0.3928   3rd Qu.: 0.77463   3rd Qu.: 0.493644   3rd Qu.: 0.324324   3rd Qu.: 0.59635  
##  Max.   : 1.1838   Max.   : 2.83467   Max.   : 2.10367   Max.   : 2.5910   Max.   : 3.04319   Max.   : 3.047691   Max.   : 2.560308   Max.   : 3.14310  
##  amplitude_pitch_arm amplitude_yaw_arm roll_dumbbell     pitch_dumbbell     yaw_dumbbell      max_roll_dumbbell  max_picth_dumbbell  min_roll_dumbbell 
##  Min.   :-1.04736    Min.   :-1.7017   Min.   :-2.5247   Min.   :-3.7634   Min.   :-1.84535   Min.   :-1.72131   Min.   :-1.543987   Min.   :-3.10218  
##  1st Qu.:-0.54855    1st Qu.:-0.4075   1st Qu.:-0.6125   1st Qu.:-0.8099   1st Qu.:-0.95976   1st Qu.:-0.76781   1st Qu.:-1.074051   1st Qu.:-0.42439  
##  Median :-0.09441    Median :-0.1218   Median : 0.3487   Median :-0.2741   Median :-0.07069   Median : 0.10153   Median : 0.247552   Median : 0.08875  
##  Mean   :-0.07642    Mean   :-0.1238   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.00000   Mean   :-0.06899   Mean   :-0.007879   Mean   : 0.06900  
##  3rd Qu.: 0.44094    3rd Qu.: 0.2648   3rd Qu.: 0.6249   3rd Qu.: 0.7584   3rd Qu.: 0.94479   3rd Qu.: 0.60687   3rd Qu.: 0.922377   3rd Qu.: 0.36588  
##  Max.   : 4.55914    Max.   : 2.6682   Max.   : 1.8543   Max.   : 4.3425   Max.   : 1.85642   Max.   : 2.50896   Max.   : 1.321663   Max.   : 3.17266  
##  min_pitch_dumbbell amplitude_roll_dumbbell amplitude_pitch_dumbbell total_accel_dumbbell var_accel_dumbbell avg_roll_dumbbell  stddev_roll_dumbbell var_roll_dumbbell 
##  Min.   :-1.52225   Min.   :-0.9895         Min.   :-0.99831         Min.   :-1.3393      Min.   :-0.51174   Min.   :-2.43433   Min.   :-0.81970     Min.   :-0.43596  
##  1st Qu.:-0.70396   1st Qu.:-0.7334         1st Qu.:-0.73179         1st Qu.:-0.9486      1st Qu.:-0.42902   1st Qu.:-0.61655   1st Qu.:-0.61075     1st Qu.:-0.42205  
##  Median :-0.05981   Median :-0.2762         Median :-0.29672         Median :-0.3626      Median :-0.34766   Median : 0.34394   Median :-0.28744     Median :-0.34538  
##  Mean   : 0.02638   Mean   :-0.1075         Mean   :-0.04205         Mean   : 0.0000      Mean   :-0.14325   Mean   :-0.02404   Mean   :-0.07963     Mean   :-0.05925  
##  3rd Qu.: 0.49604   3rd Qu.: 0.3956         3rd Qu.: 0.57921         3rd Qu.: 0.6141      3rd Qu.:-0.01654   3rd Qu.: 0.55536   3rd Qu.: 0.32705     3rd Qu.: 0.10184  
##  Max.   : 2.02314   Max.   : 3.7434         Max.   : 3.29813         Max.   : 4.3256      Max.   : 7.47222   Max.   : 1.61272   Max.   : 4.15939     Max.   : 6.04273  
##  avg_pitch_dumbbell stddev_pitch_dumbbell var_pitch_dumbbell avg_yaw_dumbbell    stddev_yaw_dumbbell var_yaw_dumbbell   gyros_dumbbell_x     gyros_dumbbell_y  
##  Min.   :-1.76743   Min.   :-0.9753       Min.   :-0.48924   Min.   :-1.507933   Min.   :-0.92641    Min.   :-0.47006   Min.   :-114.41239   Min.   :-3.26866  
##  1st Qu.:-0.56948   1st Qu.:-0.7300       1st Qu.:-0.47028   1st Qu.:-0.975709   1st Qu.:-0.70614    1st Qu.:-0.45643   1st Qu.:  -0.10426   1st Qu.:-0.28338  
##  Median :-0.12671   Median :-0.2689       Median :-0.30874   Median : 0.166506   Median :-0.28782    Median :-0.32505   Median :  -0.01459   Median :-0.02445  
##  Mean   :-0.01797   Mean   :-0.1219       Mean   :-0.09186   Mean   : 0.001791   Mean   :-0.05997    Mean   :-0.03976   Mean   :   0.00000   Mean   : 0.00000  
##  3rd Qu.: 0.72473   3rd Qu.: 0.3405       3rd Qu.: 0.11896   3rd Qu.: 0.725103   3rd Qu.: 0.51125    3rd Qu.: 0.26054   3rd Qu.:   0.10870   3rd Qu.: 0.24971  
##  Max.   : 3.14210   Max.   : 5.3447       Max.   : 9.54452   Max.   : 1.690737   Max.   : 4.81201    Max.   : 7.87627   Max.   :   1.15668   Max.   :79.13135  
##  gyros_dumbbell_z    accel_dumbbell_x  accel_dumbbell_y  accel_dumbbell_z  magnet_dumbbell_x  magnet_dumbbell_y  magnet_dumbbell_z  roll_forearm     pitch_forearm     
##  Min.   : -0.82935   Min.   :-5.7891   Min.   :-2.9921   Min.   :-2.6964   Min.   :-0.92362   Min.   :-11.6353   Min.   :-2.2076   Min.   :-1.9816   Min.   :-2.95598  
##  1st Qu.: -0.06970   1st Qu.:-0.3153   1st Qu.:-0.7589   1st Qu.:-0.9478   1st Qu.:-0.60956   1st Qu.:  0.0331   1st Qu.:-0.6514   1st Qu.:-0.3197   1st Qu.:-0.38146  
##  Median : -0.00364   Median : 0.3077   Median :-0.1386   Median : 0.3363   Median :-0.44519   Median :  0.2768   Median :-0.2354   Median :-0.1070   Median :-0.05334  
##  Mean   :  0.00000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.00000   Mean   :  0.0000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.00000  
##  3rd Qu.:  0.05508   3rd Qu.: 0.5895   3rd Qu.: 0.7175   3rd Qu.: 0.6915   3rd Qu.: 0.07141   3rd Qu.:  0.5206   3rd Qu.: 0.3527   3rd Qu.: 0.9821   3rd Qu.: 0.62704  
##  Max.   :116.37735   Max.   : 3.9124   Max.   : 3.0995   Max.   : 3.2415   Max.   : 2.70134   Max.   :  1.2609   Max.   : 2.9058   Max.   : 1.3526   Max.   : 2.80739  
##   yaw_forearm      max_roll_forearm   max_picth_forearm  min_roll_forearm    min_pitch_forearm amplitude_roll_forearm amplitude_pitch_forearm total_accel_forearm
##  Min.   :-1.9300   Min.   :-2.85258   Min.   :-2.56725   Min.   :-3.269347   Min.   :-1.1158   Min.   :-0.96312       Min.   :-0.9409         Min.   :-3.4482    
##  1st Qu.:-0.8508   1st Qu.:-0.80563   1st Qu.:-0.93414   1st Qu.:-0.068300   1st Qu.:-0.5530   1st Qu.:-0.90167       1st Qu.:-0.9235         1st Qu.:-0.5659    
##  Median :-0.1846   Median : 0.09374   Median : 0.27155   Median : 0.007019   Median : 0.1955   Median :-0.06632       Median :-0.1848         Median : 0.1298    
##  Mean   : 0.0000   Mean   :-0.05584   Mean   :-0.04361   Mean   : 0.007235   Mean   : 0.1033   Mean   :-0.07421       Mean   :-0.1042         Mean   : 0.0000    
##  3rd Qu.: 0.8820   3rd Qu.: 0.64514   3rd Qu.: 0.73142   3rd Qu.: 0.445482   3rd Qu.: 0.4872   3rd Qu.: 0.42470       3rd Qu.: 0.3700         3rd Qu.: 0.6268    
##  Max.   : 1.5607   Max.   : 1.99293   Max.   : 1.01262   Max.   : 2.688905   Max.   : 1.9746   Max.   : 3.71530       Max.   : 1.4533         Max.   : 7.2859    
##  var_accel_forearm avg_roll_forearm  stddev_roll_forearm var_roll_forearm   avg_pitch_forearm  stddev_pitch_forearm var_pitch_forearm avg_yaw_forearm   
##  Min.   :-0.9694   Min.   :-2.6704   Min.   :-0.7268     Min.   :-0.60171   Min.   :-3.09954   Min.   :-0.93205     Min.   :-0.5572   Min.   :-2.35412  
##  1st Qu.:-0.6464   1st Qu.:-0.4342   1st Qu.:-0.7118     1st Qu.:-0.60159   1st Qu.:-0.49901   1st Qu.:-0.87203     1st Qu.:-0.5558   1st Qu.:-0.29869  
##  Median :-0.2786   Median :-0.2607   Median :-0.2836     Median :-0.40831   Median : 0.06885   Median :-0.06943     Median :-0.2028   Median :-0.03950  
##  Mean   :-0.1548   Mean   :-0.0166   Mean   :-0.0181     Mean   :-0.01107   Mean   :-0.01711   Mean   :-0.06488     Mean   :-0.0488   Mean   : 0.03246  
##  3rd Qu.: 0.2167   3rd Qu.: 0.5218   3rd Qu.: 0.5737     3rd Qu.: 0.51327   3rd Qu.: 0.60823   3rd Qu.: 0.40842     3rd Qu.: 0.1824   3rd Qu.: 0.68760  
##  Max.   : 4.0850   Max.   : 1.8006   Max.   : 2.1903     Max.   : 2.75680   Max.   : 2.28551   Max.   : 3.69460     Max.   : 5.8384   Max.   : 1.95721  
##  stddev_yaw_forearm var_yaw_forearm    gyros_forearm_x    gyros_forearm_y    gyros_forearm_z     accel_forearm_x    accel_forearm_y   accel_forearm_z   magnet_forearm_x 
##  Min.   :-0.87465   Min.   :-0.65043   Min.   :-33.6661   Min.   :-2.07225   Min.   : -4.00024   Min.   :-2.42729   Min.   :-4.0071   Min.   :-2.8199   Min.   :-2.7914  
##  1st Qu.:-0.85915   1st Qu.:-0.65033   1st Qu.: -0.5796   1st Qu.:-0.44986   1st Qu.: -0.16307   1st Qu.:-0.64365   1st Qu.:-0.5244   1st Qu.:-0.9126   1st Qu.:-0.8739  
##  Median :-0.19180   Median :-0.35718   Median : -0.1694   Median :-0.01509   Median : -0.03694   Median : 0.02869   Median : 0.1842   Median : 0.1133   Median :-0.1924  
##  Mean   :-0.08863   Mean   :-0.08825   Mean   :  0.0000   Mean   : 0.00000   Mean   :  0.00000   Mean   : 0.00000   Mean   : 0.0000   Mean   : 0.0000   Mean   : 0.0000  
##  3rd Qu.: 0.36671   3rd Qu.: 0.29875   3rd Qu.:  0.6357   3rd Qu.: 0.44887   3rd Qu.:  0.16195   3rd Qu.: 0.76215   3rd Qu.: 0.7420   3rd Qu.: 0.5901   3rd Qu.: 0.6855  
##  Max.   : 2.88356   Max.   : 4.56531   Max.   :  5.1020   Max.   :90.72497   Max.   :111.98327   Max.   : 2.50134   Max.   : 3.8076   Max.   : 2.4757   Max.   : 2.8455  
##  magnet_forearm_y 
##  Min.   :-2.5320  
##  1st Qu.:-0.7301  
##  Median : 0.4151  
##  Mean   : 0.0000  
##  3rd Qu.: 0.6979  
##  Max.   : 2.1081
```

As we have more 120 variables, let's see if we can reduce their number via Principal Component Analysis keeping high variation level:

```r
preProcess(imputed_data, method="pca")
```

```
## 
## Call:
## preProcess.default(x = imputed_data, method = "pca")
## 
## Created from 13737 samples and 119 variables
## Pre-processing: principal component signal extraction, scaled, centered 
## 
## PCA needed 34 components to capture 95 percent of the variance
```

```r
pca_data <- predict(preProcess(imputed_data, method="pca"), imputed_data)

head(pca_data)
```

```
##         PC1       PC2      PC3      PC4       PC5       PC6       PC7       PC8       PC9     PC10      PC11       PC12      PC13     PC14      PC15     PC16      PC17
## 1 -8.137897 -7.031395 1.373766 2.929419 -1.563916 0.4938321 0.8058900 -2.346443 -1.176337 3.733479 -2.178248 -0.1439840 0.1034871 1.118386 -3.010986 2.242661 0.5430423
## 2 -8.143404 -7.060270 1.381128 2.975266 -1.512350 0.5462527 0.8038620 -2.343271 -1.177848 3.733536 -2.166163 -0.1073594 0.1185923 1.104562 -3.022916 2.204968 0.5161743
## 5 -8.165800 -7.025075 1.335276 2.996330 -1.517804 0.5487475 0.7970061 -2.338790 -1.185201 3.714562 -2.164612 -0.1156457 0.1264866 1.099035 -3.014622 2.207024 0.5251127
## 7 -8.133725 -7.033832 1.361290 2.951789 -1.550349 0.5065382 0.8099243 -2.362896 -1.176019 3.726382 -2.175549 -0.1209535 0.1210507 1.112623 -3.023769 2.221709 0.5356105
## 8 -8.150647 -7.035471 1.367090 2.966145 -1.538081 0.5184940 0.8106080 -2.359298 -1.185799 3.728415 -2.170213 -0.1268713 0.1173636 1.098106 -3.014692 2.217761 0.5311481
## 9 -8.151653 -7.042941 1.340592 2.933602 -1.551348 0.5277085 0.8025134 -2.337236 -1.169645 3.713561 -2.170772 -0.1345632 0.1286725 1.095151 -3.015073 2.231445 0.5380578
##        PC18      PC19        PC20       PC21      PC22        PC23       PC24       PC25      PC26         PC27      PC28      PC29      PC30     PC31       PC32
## 1 0.2676304 -1.586630 0.005776102 -0.4482334 0.3273138  0.05066743 -0.4440428 -0.7156625 0.2211237 -0.033301807 -1.223045 0.3412013 0.5719338 1.354517 -0.2707543
## 2 0.2662656 -1.545968 0.044312419 -0.4581640 0.2896669 -0.02079372 -0.5232726 -0.7562539 0.1780831 -0.016909247 -1.238135 0.3041582 0.5573940 1.302029 -0.2694077
## 5 0.2870273 -1.535300 0.118436846 -0.4122346 0.3753181 -0.02083669 -0.4488633 -0.7175931 0.1801835  0.007253811 -1.241415 0.3157113 0.5678905 1.295108 -0.2589418
## 7 0.2568694 -1.589798 0.003210343 -0.4555318 0.3350431  0.04177538 -0.4383278 -0.7412004 0.1884443 -0.035393424 -1.208888 0.3217788 0.5601926 1.335850 -0.2488735
## 8 0.2688382 -1.579152 0.016821694 -0.4558351 0.3201051  0.01648744 -0.4646851 -0.7357323 0.1866070 -0.038239119 -1.210402 0.3014709 0.5551758 1.332632 -0.2513124
## 9 0.2653981 -1.569132 0.006973011 -0.4575117 0.3153660  0.03596802 -0.4778744 -0.7319900 0.1883364 -0.019672209 -1.220064 0.3291166 0.5482680 1.326090 -0.2473914
##        PC33       PC34
## 1 0.1477736 -0.8077203
## 2 0.1427125 -0.8457633
## 5 0.1495600 -0.8508846
## 7 0.1473655 -0.8129400
## 8 0.1419711 -0.8248218
## 9 0.1352297 -0.7986777
```

```r
summary(pca_data)
```

```
##       PC1               PC2              PC3                PC4                PC5               PC6                PC7                PC8               PC9           
##  Min.   :-9.8498   Min.   :-9.293   Min.   :-13.1770   Min.   :-10.1000   Min.   :-9.5685   Min.   :-22.1127   Min.   : -6.0076   Min.   :-9.6133   Min.   :-10.71705  
##  1st Qu.:-4.5784   1st Qu.:-3.069   1st Qu.: -2.0809   1st Qu.: -1.8810   1st Qu.:-1.5764   1st Qu.: -0.8613   1st Qu.: -0.5257   1st Qu.:-1.3837   1st Qu.: -0.92557  
##  Median : 0.2593   Median : 1.525   Median : -0.1534   Median : -0.4478   Median :-0.1307   Median :  0.2310   Median :  0.0547   Median : 0.1579   Median :  0.04415  
##  Mean   : 0.0000   Mean   : 0.000   Mean   :  0.0000   Mean   :  0.0000   Mean   : 0.0000   Mean   :  0.0000   Mean   :  0.0000   Mean   : 0.0000   Mean   :  0.00000  
##  3rd Qu.: 4.7350   3rd Qu.: 3.511   3rd Qu.:  1.4351   3rd Qu.:  0.8684   3rd Qu.: 1.7399   3rd Qu.:  1.4162   3rd Qu.:  0.5633   3rd Qu.: 1.3386   3rd Qu.:  0.95168  
##  Max.   :11.0344   Max.   : 9.754   Max.   :  8.9130   Max.   : 10.9075   Max.   :16.6701   Max.   :  6.1609   Max.   :225.4544   Max.   :48.7189   Max.   :  6.50963  
##       PC10              PC11               PC12               PC13                PC14               PC15               PC16                PC17          
##  Min.   :-4.4220   Min.   :-6.48788   Min.   :-5.96787   Min.   :-5.067821   Min.   :-8.38001   Min.   :-6.46825   Min.   :-5.793414   Min.   :-6.387377  
##  1st Qu.:-1.1452   1st Qu.:-0.78879   1st Qu.:-0.95464   1st Qu.:-1.043885   1st Qu.:-0.95427   1st Qu.:-0.84921   1st Qu.:-0.782561   1st Qu.:-0.664989  
##  Median :-0.1832   Median : 0.00453   Median :-0.04044   Median :-0.007158   Median : 0.05545   Median :-0.02914   Median :-0.002584   Median : 0.000028  
##  Mean   : 0.0000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.000000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.000000   Mean   : 0.000000  
##  3rd Qu.: 0.8714   3rd Qu.: 0.70440   3rd Qu.: 0.97377   3rd Qu.: 0.908691   3rd Qu.: 1.00497   3rd Qu.: 0.81556   3rd Qu.: 0.800876   3rd Qu.: 0.726960  
##  Max.   :39.5469   Max.   :59.24585   Max.   :11.19349   Max.   :18.384574   Max.   : 6.05940   Max.   : 8.14516   Max.   : 9.458020   Max.   : 4.216915  
##       PC18               PC19                PC20                PC21               PC22               PC23               PC24               PC25         
##  Min.   :-9.29026   Min.   :-10.92678   Min.   :-6.107939   Min.   :-4.89421   Min.   :-9.43263   Min.   :-9.11089   Min.   :-5.47578   Min.   :-5.16334  
##  1st Qu.:-0.72522   1st Qu.: -0.62366   1st Qu.:-0.534191   1st Qu.:-0.67401   1st Qu.:-0.53090   1st Qu.:-0.54560   1st Qu.:-0.53025   1st Qu.:-0.56522  
##  Median : 0.04573   Median :  0.09829   Median :-0.008988   Median : 0.02757   Median : 0.02905   Median :-0.03879   Median :-0.01045   Median : 0.03667  
##  Mean   : 0.00000   Mean   :  0.00000   Mean   : 0.000000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.00000  
##  3rd Qu.: 0.71687   3rd Qu.:  0.59622   3rd Qu.: 0.519944   3rd Qu.: 0.64302   3rd Qu.: 0.48618   3rd Qu.: 0.47527   3rd Qu.: 0.49606   3rd Qu.: 0.50620  
##  Max.   : 7.96026   Max.   :  4.81748   Max.   :14.318432   Max.   : 7.98468   Max.   : 4.77127   Max.   : 5.75842   Max.   : 3.58790   Max.   : 4.67597  
##       PC26                PC27              PC28                PC29               PC30               PC31                PC32                PC33          
##  Min.   :-6.322297   Min.   :-9.8803   Min.   :-11.79813   Min.   :-9.18110   Min.   :-2.91886   Min.   :-3.927116   Min.   :-4.859461   Min.   :-7.410185  
##  1st Qu.:-0.467219   1st Qu.:-0.4556   1st Qu.: -0.50950   1st Qu.:-0.41843   1st Qu.:-0.41415   1st Qu.:-0.417282   1st Qu.:-0.420496   1st Qu.:-0.405883  
##  Median : 0.009115   Median :-0.0336   Median :  0.02953   Median : 0.01556   Median :-0.01141   Median : 0.000453   Median :-0.008516   Median :-0.000557  
##  Mean   : 0.000000   Mean   : 0.0000   Mean   :  0.00000   Mean   : 0.00000   Mean   : 0.00000   Mean   : 0.000000   Mean   : 0.000000   Mean   : 0.000000  
##  3rd Qu.: 0.462533   3rd Qu.: 0.4563   3rd Qu.:  0.52094   3rd Qu.: 0.43135   3rd Qu.: 0.43664   3rd Qu.: 0.430526   3rd Qu.: 0.371864   3rd Qu.: 0.364145  
##  Max.   : 7.343661   Max.   : 4.8407   Max.   :  4.20121   Max.   : 6.05386   Max.   : 3.78835   Max.   : 6.274115   Max.   : 6.650318   Max.   : 3.525179  
##       PC34           
##  Min.   :-11.018216  
##  1st Qu.: -0.363562  
##  Median : -0.006795  
##  Mean   :  0.000000  
##  3rd Qu.:  0.389737  
##  Max.   :  4.883616
```

## Building predicting models

## Cross validation

## Calculating error

## Summary
