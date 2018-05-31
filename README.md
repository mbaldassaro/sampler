# sampler R package
### R Package for Sample Design, Drawing, & Data Analysis Using Data Frames
The sampler R package is designed to enable data scientists to design, draw, and analyze simple or complex samples using data frames. It enables you to load machine-readable files (e.g. .csv, .tsv, etc.) in R containing a sampling frame or collected data, store them as objects, and perform sampling techniques and analysis using clear and concise methods. 

Specifically, a data scientist can use the sampler R package to: 

* determine simple random sample sizes, stratified sample sizes, and complex stratified sample sizes using a secondary variable such as population 
* draw simple random samples and stratified random samples from sampling data frames 
* determine which observations are missing from a random sample, missing by strata, duplicated within a dataset 
* perform data analysis, including proportions, margins of error and upper and lower bounds for simple, stratified and cluster sample designs 

The sampler R package builds a bridge for survey administrators between the free and open-source R environment and no-to-low cost [Open Data Kit (ODK)](https://opendatakit.org/)-based toolkits such as [Ona](https://ona.io/home/) and [ELMO](http://getelmo.org/). The sampler package has been submitted to [CRAN](https://cran.r-project.org/) and is pending approval, but is now available via GitHub for use in [R](https://www.r-project.org/) and [R Studio](https://www.rstudio.com/).  

### To install in R from GitHub:

```
install.packages("devtools”); library(devtools)
devtools::install_github("mbaldassaro/sampler”); library(sampler)
```

The sampler R package comes with the following in-memory datasets:

* ```albania```: dataset containing 2017 Albania election results by polling station published by the Central Election Commission and opened by the Coalition of Domestic Observers & Democracy International
* ```opening```: dataset containing 2017 Albania election observation findings on polling station opening process by the Coalition of Domestic Observers (CDO) CDO conducted a statistically-based observation (SBO) exercise, deploying observers to a random sample of polling stations for the 25 June 2017 Albanian elections. This is a subset of observation data collected by CDO observers that includes data that was used to perform statistical analysis

The package provides the following functionality: 

### Determine random sample size

```
rsampcalc(N, e, ci=95,p=0.5, over=0)
```

Where:
* ```N``` is population universe (e.g. 10000, nrow(df))
* ```e``` is tolerable margin of error (integer or float, e.g. 5, 2.5)
* ```ci``` (optional) is confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
* ```p``` (optional) is anticipated response distribution (defaults to 0.5; takes value between 0 and 1 as input)
* ```over``` (optional) is desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)

Returns appropriate sample size (rounded up to nearest integer)

Example:
```
rsampcalc(N=5361, e=3, ci=95, p=0.5, over=0.1)
```

*Source: Sampling Design & Analysis, S. Lohr, 1999, equation 2.17*

### Draw a simple random sample 

```
rsamp(df, n, over=0, rep=FALSE)
```

Where: 
* ```df``` is object containing full sampling data frame 
* ```n``` is sample size (integer or object containing sample size)
* ```over``` (optional) is desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)
* ```rep``` (optional) is boolean for a sample with repalcement (TRUE) or without replacement (defaults to FALSE)

Returns a simple random sample of size ```n```

Example:
```
rsamp(albania, n=360, over=0.1, rep=FALSE)
```
or
```
size <- rsampcalc(nrow(albania), 3, 95, 0.5)
rsamp(albania, size)
```

### Determine sample size by strata using proportional allocation

```
ssampcalc(df, n, strata, over=0)
```

Where: 
* ```df``` is object containing sampling data frame 
* ```n``` is sample size (integer) or object containing sample size
* ```strata``` is variable in sampling data frame by which to stratify 
* ```over``` (optional) is desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)

Returns proportional sample size per strata (rounded up to nearest integer)

Example:
```
ssampcalc(df=albania, n=544, strata=qarku, over=0.05)
```
or
```
size <- rsampcalc(nrow(albania), 3, 95, 0.5)
ssampcalc(albania, size, qarku)
```

*Source: Sampling Design & Analysis, S. Lohr, 1999, 4.4*

### Draw stratified sample (proportional allocation)

```
ssamp(df, n, strata, over=1)
```

Where:
* ```df``` is object containing full sampling data frame 
* ```n``` is sample size (integer, or object containing sample size)
* ```strata``` is variable in sampling data frame by which to stratify (e.g. region)
* ```over``` (optional) is desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)

Returns stratified sample using proportional allocation without replacement

Example:
```
ssamp(df=albania, n=360, strata=qarku, over=0.1)
```
or
```
size <- rsampcalc(nrow(albania), 3, 95, 0.5)
ssamp(albania, size, qarku)
```

### Determine sample size by strata using sub-units

```
psampcalc(df, n, strata, unit, over=0)
```

Where:
* ```df``` is object containing full sampling data frame 
* ```n``` is sample size (integer) or object containing sample size
* ```strata``` is variable in sampling data frame by which to stratify 
* ```unit``` is variable in sampling data frame containing sub-units (e.g. population)
* ```over``` (optional) is desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)

Returns sample size per strata based on sub-units (rounded up to nearest integer)

Example
```
psampcalc(df=albania, n=544, strata=qarku, unit=zgjedhes, over=0.1)
```

*Source: Sampling Design & Analysis, S. Lohr, 1999, 4.4*

### Calculate proportion and margin of error (simple random sample)

```
rpro(df, col_name, ci=95, na="", N=0)
```
Where: 
* ```df``` is object containing data frame on which to perform analysis (e.g. data)
* ```col_name``` is variable in data frame for which you want to calculate proportion and margin of error
* ```ci``` (optional) is confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
* ```na``` (optional) is value that you want to filter and exclude (defaults to include everything)
* ```N``` (optional) is population universe (e.g. 10000, nrow(df)); if N value is passed as an argument, margin of error will be calculated using fpc

Returns table of responses (n), proportions (midpoint), margins of error, lower and upper bounds by factor for a given variable

Example:
```
rpro(df=opening, col_name=openTime, ci=95, na="n/a", N=5361)
```

*Source: Sampling Design & Analysis, S. Lohr, 1999, Equation 2.15*

### Calculate proportion and margin of error (stratified sample)

```
spro(fulldf, sampdf, strata, col_name, ci=95, na="")
```

Where: 
* ```fulldf``` is object containing original data frame used to draw sample
* ```sampdf``` is object containing data frame on which to perform analysis
* ```strata``` is variable in both data frames by which to stratify
* ```col_name``` is variable in data frame for which you want to calculate proportion and margin of error
* ```ci``` (optional) is confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
* ```na``` (optional) is value that you want to filter and exclude (defaults to include everything)

Returns table of responses (n), proportions (midpoint), margins of error, lower and upper bounds by factor for a given variable in a stratified sample

Example:
```
spro(fulldf=albania, sampdf=opening, strata=qarku, col_name=openTime, ci=95, na="n/a")
```

*Source: Sampling Design & Analysis, S. Lohr, 1999, 4.6 & 4.7*

### Calculate proportion and margin of error (unequal-sized cluster sample)

```
cpro(df, numerator, denominator, ci=95, na="", N=0)
```

Where:
* ```df``` is object containing data frame on which to perform analysis
* ```numerator``` is variable in data frame for which you want to calculate proportion and margin of error
* ```denominator``` is variable in data frame containing population of unequal cluster sizes
* ```ci``` (optional) is confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
* ```na``` (optional) is value that you want to filter and exclude (defaults to include everything)
* ```N``` (optional) is population universe (e.g. 10000, nrow(df)); if N value is passed as an argument, margin of error will be calculated using fpc

Returns table of responses (n), proportions (midpoint), margins of error, lower and upper bounds by factor for a given variable in an unequal-sized cluster sample

Example:
```
alresults <- ssamp(albania, 890, qarku)
cpro(df=alresults, numerator=totalVoters, denominator=zgjedhes, ci=95)
cpro(df=alresults, numerator=pd, denominator=validVotes, ci=95, N=5361)
```

*Source 1: Survey Sampling, L. Kish, 1965, Equation 6.3.4*

*Source 2: Sampling Techniques, W.G. Cochran, 1977, Equation 3.34*

### Identify missing points between sample and collected data

```
rmissing(sampdf, colldf, col_name)
```

Where: 
*  ```sampdf``` is object containing data frame of sample points
* ```colldf``` is object containing data frame of collected data
* ```col_name``` is common variable (i.e. key) in data frames by which to check for missing points

Returns table of sample points missing from collected data

Example:
```
alsample <- rsamp(df=albania, 544)
alreceived <- rsamp(df=alsample, 390)
rmissing(sampdf=alsample, colldf=alreceived, col_name=qvKod)
```

### Identify number of missing points by strata between sample and collected data

```
smissing(sampdf, colldf, strata, col_name)
```

Where:
* ```sampdf``` is object containing data frame of sample points
* ```colldf``` is object containing data frame of collected data
* ```strata``` is variable in both data frames by which to stratify
* ```col_name``` is common variable (i.e. key) in data frames by which to check for missing points

Returns table of number of sample points by strata missing from collected data

Example:
```
alsample <- rsamp(df=albania, 544)
alreceived <- rsamp(df=alsample, 390)
smissing(sampdf=alsample, colldf=alreceived, strata=qarku, col_name=qvKod)
```

### Identify duplicate values within collected data

```
dupe(df, col_name)
```

Where:
* ```df``` is object containing data frame of collected data
* ```col_name``` is variable within data frame by which to filter for duplicate values

Returns table of duplicate values within collected data

Example:
```
aldupe <- rsamp(df=albania, n=390, rep=TRUE)
dupe(df=aldupe, col_name=qvKod)
```

### Remove observations based on duplicate values within collected data

```
dedupe(df, col_name)
```

Where: 
* ```df``` is object containing data frame of collected data
* ```col_name``` is variable within data frame by which to filter for duplicate values

Returns table of observations based on unique values within collected data

Example:

```
aldupe <- rsamp(df=albania, n=390, rep=TRUE)
dedupe(df=aldupe, col_name=qvKod)
```
