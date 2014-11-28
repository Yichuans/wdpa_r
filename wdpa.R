# added some comments
# added some more text in Windows git 
library("Cairo", lib.loc="C:/Users/yichuans/Documents/R/win-library/3.0")
library(RODBC)
library(ggplot2)
# set up environment ----
setwd('D:/Yichuan/WDPA_quality')

source('mytheme.r')

# Get odbc connection ----
myconn = odbcConnect('wh')
pa_stats = sqlFetch(myconn, 'wdpa.t_wdpa_summary')
close(myconn)
a = xyplot(log(n_points)~log(area)|desig_type, data=pa_stats, 
           par.settings = mycolortheme)
b = qplot(x=log(n_points), y=log(area), data=pa_stats, facets=.~desig_type)
b = qplot(x=log(n_points), y=log(area), data=pa_stats, facets=.~desig_type, geom='smooth', alpha=0.5)


# return sample_df
sample_df = function(df, size){
  return(df[sample(1:dim(df)[1], size),])
}

# use sqldf so that sql can be used to easily manipulate data
a = sqldf("select desig_type, iucn_cat, count(*) `desig_count` from pa_stats group by desig_type, iucn_cat")

# tree map
treemap(a, index=c('desig_type', 'iucn_cat'), vSize='desig_count', type='categorical', vColor='iucn_cat', palette='Accent', force.print.labels=T, border.col=c('black','white'), fontsize.labels=c(18,12))



