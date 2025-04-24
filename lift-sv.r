library(liftOver)
library(RCurl)

args <- commandArgs(trailingOnly = TRUE)
study <- args[1]

#Read data
df <- read.csv(paste0("from_R/",study,"/structural_variant.txt"), sep="\t")
df$site1Chromosome[df$site1Chromosome==23]="X"
df$site2Chromosome[df$site2Chromosome==23]="X"

#Convert to GRanges
dfg1 <- makeGRangesFromDataFrame(df, keep.extra.columns=F, seqnames.field='site1Chromosome', start.field="site1Position", end.field="site1Position", )
dfg2 <- makeGRangesFromDataFrame(df, keep.extra.columns=F, seqnames.field='site2Chromosome', start.field="site2Position", end.field="site2Position", )

#Index rows

nn <- 1:nrow(df)
dfg1$name <- nn
dfg2$name <- nn

#Import it
ch = import.chain("chain/hg38ToHg19.over.chain")

#Add missing infos to data
seqlevelsStyle(dfg1) = "UCSC"
seqlevelsStyle(dfg2) = "UCSC"

#Liftover
dfg1_new <- liftOver(dfg1, ch)
df1_new <- data.frame(dfg1_new)

dfg2_new <- liftOver(dfg2, ch)
df2_new <- data.frame(dfg2_new)

df_merge <- merge(x=df1_new,y=df2_new,by="name")

#Update coordinates in original file

df_new <-df[df_merge$name,]

df_new$site1Position <- df_merge$start.x
df_new$site2Position <- df_merge$start.y

df_new$site1Chromosome <- df_merge$seqnames.x
df_new$site2Chromosome <- df_merge$seqnames.y

#save lifted data
dir.create("lifted")
dir.create(paste0("lifted/",study))
write.table(file=paste0("lifted/",study,"/structural_variant.txt"), df_new, row.names=T, quote=F, sep='\t')
