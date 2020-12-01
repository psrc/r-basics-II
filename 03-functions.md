---
layout: page
title: R Fundamentals II
subtitle: Functions
---



> ## Learning Objectives {.objectives}
>
> * Define a function that takes arguments.
> * Return a value from a function.
> * Test a function.
> * Set default values for function arguments.
>


In this lesson, we'll learn how to write a function so that we can repeat
several operations with a single command.

> ## What is a function? {.callout}
>
> Functions gather a sequence of operations into a whole, preserving it for ongoing use. Functions provide:
>
> * a name we can remember and invoke it by
> * relief from the need to remember the individual operations
> * a defined set of inputs and expected outputs
> * rich connections to the larger programming environment
>


## Defining a function

Let's open a new R script file  and call it functions.R. We will write a function to compute a growth rate of two numbers `x` and `y`:


~~~{.r}
growth.rate <- function(x, y) {
    rate <- (y - x)/x * 100
    return(rate)
}
~~~

We define `growth.rate` by assigning it to the output of `function`.
The list of argument names are contained within parentheses.
Next, the **body** of the function -- the statements that are executed when it runs -- is contained within curly braces (`{}`).
The statements in the body are indented by four spaces.
This makes the code easier to read but does not affect how the code operates.

When we call the function, the values we pass to it are assigned to those variables so that we can use them inside the function.
Inside the function, we use a **return statement** to send a result back to whoever asked for it.

> ## Tip {.callout}
>
> One feature unique to R is that the return statement is not required.
> R automatically returns whichever variable is on the last line of the body
> of the function. Since we are just learning, we will explicitly define the
> return statement.

Let's try running our function.
Calling our own function is no different from calling any other function:


~~~{.r}
growth.rate(10, 20)
~~~



~~~{.output}
[1] 100

~~~



~~~{.r}
base <- 50
end <- 60
growth.rate(x = base, y = end)
~~~



~~~{.output}
[1] 20

~~~

Our implementation of the `growth.rate` function supports vectorized inputs:


~~~{.r}
growth.rate(c(1, 3, 5), c(2, 3, 4))
~~~



~~~{.output}
[1] 100   0 -20

~~~

## Combining functions

The real power of functions comes from mixing, matching and combining them
into ever large chunks to get the effect we want.

Here we define a function that computes a growth rate for given columns of a dataset and adds it to the dataset as an additional column:


~~~{.r}
add.growth.rate <- function(dat, col1, col2, new.name = "GrowthRate") {
  newcol <- growth.rate(dat[, col1], dat[, col2])
  dat[[new.name]] <- round(newcol, 1)
  return(dat)
}
add.growth.rate(head(hh), "hh2016", "hh2050")
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
1        King       12.3
2        King       73.1
3        King       17.3
4        King      107.9
5        King       35.1
6        King       47.0

~~~



~~~{.r}
add.growth.rate(head(hh), "hh2016", "hh2050", "GR16-50")
~~~



~~~{.output}
  city_id hh2016 hh2020 hh2030 hh2040 hh2050     city_name county_id
1       1   2705   2735   2836   2939   3037 Normandy Park        33
2       2  24886  26527  32059  37708  43071        Auburn        33
3       3  45021  45724  48094  50515  52813    King-Rural        33
4       4  10135  11122  14449  17846  21072        SeaTac        33
5       5  22527  23240  25643  28097  30427     Shoreline        33
6       6  16769  17481  19881  22332  24658    Renton PAA        33
  county_name GR16-50
1        King    12.3
2        King    73.1
3        King    17.3
4        King   107.9
5        King    35.1
6        King    47.0

~~~


We've set a
*default argument* to `"GrowthRate"` using the `=` operator
in the function definition. This means that this argument will
take on that value unless the user specifies otherwise.




> ## Tip: Pass by value {.callout}
>
> Functions in R almost always make copies of the data to operate on
> inside of a function body. When we modify `dat` inside the function
> we are modifying the copy of the households dataset stored in `dat`,
> not the original variable we gave as the first argument.
>
> This is called "pass-by-value" and it makes writing code much safer:
> you can always be sure that whatever changes you make within the
> body of the function, stay inside the body of the function.
>

> ## Tip: Function scope {.callout}
>
> Another important concept is scoping: any variables (or functions!) you
> create or modify inside the body of a function only exist for the lifetime
> of the function's execution. When we call `add.growth.rate`, the variable `newcol` 
> only exist inside the body of the function. Even if we
> have variables of the same name in our interactive R session, they are
> not modified in any way when executing a function.
>

Let's write one more function that returns a subset of cities above a given threshold of growth. 


~~~{.r}
gr.outliers <- function(dat, threshold = 50, grcol = "GrowthRate") {
    res <- dat[dat[[grcol]] > threshold, ]
    return(res)
}
hhgr <- add.growth.rate(hh, "hh2030", "hh2050")
gr.outliers(hhgr, 100)
~~~



~~~{.output}
    city_id hh2016 hh2020 hh2030 hh2040 hh2050         city_name county_id
71       72    191    350    887   1435   1955      Poulsbo PUTA        35
129     130     52     90    219    350    474      Stanwood UGA        61
132     133     61     89    182    277    368 Granite Falls UGA        61
NA       NA     NA     NA     NA     NA     NA              <NA>        NA
134     135     23     53    154    256    353        Sultan UGA        61
135     136      5    160    682   1216   1722      Woodway MUGA        61
136     137     36     52    106    161    213    Darrington UGA        61
155     164      1      2      4      7     10 South Prairie PAA        53
    county_name GrowthRate
71       Kitsap      120.4
129   Snohomish      116.4
132   Snohomish      102.2
NA         <NA>         NA
134   Snohomish      129.2
135   Snohomish      152.5
136   Snohomish      100.9
155      Pierce      150.0

~~~

(Don't worry about the `NA`s in the output for now - we'll fix it in the next section.)

If you've been writing these functions down into a separate R script
(a good idea!), you can load in the functions into our R session by using the
`source` function:


~~~{.r}
source("functions.R")
~~~


> ## Tip {.callout}
>
> R has some unique aspects that can be exploited when performing
> more complicated operations. We will not be writing anything that requires
> knowledge of these more advanced concepts. In the future when you are
> comfortable writing functions in R, you can learn more by reading the
> [R Language Manual][man] or this [chapter][] from
> [Advanced R Programming][adv-r] by Hadley Wickham. For context, R uses the
> terminology "environments" instead of frames.

[man]: http://cran.r-project.org/doc/manuals/r-release/R-lang.html#Environment-objects
[chapter]: http://adv-r.had.co.nz/Environments.html
[adv-r]: http://adv-r.had.co.nz/
