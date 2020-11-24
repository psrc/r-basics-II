---
layout: page
title: R Fundamentals II
subtitle: Control flow
---



> ## Learning Objectives {.objectives}
>
> * Get familiar with control flow structures:
>   * `if else`
>   * `for`
>   * `while`
>

<a id="control-flow"></a>

The meaning of the control flow structures `if else`, `for` and `while` is the same as in Python or other programming languages. What differs is the syntax. Let's learn these construct on examples.

## Structure `if else`


~~~{.r}
add.growth.rate(hh, "hh16", "hh50")
~~~



~~~{.error}
Error in `[.data.frame`(dat, , col2): undefined columns selected

~~~

First let's modify our `add.growth.rate` funtion to control for the existence of the columns:

~~~{.r}
gr.outliers <- function(dat, threshold = 50, grcol = "GrowthRate", above = TRUE) {
    res <- dat[dat[[grcol]] > threshold, ]
    return(res)
}


add.growth.rate <- function(dat, col1, col2, new.name = "GrowthRate") {
    if(is.null(dat[[col1]]) || is.null(dat[[col2]])) {
        dat[[new.name]] <- NA
    } else {
        newcol <- growth.rate(dat[, col1], dat[, col2])
        dat[[new.name]] <- round(newcol, 1)
    }
    return(dat)
}
head(add.growth.rate(hh, "hh16", "hh50"))
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050     city_name county_id
1       1   2705   2735   2836   2939   3037 Normandy Park        33
2       2  24886  26527  32059  37708  43071        Auburn        33
3       3  45021  45724  48094  50515  52813    King-Rural        33
4       4  10135  11122  14449  17846  21072        SeaTac        33
5       5  22527  23240  25643  28097  30427     Shoreline        33
6       6  16769  17481  19881  22332  24658    Renton PAA        33
  county_name GrowthRate
1        King         NA
2        King         NA
3        King         NA
4        King         NA
5        King         NA
6        King         NA

~~~

We have our vectors of cities obtained `outl.above` and `outl.below` and we want to extract data corresponding to those cities from the households dataset:

~~~{.r}
for(city in outl.above) {
	idx <- which(hh$city_name == city)
	print(hh[idx,])
}
~~~



~~~{.error}
Error in eval(expr, envir, enclos): object 'outl.above' not found

~~~
This does not look very pretty. We can improve by binding the rows together:

~~~{.r}
res <- NULL
for(city in outl.above) {
	idx <- which(hh$city_name == city)
	res <- rbind(res, hh[idx,])
}
~~~



~~~{.error}
Error in eval(expr, envir, enclos): object 'outl.above' not found

~~~



~~~{.r}
print(res)
~~~



~~~{.output}
NULL

~~~



~~~{.r}
res <- NULL
for(city in outl.below) {
	idx <- which(hh$city_name == city)
	res <- rbind(res, hh[idx,])
}
~~~



~~~{.error}
Error in eval(expr, envir, enclos): object 'outl.below' not found

~~~



~~~{.r}
print(res)
~~~



~~~{.output}
NULL

~~~

Sometimes you will find yourself needing to repeat an operation until a certain
condition is met. You can do this with a `while` loop.

Say we want the above data frame but with maximum of five rows:

~~~{.r}
res <- NULL
i <- 1
while(i <= 5) {
	idx <- which(hh$city_name == outl.below[i])
	res <- rbind(res, hh[idx,])
	i = i + 1
}
~~~



~~~{.error}
Error in which(hh$city_name == outl.below[i]): object 'outl.below' not found

~~~



~~~{.r}
print(res)
~~~



~~~{.output}
NULL

~~~

> ## Challenge 2 {.challenge}
>
> How would you vectorise the following loop
> 
> 
> ~~~{.r}
> res <- NULL
> for(city in outl.below) {
>   idx <- which(hh$city_name == city)
>   res <- rbind(res, hh[idx,])
> }
> ~~~
> 
> 
> 
> ~~~{.error}
> Error in eval(expr, envir, enclos): object 'outl.below' not found
> 
> ~~~

## Challenge solutions



> ## Solution to challenge 2 {.challenge}
>
> 
> ~~~{.r}
> hh[which(hh$city_name %in% outl.below),]
> ~~~
> 
> 
> 
> ~~~{.error}
> Error in hh$city_name %in% outl.below: object 'outl.below' not found
> 
> ~~~
