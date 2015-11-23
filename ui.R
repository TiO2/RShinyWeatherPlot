library(shiny)
library(shinythemes)

shinyUI(fluidPage( theme = shinytheme("cerulean"),
  pageWithSidebar(    
  # Application title
  headerPanel("城市日均温度纪录 Temperature Plot"),
  
  sidebarPanel(
    selectInput("City", "请选择城市(有中国的城市)并且稍等片刻 Select the City and Wait for few Seconds:",
                list("Boston" = "KBOS", 
                     "Seattle" = "KSEA",
                     "College Station" = "KCLL",
                     "Syracuse" = "KSYR",                      
                     "New York City" = "KJFK",
                     "Chicago"="KORD",
                     "Philadelphia"="KPHL",
                     "Baltimore"="BWI",                   
                     "San Francisco"="KSFO",
                     "北京"="ZBAA",
                     "南京"="ZSNJ",
                     "西安"="ZLXY",
                     "上海"="ZSSS",
                     "成都"="ZUUU",
                     "拉萨"="ZULS",
                     "海口"="ZGHK"),
                selected = NULL,
                multiple = FALSE),
        
    # radio buttons
    radioButtons("radio", label = h3("Select the temperature unit for ploting"),
                 choices = list("Celsius" = 1, "Fahrenheit" = 2 ), selected = 1),
    hr(),
        
    helpText("Technologies: R, shiny, ggplot2, weatherData"),
    
    helpText("联系：utmostvalue  # 163.com"),
    
    helpText(a("Source Code is on Github",href="https://github.com/TiO2/RShinyWeatherPlot",target="_blank")),
    
    helpText(a("作者Github链接",href="https://github.com/TiO2",target="_blank")),
    
    helpText("To do list: 1.加一个城市的搜索功能？ 2.HTML CSS 的设计美化。")
  
  ),
  
  mainPanel(
  
    tags$head(includeScript("google-analytics.js")),
    # google analytics script
    
    h3(textOutput("caption")),    
        
    p(sprintf("今天的日期是 What day is it today? It's %s",Sys.Date())),
    
    hr(),
    
    plotOutput("Plot")
    
    )
  )
))
