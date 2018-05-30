# sampler
### R Package for Sample Design, Drawing & Data Analysis Using Data Frames
```sampler``` enables you to: 
* determine simple random sample sizes, stratified sample sizes, and complex stratified sample sizes using a secondary variable such as population 
* draw simple random samples and stratified random samples from sampling data frames 
* determine which observations are missing from a random sample, missing by strata, duplicated within a dataset 
* perform data analysis, including proportions, margins of error and upper and lower bounds for simple, stratified and cluster sample designs 

### To install from GitHub use in R:

```
install.packages("devtools”); library(devtools)
devtools::install_github("mbaldassaro/sampler”); library(sampler)
```

The ```sampler``` package comes with the following in-memory datasets:

* ```albania```: dataset containing 2017 Albania election results by polling station published by the Central Election Commission and opened by the Coalition of Domestic Observers & Democracy International
* ```opening```: dataset containing 2017 Albania election observation findings on polling station opening process by the Coalition of Domestic Observers (CDO) CDO conducted a statistically-based observation (SBO) exercise, deploying observers to a random sample of polling stations for the 25 June 2017 Albanian elections. This is a subset of observation data collected by CDO observers that includes data that was used to perform statistical analysis

The package provides the following functionality: 

### Determine random sample size

```
rsampcalc(N=5361, e=3, ci=95, p=0.5, over=0.1)
```

Where:
* ```N``` is population universe (e.g. 10000, nrow(df))
* ```e``` is tolerable margin of error (integer or float, e.g. 5, 2.5)
* ```ci``` (optional) is confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
* ```p``` (optional) is anticipated response distribution (defaults to 0.5; takes value between 0 and 1 as input)
* ```over``` (optional) is desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)

Returns appropriate sample size (rounded up to nearest integer)

*Sampling Design & Analysis, S. Lohr, 1999, equation 2.17*

### Determine sample size by strata using proportional allocation

```
ssampcalc(df=albania, n=544, strata=qarku, over=0.05)
```
or
```
size <- rsampcalc(nrow(albania), 3, 95, 0.5)
ssampcalc(albania, size, qarku)
```
Where: 
* ```df``` is object containing sampling data frame 
* ```n``` is sample size (integer) or object containing sample size
* ```strata``` is variable in sampling data frame by which to stratify (e.g. region)
* ```over``` (optional) is desired oversampling proportion (defaults to 0; takes value between 0 and 1 as input)

Returns proportional sample size per strata (rounded up to nearest integer)

*Sampling Design & Analysis, S. Lohr, 1999, 4.4*

### Calculate proportion and margin of error (simple random sample)
```
rpro(df=opening, col_name=openTime, ci=95, na="n/a", N=5361)
```

Where: 
* ```df``` is object containing data frame on which to perform analysis (e.g. data)
* ```col_name``` is variable in data frame for which you want to calculate proportion and margin of error
* ```ci``` (optional) is confidence level for establishing a confidence interval using z-score (defaults to 95; restricted to 80, 85, 90, 95 or 99 as input)
* ```na``` (optional) is value that you want to filter and exclude (defaults to include everything)
* ```N``` (optional) is population universe (e.g. 10000, nrow(df)); if N value is passed as an argument, margin of error will be calculated using fpc

Returns table of responses (n), proportions, margins of error, lower and upper bounds by factor for a given variable

*source: Sampling Design & Analysis, S. Lohr, 1999, Equation 2.15*
