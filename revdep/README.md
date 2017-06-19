# Setup

## Platform

|setting  |value                        |
|:--------|:----------------------------|
|version  |R version 3.3.1 (2016-06-21) |
|system   |x86_64, darwin15.5.0         |
|ui       |RStudio (1.0.136)            |
|language |(EN)                         |
|collate  |en_US.UTF-8                  |
|tz       |America/Los_Angeles          |
|date     |2017-06-19                   |

## Packages

|package    |*  |version |date       |source                     |
|:----------|:--|:-------|:----------|:--------------------------|
|clipr      |*  |0.3.3   |2017-06-19 |local (mdlincoln/clipr@NA) |
|rstudioapi |   |0.6     |2016-06-27 |cran (@0.6)                |
|testthat   |   |1.0.2   |2016-04-23 |cran (@1.0.2)              |

# Check results

4 packages

|package   |version | errors| warnings| notes|
|:---------|:-------|------:|--------:|-----:|
|datapasta |2.0.0   |      0|        0|     0|
|reprex    |0.1.1   |      0|        0|     0|
|rio       |0.5.5   |      0|        0|     0|
|vegalite  |0.6.1   |      1|        0|     0|

## datapasta (2.0.0)
Maintainer: Miles McBain <miles.mcbain@gmail.com>  
Bug reports: https://github.com/milesmcbain/datapasta/issues

0 errors | 0 warnings | 0 notes

## reprex (0.1.1)
Maintainer: Jennifer Bryan <jenny.f.bryan@gmail.com>  
Bug reports: https://github.com/jennybc/reprex/issues

0 errors | 0 warnings | 0 notes

## rio (0.5.5)
Maintainer: Thomas J. Leeper <thosjleeper@gmail.com>  
Bug reports: https://github.com/leeper/rio/issues

0 errors | 0 warnings | 0 notes

## vegalite (0.6.1)
Maintainer: Bob Rudis <bob@rudis.net>  
Bug reports: https://github.com/hrbrmstr/vegalite/issues

1 error  | 0 warnings | 0 notes

```
checking examples ... ERROR
Running examples in ‘vegalite-Ex.R’ failed
The error most likely occurred in:

> base::assign(".ptime", proc.time(), pos = "CheckExEnv")
> ### Name: from_spec
> ### Title: Take a JSON Vega-Lite Spec and render as an htmlwidget
> ### Aliases: from_spec
> 
> ### ** Examples
> 
> from_spec("http://rud.is/dl/embedded.json")
Error in file(con, "r") : cannot open the connection
Calls: from_spec -> readLines -> file
Execution halted
```

