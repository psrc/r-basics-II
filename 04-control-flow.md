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


First let's modify our `gr.outliers` funtion to control for outliers from both sides of the distribution:

~~~{.r}
gr.outliers <- function(dat, threshold = 50, grcol = "GrowthRate", above = TRUE) {
    dat <- na.omit(dat) # removes rows with NA
    if(above) {
        res <- dat[dat[[grcol]] > threshold, ]
    } else {
        res <- dat[dat[[grcol]] <= threshold, ]
    }
    return(res)
}
hhgr <- add.growth.rate(hh, "hh2030", "hh2050")
gr.outliers(hhgr, 150)
~~~



~~~{.output}
    city_id hh2016 hh2020 hh2030 hh2040 hh2050    city_name county_id
135     136      5    160    682   1216   1722 Woodway MUGA        61
    county_name GrowthRate
135   Snohomish      152.5

~~~



~~~{.r}
gr.outliers(hhgr, 0, above = FALSE)
~~~



~~~{.output}
    city_id hh2016 hh2020 hh2030 hh2040 hh2050         city_name county_id
36       36      2      2      2      2      2     Newcastle PAA        33
45       45     40     40     38     37     36 Black Diamond PAA        33
54       54    608    606    600    595    589            Milton        33
131     132     61     61     61     61     61        Maltby UGA        61
148     157    212    211    209    206    204      Frederickson        53
152     161      4      4      4      4      4       Pacific PAA        53
    county_name GrowthRate
36         King        0.0
45         King       -5.3
54         King       -1.8
131   Snohomish        0.0
148      Pierce       -2.4
152      Pierce        0.0

~~~

In the `if else` construct the condition in parentheses must be of length one. An alternative construct for vectorized conditioning is `ifelse`. It is faster than `if else` and is preferable if possible. For example, the `growth.rate` function can be written so that it takes into account zeros in the denominator: 


~~~{.r}
growth.rate0 <- function(x, y) {
    rate <- ifelse(x > 0, (y - x)/x * 100, 0)
    return(rate)
}
growth.rate(c(0, 1), c(2, 2))
~~~



~~~{.output}
[1] Inf 100

~~~



~~~{.r}
growth.rate0(c(0, 1), c(2, 2))
~~~



~~~{.output}
[1]   0 100

~~~

## Structure `for`

The `for` structure is used when we want to repeat a block of code specified number of times. 

Say we want to compute the sum of households for each county and store it in a new data frame:


~~~{.r}
res <- NULL
for(cnty in c("King", "Kitsap", "Pierce", "Snohomish")) {
    s <- subset(hh, county_name == cnty)
    sm <- apply(s[,2:6], 2, sum)
    res <- rbind(res, data.frame(county = cnty, t(sm)))
}
res
~~~



~~~{.output}
     county hh2016 hh2020  hh2030  hh2040  hh2050
1      King 870519 911389 1049159 1189850 1323417
2    Kitsap 100699 104337  116591  129107  140989
3    Pierce 320054 335245  386446  438732  488373
4 Snohomish 290591 306526  360226  415076  467140

~~~

The code inside `{ }` runs repeatedly while the object `cnty` taking one value from the county sequence in each iteration. 

Another example of a `for` loop is a slower version of the `apply` function above. Here computing sums for the whole region:


~~~{.r}
res <- c()
for(i in 2:6) {
    res <- c(res, sum(hh[, i]))
}
names(res) <- colnames(hh)[2:6]
res
~~~



~~~{.output}
 hh2016  hh2020  hh2030  hh2040  hh2050 
1581863 1657497 1912422 2172765 2419919 

~~~
which is equivalent to 

~~~{.r}
apply(hh[, 2:6], 2, sum)
~~~



~~~{.output}
 hh2016  hh2020  hh2030  hh2040  hh2050 
1581863 1657497 1912422 2172765 2419919 

~~~

## Structure `while`

Sometimes you will find yourself needing to repeat an operation until a certain
condition is met. You can do this with a `while` loop.

Let's throw a dice and count how many throws it takes to get three sixes. 


~~~{.r}
throw <- 0
count6 <- 0
while(count6 <= 3) {
	d <- sample(1:6, 1)
	if(d == 6)
	    count6 <- count6 + 1
	throw <- throw + 1
}
throw
~~~



~~~{.output}
[1] 9

~~~

