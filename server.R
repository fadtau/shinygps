server <- function(input,output){
    
    output$plot1 <- renderPlotly({
        plot1 <- gplay %>% 
            group_by(Category) %>% 
            summarise(Total_Install= sum(Installs))%>% 
            mutate(Total_Install = Total_Install/1000000000) %>% 
            mutate(Total_Install = round(Total_Install,2)) %>%
            mutate(ket1 = paste(Category,"<br>Total Installs :",Total_Install,"Billions+")) %>% 
            arrange(-Total_Install) %>% 
            head(10) %>% 
            mutate(Category = fct_reorder(Category, Total_Install)) %>%
            ggplot(aes(x = Category,y= Total_Install,fill=Category,text = ket1))+
            geom_bar(stat = "identity")+
            ggtitle("Top 10 Most Popular Categories on Google Play Store")+
            ylab("Total Installations in Billions")+
            xlab("Categories")+
            coord_flip()+
            theme_algoritma
        
        ggplotly(plot1,tooltip = "text") %>% 
            config(displayModeBar = F)
        
    })
    
    output$plot2 <- renderPlotly({
        plot2 <- gplay %>% 
            group_by(Category) %>% 
            summarise(freq = n(),sum = sum(Installs)) %>% 
            mutate(Category = fct_reorder(Category, freq)) %>% 
            mutate(ket2 = paste(Category,"<br>Total Apps :",freq,"apps")) %>% 
            ggplot(aes(x = Category,y = freq,fill=Category,text=ket2))+
            geom_bar(stat = "identity")+
            ggtitle("Total Apps in Google Play Store")+
            coord_flip()+
            theme_algoritma
        
        ggplotly(plot2,tooltip = "text") %>% 
            config(displayModeBar = F)
    })
    
    output$plot3 <- renderPlotly({
        plot3 <- gplay %>% 
            group_by(Category) %>% 
            summarise(freq = n(),sum = sum(Installs)) %>% 
            mutate(install_ratio = sum/freq) %>% 
            mutate(round(install_ratio,digits = 3)) %>%
            mutate(ket3 = paste(Category,"<br>Installs Ratio:",install_ratio,"per application")) %>% 
            arrange(-install_ratio) %>% 
            head(10) %>% 
            mutate(Category = fct_reorder(Category, install_ratio)) %>% 
            ggplot(aes(x = Category,y = install_ratio,fill=Category,text=ket3))+
            geom_segment( aes(x=Category, xend=Category, y=0, yend=install_ratio)) +
            geom_point( size=3, color="red", fill=alpha("orange", 0.3), alpha=0.5, shape=21, stroke=2)+
            coord_flip()+
            theme_algoritma
        
        ggplotly(plot3,tooltip = "text") %>% 
            config(displayModeBar = F)
    })
    
    output$plot4 <- renderPlot({
        gplay %>% 
            ggplot(aes(x = Rating))+
            geom_histogram(bins = input$bins_1 )+
            xlab("Application Rating")+
            scale_x_continuous(labels = scales::dollar_format())+
            theme_algoritma
    })
    
    output$plot5 <- renderPlotly({
        plot5 <- gplay %>%
            na.omit(cols="Rating") %>% 
            filter(Type == input$type_select) %>% 
            filter(Rating >= input$rate[1] & Rating <= input$rate[2]) %>% 
            group_by(Category) %>% 
            summarise(freq = n()) %>% 
            arrange(-freq) %>% 
            head(10) %>% 
            mutate(Category = fct_reorder(Category, freq)) %>%
            mutate(ket7 = paste(Category,"<br>Total Apps :",freq)) %>% 
            ggplot(aes(x = Category,y = freq),text=ket7)+
            geom_col(show.legend = F) +
            scale_fill_gradient(low = "#020c38",high = "#0533ed") +
            coord_flip()+
            theme_algoritma +
            # disini judul plot dibuat dinamis sesuai dengan input yang dipilih
            labs(title = paste("Total",input$type_select,"Apps per Category"),
                 x = "Freq", y = "Category")
    })
    
    
    output$plot7 <- renderPlotly({
        plot7 <- gplay %>% 
            filter(Size != "Varies with device") %>% 
            mutate(Size = convb(Size)) %>%
            group_by(Category) %>% 
            filter(Category == c("GAME","COMMUNICATION","TOOLS","PRODUCTIVITY","SOCIAL","PHOTOGRAPHY","FAMILY","VIDEO_PLAYERS","TRAVEL_AND_LOCAL","NEWS_AND_MAGAZINES")) %>% 
            summarise(Total_Install= sum(Installs),Size=Size) %>% 
            arrange(-Total_Install) %>% 
            mutate(ket5 = paste(Category,"<br>Mean :",round(mean(Size),3),"Kb")) %>%
            ggplot(aes(x = Category,y = Size,fill=Category,text=ket5))+
            geom_boxplot()+
            stat_summary(fun.y=mean, geom="point", shape=20, size=3, color="red", fill="red") +
            coord_flip()+
            ylab("Apps Size in Kb")+
            xlab("Top 10 Most Popular Categories")+
            theme_algoritma
        
        ggplotly(plot7,tooltip = "text") %>% 
            config(displayModeBar = F)
    })
    
    #Function to convert Kilobytes and Megabytes
    convb <- function(x){
        ptn <- "(\\d*(.\\d+)*)(.*)"
        num  <- as.numeric(sub(ptn, "\\1", x))
        unit <- sub(ptn, "\\3", x)             
        unit[unit==""] <- "1" 
        
        mult <- c("1"=1, "k"=1, "M"=1000, "G"=1024^3)
        num * unname(mult[unit])
    }
}
    
    
    

