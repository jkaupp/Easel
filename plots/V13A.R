#Question: Which students are achieving a certain set of critieria in my course? 
#Summary of Student Data

#Get Data
PlotData <- readRDS(file.path("data", "V13A.rds"))

#Transofrm and Derive
PlotData <- PlotData %>%
            # Take advantage of na.rm in ggplot. 
            # 1 for 'positive' badges, 0 for neutral ones, and -1 for negative badges
            mutate(b_gpa=ifelse(GPA>3.5, 1,NaN),
                   b_time=ifelse(Test_Time>45,1,NaN),
                   b_citizen=ifelse(Citzenship!="Canada",0,NaN),
                   b_birth=ifelse(as.numeric(substring(Birthdate,1,4)) < 1994, 0, NaN), #Check sub-string
                   b_mastery=ifelse(Test_Mastery=="Below Basic",-1,NaN)) %>%
            select(Student_ID, starts_with("b_"))   

#Transform to longform data
PlotData_L <- PlotData %>%
              melt(id.vars = "Student_ID", value.name="Badge")

#Name conditions
xlabels <- c("GPA>3.5", "Test Time > 45", "Non-Canadian Citizen", "Birth < 1994", "Below Basic Mastery")

#Plot Data
g <- ggplot(PlotData_L, mapping = aes(x=variable, y = Student_ID)) + 
       geom_point(mapping=aes(color=Badge, shape = variable), size = 2) + 
       scale_shape_manual(values=c(15, 16, 17, 17, 19), labels=xlabels, name ="Badge") +
       scale_x_discrete(labels=xlabels) + 
       theme(axis.text.x = element_blank(), 
             axis.ticks.x = element_blank(), axis.title.x = element_blank(),  
             legend.position = "right", 
             panel.background = element_rect(fill = "white", color="grey"),
             panel.grid.major.y = element_line(color="grey")) + 
       scale_color_gradient2(na.value="white", guide=FALSE,
                             low = "#FC8D59", mid = "blue", high = "#91CF60") + 
       labs(y = "Student ID") +
       coord_fixed(ratio = 0.8)

plot(g)
