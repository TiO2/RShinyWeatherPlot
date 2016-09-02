library(shiny)
library(ggplot2)
library(weatherData)
#library(colorRamps)
#library(RColorBrewer)

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {  

  formulaText <- reactive({
    paste("气象站代码 Weather Station Code:", input$City)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  output$Plot = renderPlot({    
    StationCode <- input$City
    
    d <- as.POSIXlt(Sys.Date())
    d$year <- d$year-1 # get the date one year ago
    startDate = as.Date(d)    
    # download data:   
    data1 = getWeatherForDate(StationCode, startDate, end_date=Sys.Date())
    # function for temperature unit conversions    
    transformTemp = function(x) round((x-32)*5/9,2) 
    
    # based on the temperature unit chosen, (C is the default)
    if (input$radio == 1) {
    data1$Max_TemperatureC =  transformTemp(data1$Max_TemperatureF)
    data1$Mean_TemperatureC =  transformTemp( data1$Mean_TemperatureF)
    data1$Min_TemperatureC =  transformTemp(data1$Min_TemperatureF)
    
    data1=data1[,c(1,5,6,7)]
    }
    #else data1=data1[,c(1,2,3,4)]
    
    #data=as.data.frame(data)
    
    #factor(data$Date$mon, levels=unique(data$Date$mon), ordered=F)
    
    #extract the month name
    data1$month = strftime(strptime(as.character(data1$Date),format="%Y-%m-%d"),"%B") 
    
    data1 <<- data1
    # to let ggplot2 able to find the data, otherwise there's error
  
    gg_color_hue <- function(n) {
      hues = seq(15, 375, length=n+1)
      hcl(h=hues, l=65, c=100)[1:n]
    }
    
    ggplotColours <- function(n=6, h=c(0, 360) +15){
      if ((diff(h)%%360) < 1) h[2] <- h[2] - 360/n
      hcl(h = (seq(h[1], h[2], length = n)), c = 100, l = 65)
    }

    myColor = c("#00B4F0", "#00BFC4","#00C08B", "#00BA38",
                "#619CFF", "#C77CFF", "#F564E3", "#FF64B0", 
                "#F8766D", "#DE8C00", "#B79F00", "#7CAE00")
    
    aaaa = sprintf("%s daily temperatures for your selected city (2013-2014)","Averaged")
    theYLabel = sprintf("Mean Temperature (%s)", ifelse((input$radio==1),'C','F'))
    
    # color fill based on the month:
    ggplot(data1,aes(x=Date,y=data1[,3],fill=factor(data1$month, levels=unique(data1$month), ordered=F)))+geom_bar(stat="identity")+
      xlab("Date(One year (365 days) ago -- Present)") +
      ylab(theYLabel)+
      labs(fill= "Month")+
      ggtitle(aaaa)+ scale_fill_manual(values = myColor)
        
  }) 
  
})
