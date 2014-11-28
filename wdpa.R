# added some comments
library("Cairo", lib.loc="C:/Users/yichuans/Documents/R/win-library/3.0")
library(RODBC)
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

print(a)
print(b)


# return sample_df
sample_df = function(df, size){
  return(df[sample(1:dim(df)[1], size),])
}
