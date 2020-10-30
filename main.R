library(tercen)
library(dplyr)
library(qvalue)

ctx <- tercenCtx()

method <- "bonferroni"
if(!is.null(ctx$op.value("method"))) method <- ctx$op.value("method")

correct.pval <- function(pval, method) {
  if(method != "qvalue") {
    out <- p.adjust(pval, method)
  } else {
    out <- qvalue(pval)$qvalues
  }
  return(out)
}

df <- ctx %>% 
  select(.y) %>% 
  transmute(p_adjusted = correct.pval(.y, method)) %>% 
  mutate(neglog10_p_adjusted = -log10(p_adjusted)) %>% 
  ctx$addNamespace() %>%
  ctx$save()
