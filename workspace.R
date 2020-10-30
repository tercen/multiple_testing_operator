library(tercen)
library(dplyr)
library(qvalue)

options("tercen.workflowId" = "d330322c43363eb4f9b27738ef0042b9")
options("tercen.stepId"     = "7561ec60-1b7c-4fc5-bc34-2cdf50840412")

getOption("tercen.workflowId")
getOption("tercen.stepId")

ctx <- tercenCtx()

method <- "bonferroni" #c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "qvalue")
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
