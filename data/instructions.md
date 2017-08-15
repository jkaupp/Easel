# About Easel
Data visualization can be a powerful tool for analyzing and communicating data. However, the overwhelming diversity of options for visualization make it difficult to know how to most effectively visualize data given a specific task. Easel, a visualization recommendation system, was built in response to this problem, specifically for university educators and education support staff looking to improve their visualization techniques of educational data. Its purpose is two-fold: 

* Guide a user towards well-formed questions regarding your educational data.
* Provide recommendations for visualizations that will help answer those questions.

The recommended visualizations were created using a design processes and principles outlined in visualization literature, largely from [Munzer's Visualization Analysis and Design](http://www.cs.ubc.ca/~tmm/vadbook/). We repurposed a visualization selection methodology for the context of education, which can be found by clicking the Selection Process option above along with examples of its usage.


# Easel Instructions 
Click the Easel button above to navigate to the Visualization Recommendation System. Through research, we were able to gather a set of common data-questions that educators were looking to have answered with educational data. The drop-down navigation options will  guide you towards a specifically worded data-question. Once you have reached a data-question, you will be provided with following: 

1. A recommended visualization with a description of how to interpret it. 
2. Code in the statistics language R that we used to build the visualization. 
3. A view of the input data we used to create the visualization. 

If none of the provided questions suit your needs, you can design your own visualization using the process by which these recommended visualizations were chosen. You can find it by clicking the Selection Process option above. 

*Note*: The recommendations we provide are only meant to be an initial step, to broaden the scope of visualizations that are being considered in the educational space. We do provide example code, but creating a visualization for your specific data set and purpose will require an understanding of the available data and what software tools you use to create visualizations. The examples we provide are made using the statistical language R. Below, you can find resources on learning R and how to create digital visualizations with the provided examples. 

Some of the code examples also provide sample code to make the visualization interactive using [Plot.ly](https://plot.ly/r/). To use this, you will wanto use the plot.ly library along with the code that has been commented out. 

# R Resources
- [RStudio Resource List](https://www.rstudio.com/online-learning/#R): A guided list of resources of how to get started with R and RStudio, the industry standard IDE for R. 
- [R for Data Science](http://r4ds.had.co.nz/index.html): Probably the best single resource to learn about how to use R for statistics and data manipulation purposes, with a large section dedicated to using R for visualizations. 
- [RStudio Cheatsheets](https://www.rstudio.com/resources/cheatsheets/): A handy reference sheet to use when trying to write or read R code. 
- [ggplot2 Reference Documentation](http://ggplot2.tidyverse.org/reference/): The refernece documentation for ggplot2, the visualization library used in all Easel sample code.
- [ggplot2 Presentation](http://ggplot2.org/resources/2007-vanderbilt.pdf): The slides from an hourlong presentation given at Vanderbilt, 2007. It functions as a great, quick resource to get started with ggplot2 if you already know R. ([Accompanied code](http://ggplot2.org/resources/the-grammar.r)). 
- [R Graphics Cookbook](https://www.amazon.com/dp/1449316956/ref=cm_sw_su_dp?tag=ggplot2-20): A set of recipes to solve common graphics problems. This book is recommended as the best way to start making standard graphics with ggplot2 as quickly as possible.
- [Plot.ly](https://plot.ly/r/): The reference documentation to use Plot.ly in R; our recommended way to make a visualizations interactive. 