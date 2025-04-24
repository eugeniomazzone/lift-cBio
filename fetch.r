library(cbioportalR)

#Set env variables
set_cbioportal_db(db = "public")

#Look at study metadata
get_study_info("acc_tcga") %>% t()

#Get data for selected study
df <- get_genetics_by_study(study_id = "acc_tcga")

#select only the mutations
mut <- data.frame(df$mutation)
df <- NULL

#Saving the data for liftover
dir.create("from_R")
dir.create("from_R/acc_tcga")
write.table(file="from_R/acc_tcga/mutations.txt", mut, row.names=T, quote=F, sep='\t')
