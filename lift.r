library(liftOver)
library(RCurl)

args <- commandArgs(trailingOnly = TRUE)
study <- args[1]

#Read data
df <- read.csv(paste0("from_R/",study,"/mutations.txt"), sep="\t")
df$chr[df$chr==23]="X"

#Convert to GRanges
dfg <- makeGRangesFromDataFrame(df, keep.extra.columns=T, start.field="startPosition", end.field="endPosition")

#Import it
ch = import.chain("chain/hg19ToHg38.over.chain")

#Add missing infos to data
seqlevelsStyle(dfg) = "UCSC"

#Liftover
dfg_new <- liftOver(dfg, ch)
df_new <- data.frame(dfg_new)

#save lifted data
dir.create("lifted")
dir.create(paste0("lifted/",study))
write.table(file=paste0("lifted/",study,"/mutations.txt"), df_new, row.names=T, quote=F, sep='\t')
