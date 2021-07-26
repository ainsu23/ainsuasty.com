library(dplyr)
library(rvest)
library(stringr)

#### Web scrapping ####
Base<-readxl::read_excel(glue::glue("{here::here('datos')}/50_Mejores_Canciones_Latinas.xlsx"))

# Now go to these pages and scrape the text necessary to
# build a corpus

tmpResult <- vector()

for (ii in 1:nrow(Base)) {
  tmpResult <- read_html(as.character(Base[ii,5])) %>% 
    html_nodes(".entry-content p") %>% html_text()
  
  # Get rid of elements that are a blank line
  tmpResult <- tmpResult[3:length(tmpResult)-3]
  
  # Get rid of elements that begin with a newline character "\n"
  newlines_begin <- sum(grepl("^\n",tmpResult))
  
  if (newlines_begin > 0) {
    tmpResult <- tmpResult[-grep("^\n",tmpResult)]
  }
  
  
  tmpResult <- paste(tmpResult,collapse=" ") 
  Base[ii,"Letra"] <- tmpResult
  
}
