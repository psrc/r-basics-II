---
layout: page
title: R Fundamentals II
subtitle: Homework
---



> ## Challenge 1 {.challenge}
>
> The `paste` function can be used to combine text together, e.g:
>
> 
> ~~~{.r}
> best_practice <- c("Write", "programs", "for", "people", "not", "computers")
> paste(best_practice, collapse=" ")
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] "Write programs for people not computers"
> 
> ~~~
>
>  Write a function called `fence` that takes two vectors as arguments, called
> `text` and `wrapper`, and prints out the text wrapped with the `wrapper`:
>
> 
> ~~~{.r}
> fence(text = best_practice, wrapper = "***")
> ~~~
> 
> 
> 
> ~~~{.output}
> [1] "*** Write programs for people not computers ***"
> 
> ~~~
>
> *Note:* the `paste` function has an argument called `sep`, which specifies the
> separator between text. The default is a space: " ". The default for `paste0`
> is no space "".
>



This homework combines everything we learned: reading data from a file, transforming and adding columns, subsetting, plotting, reading help files.

Write a script that reads the land use dataset `city__dataset_table__lu_indicators__2010.tab`, joins it with cities and counties and for each county it creates a histogram of the non-residential sqft per job ratio. The histogram should have 20 bins. It should also include a thick red vertical line at the mean value of the ratio per county. Your result should look like this:


~~~{.error}
Error in cbind(lu, sqft_per_job = lu$non_res_sqft/lu$jobs): object 'lu' not found

~~~



~~~{.error}
Error in subset(lu, county_id == county): object 'lu' not found

~~~

Hint: See `?hist` to find out how to control the number of bins in a histogram. Also for the title, you can extract the county name by subsetting the dataset `counties`. Make the code more general by using the `for` loop described in [this](07-functions.html#control-flow) section.
