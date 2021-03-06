---
title       : "Course Project: Shiny Application and Reproducible Pitch"
subtitle    : "Volatility Effect on Investments"
author      : "Anastasios Mallis"
job         : "May 2016"
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

### Summary

This application is a simple example of the effect of uncertainty on investemnts.


The example here is a retirement account.
 

The user can chose the monthly contributions, the ages between these contriutions will occur, the average growth in value of the investments and finaly the risk (as volatility).
 
 
The app will output a sample path of the retirement account value, based on these inputs, along with the value of the contributions and the investment value if there was no uncertainty (volatility).

This applications was made as the final project for the Coursera course: Developing Data Products.

The choice of topic mas made mostly to illustrate the functionality of a Shiny app in R, with calculations done based on user inputs, and less to show the power of a certain prediction algorithm.

---

### Motivation

Most of the times we are illustrated of what will happen to a retirement account based on the average predictions, or on an average of many simulations.

In reality we will experience only one future and not an average of many futures.

This app shows a potenital path of the value of the account, based on the user inputs, in comparison to the value of the contributions and the value of the account if there was no uncertainty (no volatility).

---

### Theory and assumptions

The simulations are based on the following assumptions:

1. The contributions are made on a monthly basis.
2. The monthly contributions remain the same during the relevant period (this assumption was made to simplify the app).
3. Average Growth of the investments (excluding contributions) and Volatility remain constant during the relevant period (this assumption was made to simplify the app, in reality there may be periods of higher and lower market volatility).
4. Investment returns follow a normal distribution, investment values follow a lognormal distribution.

---

### How it works

The user inputs the data through the user interface and the s
The calculated paths are made based on the assumption that investment values follow a geometric brownian motion (Markov Chain of lognormal distributions)

```r
growth <- 0.03;
volatility <- 0.2;
starting_value <- 100;
time <-10;

end_value<-starting_value*exp((growth-(volatility^2)/2)*time+volatility*sqrt(time)**rnorm(10));
end_value
```

```
##  [1] 120.2811 131.0507 148.8665 157.2132 125.2786 130.9285 122.2507
##  [8] 118.2666 168.1807 310.6309
```
The above code illustrates the principle under which the simulations were made. 10 different simulations yield 10 different end values.

