library(tercen)
library(dplyr)
library(qvalue)

ctx <- tercenCtx()

method <- ctx$op.value("method", as.character, "bonferroni")

correct.pval <- function(pval, method) {
  if(method != "qvalue") {
    out <- p.adjust(pval, method)
  } else {
    out <- qvalue(pval)$qvalues
  }
  return(out)
}

ctx %>% 
  select(.ci, .ri, .y) %>% 
  transmute(p_adjusted = correct.pval(.y, method)) %>% 
  mutate(neglog10_p_adjusted = -log10(p_adjusted)) %>% 
  ctx$addNamespace() %>%
  ctx$save()
