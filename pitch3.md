

========================================================
# Course Project: Shiny Application and Reproducible Pitch
## Volatility Effect on Investments
###### Anastasios Mallis
###### May 2016

========================================================
### Summary

This application is a simple example of the effect of uncertainty on investments.
The example here is a retirement account.
The user can chose the monthly contributions, the ages between these contributions will occur, the average growth in value of the investments and finally the risk (as volatility).
The app will output a sample path of the retirement account value, based on these inputs, along with the value of the contributions and the investment value if there was no uncertainty (volatility).

This applications was made as the final project for the Coursera course: Developing Data Products.
The choice of topic mas made mostly to illustrate the functionality of a Shiny app in R, with calculations done based on user inputs, and less to show the power of a certain prediction algorithm.

========================================================
### Motivation

Most of the times we are illustrated of what will happen to a retirement account based on the average predictions, or on an average of many simulations.

In reality we will experience only one future and not an average of many futures.

This app shows a potential path of the value of the account, based on the user inputs, in comparison to the value of the contributions and the value of the account if there was no uncertainty (no volatility).

========================================================
### Theory and assumptions

The simulations are based on the following assumptions:

1. The contributions are made on a monthly basis.

2. The monthly contributions remain the same during the relevant period (this assumption was made to simplify the app).

3. Average Growth of the investments (excluding contributions) and Volatility remain constant during the relevant period (this assumption was made to simplify the app, in reality there may be periods of higher and lower market volatility).

4. Investment returns follow a normal distribution, investment values follow a log-normal distribution.

=======================================================
### How it works

See bellow a sample simulation for a 10-year time-step.

```r
growth <- 0.03;        volatility <- 0.2;
starting_value <- 100;  time <-10;

end_value<-starting_value*exp((growth-(volatility^2)/2)*time+volatility*sqrt(time)**rnorm(10));
end_value
```

```
 [1]  176.1356  121.6755 7507.0406  475.0666  116.9720  166.1084  335.8752
 [8]  117.8040  173.9116  151.6657
```
The above code illustrates the principle under which the simulations were made. 10 different simulations yield 10 different end values.



