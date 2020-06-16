bb <- read.csv("~/pkgs2020/rdfp/data-raw/客户编码.txt", header=FALSE, stringsAsFactors=FALSE)
ncount <- nrow(bb)
data <-bb[6:ncount,]
View(data)
