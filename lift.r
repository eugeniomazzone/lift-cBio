library(liftOver)
library(RCurl)

#Read data
df <- read.csv("from_R/acc_tcga/mutations.txt", sep="\t")
df$chr[df$chr==23]="X"

#Convert to GRanges
dfg <- makeGRangesFromDataFrame(df, keep.extra.columns=T, start.field="startPosition", end.field="endPosition")

#Download chain file
dir.create("chain")
URL <- "https://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz"
download.file(URL, destfile = "chain/hg19ToHg38.over.chain.gz", method="curl")

# Unzip it
system("gzip -d chain/hg19ToHg38.over.chain.gz")

#Import it
ch = import.chain("chain/hg19ToHg38.over.chain")

#Add missing infos to data
seqlevelsStyle(dfg) = "UCSC"

#Liftover
dfg_new <- liftOver(dfg, ch)
df_new <- data.frame(dfg_new)

#save lifted data
dir.create("lifted")
dir.create("lifted/acc_tcga")
write.table(file="lifted/acc_tcga/mutations.txt", df_new, row.names=T, quote=F, sep='\t')
