library(tidyverse)
files <- list.files(pattern = ".fastq.gz")

df <- tibble(filename = files)
df$file_to_split <- df$filename
df <- df %>% separate(file_to_split, c("sample", "SeqID", "Read", "lane", "seq.run", "Extension"), extra = "merge")

# Pivot the data
df_wide <- df %>%
  pivot_wider(names_from = Read, values_from = filename, names_prefix = "fastq_") %>%
  rename(fastq_1 = fastq_R1, fastq_2 = fastq_R2)
df_wide$strandedness <- rep("auto", length(df_wide$sample))
# select names
df_final <- df_wide %>%
  select(c(sample, fastq_1, fastq_2, strandedness, seq.run, lane))

# Write the output data frame to a CSV file
write.csv(df_final, "samplesheet.csv", row.names = FALSE)
