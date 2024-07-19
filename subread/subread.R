library(Rsubread)

# Set working directory
setwd("/home/user/scratch/workspace_directory")

files <- list.files(path = "./results/star_salmon/",
	pattern="*sorted.bam$",
	all.files=FALSE,
	full.names=TRUE,
	recursive=FALSE,
	ignore.case=TRUE)

counts <- featureCounts(files, annot.inbuilt="hg38",isPairedEnd=TRUE, nthreads= 32)

dir.create("./subread")
save.image(file = "./subread/FeatCounts_Rsub.RData")
