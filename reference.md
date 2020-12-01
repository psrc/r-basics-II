---
layout: page
title: R Fundamentals II
subtitle: Reference
---


[Reference for R Fundamentals I](../r-basics-I/reference.html)

## [Saving plots](01-more-plots.html)

 - `pdf` creates a PDF file (given by argument `file`) ready for receiving graphics.
 - Arguments `width` and `heigth` define the page size.
 - `par(mfrow = c(nr, nc))` creates a grid to place multiple graphs on a single page, where `nr` is the number of rows and `nc` is the number of columns of that grid.
 - Use graphics functions (e.g. `plot`, `hist`, `boxplot`, `abline`, `text`, etc.) to send plots into the file.
 - Close the opened file by `dev.off()`.
 - Functions `png` or `jpeg` can be used instead of `pdf` for other file formats.

## [Writing data](02-writing-data.html)

 - `write.table` to write out objects in regular format
 - Set `quote = FALSE` so that text isn't wrapped in `"` marks.
 - Set `row.names = FALSE` to not store row names.
 - `sep` argument defines the column separator
 - `write.csv` has `sep = ","` as default

## [Functions](03-functions.html)

 - Put code whose parameters change frequently in a function, then call it with
   different parameter values to customize its behavior.
 - Define a function by assigning `function(...)` to a name, where `...` stands for one or more arguments.
 - Enclose the body of a function into `{}`.
 - The last line of a function is returned, or you can use `return` explictly.
 - Any code written in the body of the function is isolated to the function
   when it is called.
 - Functions can be nested, i.e. they can call other functions.
 - In a function call, when assigning values to function arguments, you _must_ use `=` (and not `<-`).

## [Control flow](04-control-flow.html)

 - Use `if` condition to start a conditional statement and `else` to provide a default.
 - Enclose the bodies of the branches of conditional statements into `{ }`, unless the body contains only one line.
 - Use `==` to test for equality.
 - `X && Y` is only true if both X and Y are `TRUE`.
 - `X || Y` is true if either X or Y, or both, are `TRUE`.
 - Zero is considered `FALSE`; all other numbers are considered `TRUE`.
 - Use `for` if you want to repeat a block of code multiple times with known number of iterations. 
 - Use `while` if you want to repeat a block of code until a condition is met.
 - Nest loops to operate on multi-dimensional data.
 - `break` breaks out of a loop.
 - `next` moves to the nex iterations without finishing the current iteration.


## [Installing and loading packages](05-packages.html)

 - `install.packages` to install packages from CRAN
 - `library` to load a package into R

<br>
<br>

