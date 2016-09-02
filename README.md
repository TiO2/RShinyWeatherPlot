An example R Shiny app to plot the weather data
===================================================

R + Shiny + weatherData
------------------------
The idea to use the wonderful pakage [weatherData](http://ram-n.github.io/weatherData/) to Download the weather data for a selected city and plot its temperature history. The ploting will then be rendered on html page. 

Live example is on <a href="https://pm2014.shinyapps.io/temperaturePlot/" target="_blank">Here (Hosted on Rstudio)</a>.

Required Packages
------------------
    Shiny
    ggplot2
    weatherData
    shinythemes



Change history
---------------
As of 9/2/2016, the weatherData package on CRAN gives error. Need to install the development version from github: 

```
install.packages("devtools")
library("devtools")
install_github("Ram-N/weatherData")
```


License
--------
GNU GPL v2.0


