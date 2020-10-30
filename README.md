# Multiple testing operator

##### Description

The `multiple_testing_operator` allows one to correct for multiple testing by computing an adjusted p-value.

##### Usage

Input projection|.
---|---
`y-axis`        | numeric, p-values to adjust

Input parameters|.
---|---
`method`        | any of "holm", "hochberg", "hommel", "bonferroni", "BH", "BY", or "qvalue"

Output relations|.
---|---
`p_adjusted`        | adjusted p-value
`neglog10_p_adjusted`        | -log10(p_adjusted)

##### Details

Based on the methods implemented in the R function [p.adjust](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/p.adjust.html). The `qvalue` method is based on the `qvalue` function from the [qvalue Bioconductor package](https://www.bioconductor.org/packages/release/bioc/html/qvalue.html).

##### See Also

[qqplot_operator](https://github.com/tercen/qqplot_operator)
