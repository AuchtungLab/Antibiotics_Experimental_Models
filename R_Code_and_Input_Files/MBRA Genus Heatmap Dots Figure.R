#Convert to List
library("plyr")
Rotate <- read.table(file="/Users/tommyauchtung/Desktop/Rotate.txt", header = TRUE, row.names = 1, sep = "\t")
List <- ldply (Rotate, data.frame)
write.table(List, file = "/Users/tommyauchtung/Desktop/List.txt", sep = "\t", row.names = TRUE, col.names = NA)
#In Excel, Add back Taxa column and remove #s from antibiotic column
#Clean up taxonomic names and determine order that want in figure
#Determine order of antibiotics to show in figure
#Change non-signifant stats to q = 0.5, so can see trend
#Log10 transform stats
#Make extremely significant stats log10 = 4.3 so don't skew plot
#Add column for denoting taxa that were significant by both statistical steps
#Run the code below:

################ Bioreactors Genus FIGURE ######################################################################################################
library("ggplot2"); packageVersion("ggplot2")
ListClean <- read.table(file="/Users/tommyauchtung/Desktop/ListClean.txt", header = TRUE, sep = "\t")
#Set taxonomy order
ListClean$Taxa <- reorder(ListClean$Taxa, ListClean$TaxaOrder2)
#Set antibiotic order
ListClean$Antibiotic <- reorder(ListClean$Antibiotic, ListClean$AntibioticOrder1)
#Make plot
ggplot(ListClean, aes(x=Antibiotic, y=Taxa)) +
  geom_point(aes(size=SigCircle)) +
  geom_count(aes(color = Change, size = LogStatsNoExtreme, group = 1)) +
  scale_color_gradient2(midpoint = 0, low = "blue", mid = "white", high = "red") +
  scale_size_area(max_size = 25) +
  theme_bw() +
  theme(axis.text.x = element_text(color="black", angle=-30,hjust=0,vjust=1,size=40),
        axis.text.y = element_text(color="black", size=40),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        line = element_blank(),
        panel.grid = element_blank(),
        panel.border = element_blank(),
        legend.title = element_blank(),
        legend.position = "none",
        legend.key.size=unit(4,'cm'),
        plot.margin=margin(l=0,b=0,t=0,r=150,unit = "pt")) 
#EXPORT AS 30 x 38 inches (pdf)
#Make select font italicized in Illustrator
#Then do final labeling in Photoshop (import at size 3000)
#Export figure from here again WITH legend (#legend.position = "none") to get color gradient
