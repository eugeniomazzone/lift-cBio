library(RCurl)

#Download chain file
dir.create("chain")
URL <- "https://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz"
download.file(URL, destfile = "chain/hg19ToHg38.over.chain.gz", method="curl")

# Unzip it
system("gzip -d chain/hg19ToHg38.over.chain.gz")
