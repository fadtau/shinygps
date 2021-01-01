library(shinydashboard)
library(plotly)

ui <- dashboardPage(
    dashboardHeader(title = "Google Play Store Apps Dashboard"),
    dashboardSidebar(
        sidebarMenu(
            menuItem(text = "Overview",tabName = "pertama",icon = icon("book")),
            menuItem(text = "App Rate",tabName = "kedua",icon = icon("map")),
            menuItem(text = "App Size",tabName = "ketiga",icon = icon("map"))
        )
    ),
    dashboardBody(
        tabItems(
            #Tab Overview
            tabItem(tabName = "pertama", 
                    fluidPage(
                        fluidRow(
                            # Dibuat beberapa column agar teks bisa berada ditengah dan tidak memanjang sampai ujung body
                            column(width = 2),
                            column(width = 8,
                                   # align = "center" untuk membuat posisi teks center
                                   tags$h2("Greetings!",align="center"),
                                   tags$h4("The Play Store apps data has enormous potential to drive app-making businesses to success. Actionable insights can be drawn for developers to work on and capture the Android market!I want to show what's the most popular categories by looking on the installation frequency,how's the application rating, and what's the ideal size of an app to make by categories.",align="center")),
                            column(width = 2)
                        ),
                        tags$br(),
                        fluidRow(box(width = 8,title = "Top 10 Most Popular Category",status = "info",solidHeader = T,footer = "GAMES is the most popular categories which has 13 Billion+ users. It means people love to download & play GAMES Categories",
                                    plotlyOutput(outputId = "plot1")),
                                box(width = 4,tags$h3("Expectation"),tags$h4("The Dashboard is created as a medium of visualization for android start up entrepreneur and play store it self for making right choices either as business decisions or market decisions for entrepreneur. All of this insights are expected to be clear in way to creat apps that relevant with users. "))),
                        fluidRow(box(width = 12,title = "Total Apps per Category",status = "info",solidHeader = T,footer = "If we want to be in a small market competition, BEAUTY Category will be the right place since it only has 53 competitors app",
                                    plotlyOutput(outputId = "plot2"))),
                        fluidRow(box(width = 12,title = "Install Ratio per App",status = "info",solidHeader = T,footer = "Total Install Expectation of an app in each category",
                                     plotlyOutput(outputId = "plot3")))
                        
                                 
                        
                            
                        )
                        
                        
                    ),
            #Tab Rates
            tabItem(tabName = "kedua",
                    fluidPage(
                        fluidRow(
                            column(width = 12,
                                    box(width = 12,title = "Apps Rate Distribution",solidHeader = T,status = "primary",
                                    sliderInput(inputId = "bins_1",label = "Bins:",min = 2,max = 50,value = 30),
                                    plotOutput(outputId = "plot4")))
                            
                        ),
                        fluidRow(
                            column(width = 9,
                                   box(width = 12,title = "Total Apps per Category",solidHeader = T,status = "primary",
                                       plotlyOutput("plot5"))),
                            
                            column(width = 3,
                                   box(width = 12,title = "Plot Settings",status = "info",
                                       radioButtons(inputId = "type_select",label = "Select App Type:",choices = c("Free","Paid"),selected = "Free"),
                                       sliderInput(inputId = "rate",label = "Filter App Rate",
                                                   min = 0,max = 5,value = range(gplay$Rating))
                                       )
                            
                        )
                        
                        )
                                   
                            
                                     
                        )
                    
            ),
            tabItem(tabName = "ketiga",
                    fluidPage(
                        fluidRow(
                            column(width = 2),
                            column(width = 8,
                                   # align = "center" untuk membuat posisi teks center
                                   tags$h2("Greetings!",align="center"),
                                   tags$h4("The Play Store apps data has enormous potential to drive app-making businesses to success. Actionable insights can be drawn for developers to work on and capture the Android market!I want to show what's the most popular categories by looking on the installation frequency,how's the application rating, and what's the ideal size of an app to make by categories.",align="center")),
                            column(width = 2)
                        ),
                        fluidRow(box(width = 12,title = "Apps Size Distribution based on Top 10 Most Popular Categories",status = "info",solidHeader = T,
                                     plotlyOutput(outputId = "plot7")))
                            
                        )
                    )
                
            )
    )
)


