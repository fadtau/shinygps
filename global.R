#Library
library(dplyr)
library(readr)
library(ggplot2)
library(plotly)
library(hablar)
library(lubridate)
library(forcats)

#Theme
theme_algoritma <- theme(legend.key = element_rect(fill="black"),
                         legend.background = element_rect(color="white", fill="#263238"),
                         plot.subtitle = element_text(size=6, color="white"),
                         panel.background = element_rect(fill="#dddddd"),
                         panel.border = element_rect(fill=NA),
                         panel.grid.minor.x = element_blank(),
                         panel.grid.major.x = element_blank(),
                         panel.grid.major.y = element_line(color="darkgrey", linetype=2),
                         panel.grid.minor.y = element_blank(),
                         plot.background = element_rect(fill="#263238"),
                         text = element_text(color="white"),
                         axis.text = element_text(color="white"))

#Setting
options(scipen = 100)

#Function to convert Kilobytes and Megabytes
convb <- function(x){
  ptn <- "(\\d*(.\\d+)*)(.*)"
  num  <- as.numeric(sub(ptn, "\\1", x))
  unit <- sub(ptn, "\\3", x)             
  unit[unit==""] <- "1" 
  
  mult <- c("1"=1, "k"=1, "M"=1000, "G"=1024^3)
  num * unname(mult[unit])
}

#Read Data
gplay <- read_csv("googleplaystore.csv")
#Data Cleaning & Data Wrangling
gplay <- gplay %>% 
  mutate(Category = as.factor(Category),
         Type = as.factor(Type),
         Genres = as.factor(Genres),
         `Content Rating` = as.factor(`Content Rating`),
         `Last Updated` = mdy(`Last Updated`)) %>% 
  distinct() %>% #Delete Duplicate rows
  distinct(App,.keep_all = TRUE) #Delete Duplicate Rows with same apps condition
gplay$Installs <- gsub(",+","",gplay$Installs) #Remove , in Installs Columns
gplay$Installs <- gsub("\\+","",gplay$Installs) #Remove + in Installs Columns
gplay$Installs <- as.numeric(gplay$Installs)
gplay <- gplay %>% 
  subset(App!="Life Made WI-Fi Touchscreen Photo Frame") #Junk Row

data6 <- gplay %>% 
  filter(Size != "Varies with device") %>% 
  mutate(Size = convb(Size))

source("ui.R")
source("server.R")

shinyApp(ui = ui,server = server)

# # where to learn next
# open dashbooard_guide.html
# Shiny bookdown tutorial: https://bookdown.org/weicheng/shinyTutorial/ui.html
# Shiny video basic tutorial: https://shiny.rstudio.com/tutorial/
# Shiny example showcase: https://shiny.rstudio.com/gallery/
# Shiny input widget: https://shiny.rstudio.com/gallery/widget-gallery.html
# Shiny leaflet: https://rstudio.github.io/leaflet/shiny.html
# shinydashboard structure & apperance: https://rstudio.github.io/shinydashboard/structure.html
# gganimate: https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/

# FAQ dan helper: https://askalgo.netlify.app/
# visit mas Joe on github, rpubs, and medium for more article
# https://github.com/western11
# https://rpubs.com/jojoecp
# https://medium.com/@joenathanchristian
