---
layout: page
title: R Fundamentals II
subtitle: Writing data
---



> ## Learning Objectives {.objectives}
>
> * To be able to write out data from R
>


## Writing data

At some point, you'll also want to write out data from R. Let's create a subset of our indicator dataset that contains cities of the King county. 


~~~{.r}
luking <- subset(lu, county_name == "King")
head(luking)
~~~



~~~{.output}
  city_id households population employment     city_name county_id county_name
1       1       3037   6918.955   1138.692 Normandy Park        33        King
2       2      43071 109346.988  80728.553        Auburn        33        King
3       3      52813 135151.807  29143.840    King-Rural        33        King
4       4      21072  54123.738  74106.415        SeaTac        33        King
5       5      30427  68696.487  27411.035     Shoreline        33        King
6       6      24658  63154.608   6429.210    Renton PAA        33        King
    hhsize
1 2.278220
2 2.538761
3 2.559063
4 2.568515
5 2.257748
6 2.561222

~~~

First, we want to round population and employment to integers and household size to 2 decimals:


~~~{.r}
luking[, c("population", "employment")] <- round(luking[, c("population", "employment")])
luking$hhsize <- round(luking$hhsize, 2)
head(luking)
~~~



~~~{.output}
  city_id households population employment     city_name county_id county_name
1       1       3037       6919       1139 Normandy Park        33        King
2       2      43071     109347      80729        Auburn        33        King
3       3      52813     135152      29144    King-Rural        33        King
4       4      21072      54124      74106        SeaTac        33        King
5       5      30427      68696      27411     Shoreline        33        King
6       6      24658      63155       6429    Renton PAA        33        King
  hhsize
1   2.28
2   2.54
3   2.56
4   2.57
5   2.26
6   2.56

~~~

Now we'll use the `write.table` function for writing the `luking` dataset out. It is 
very similar to the `read.table` function.


~~~{.r}
write.table(luking, file = "lu-King.csv", sep=",")
~~~

We can look at the data from a shell terminal to make sure it looks
OK:


~~~{.r}
head lu-King.csv
~~~




~~~{.output}
"city_id","households","population","employment","city_name","county_id","county_name","hhsize"
"1",1,3037,6919,1139,"Normandy Park",33,"King",2.28
"2",2,43071,109347,80729,"Auburn",33,"King",2.54
"3",3,52813,135152,29144,"King-Rural",33,"King",2.56
"4",4,21072,54124,74106,"SeaTac",33,"King",2.57
"5",5,30427,68696,27411,"Shoreline",33,"King",2.26
"6",6,24658,63155,6429,"Renton PAA",33,"King",2.56
"7",7,63110,163370,102864,"Kent",33,"King",2.59
"8",8,15894,39630,74321,"Tukwila",33,"King",2.49
"9",9,505387,982391,871244,"Seattle",33,"King",1.94

~~~

Hmm, that's not quite what we wanted. Where did all these
quotation marks come from? Also the row numbers are
meaningless.

Let's look at the help file to work out how to change this
behaviour.


~~~{.r}
?write.table
~~~

By default R will wrap character vectors with quotation marks
when writing out to file. It will also write out the row and
column names.

Let's fix this:


~~~{.r}
write.table(luking, file = "lu-King.csv", sep = ",", 
            quote = FALSE, row.names = FALSE)
~~~

Now lets look at the data again from a shell terminal:


~~~{.r}
head lu-King.csv
~~~




~~~{.output}
city_id,households,population,employment,city_name,county_id,county_name,hhsize
1,3037,6919,1139,Normandy Park,33,King,2.28
2,43071,109347,80729,Auburn,33,King,2.54
3,52813,135152,29144,King-Rural,33,King,2.56
4,21072,54124,74106,SeaTac,33,King,2.57
5,30427,68696,27411,Shoreline,33,King,2.26
6,24658,63155,6429,Renton PAA,33,King,2.56
7,63110,163370,102864,Kent,33,King,2.59
8,15894,39630,74321,Tukwila,33,King,2.49
9,505387,982391,871244,Seattle,33,King,1.94

~~~

That looks better!

Analogously to `read.csv`, there is a `write.csv` function that lets you to leave the `sep` argument out as it uses comma by default. 


