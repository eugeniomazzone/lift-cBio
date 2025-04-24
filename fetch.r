library(cbioportalR)

args <- commandArgs(trailingOnly = TRUE)
study <- args[1]

#Set env variables
set_cbioportal_db(db = "public")

#Look at study metadata
get_study_info(study) %>% t()

#Get data for selected study
df <- get_genetics_by_study(study_id = study)

#select only the mutations
mut <- data.frame(df$mutation)
df <- NULL

#Saving the data for liftover
dir.create("from_R")
dir.create(paste0("from_R/",study))
write.table(file=paste0("from_R/",study,"/mutations.txt"), mut, row.names=T, quote=F, sep='\t')
