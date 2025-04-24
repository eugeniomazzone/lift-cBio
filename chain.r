library(RCurl)

#Download chain file
dir.create("chain")
URL <- "https://hgdownload.soe.ucsc.edu/goldenPath/hg38/liftOver/hg38ToHg19.over.chain.gz"
download.file(URL, destfile = "chain/hg38ToHg19.over.chain.gz", method="curl")

# Unzip it
system("gzip -d chain/hg38ToHg19.over.chain.gz")
