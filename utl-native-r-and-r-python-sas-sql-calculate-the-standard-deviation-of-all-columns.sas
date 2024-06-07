%let pgm=utl-native-r-and-r-python-sas-sql-calculate-the-standard-deviation-of-all-columns;

Native r and r python sas sql calculate the standard deviation of all columns

I left out SAS non sql procs

  Four Solutions (plue
      1 r native
      2 r sql
      3 sas sgl
      4 python sql (panda sql does not support the standard devation you need to link ro a c dll)

github
https://tinyurl.com/f35k9zwu
https://github.com/rogerjdeangelis/utl-native-r-and-r-python-sas-sql-calculate-the-standard-deviation-of-all-columns

Missing sql functions in python pandasql (r has them built in)
For python you need to link to c:/temp/libsqlitefunctions.dll in
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories

More on the missing sql functions in Python on the end

Related repos

https://github.com/rogerjdeangelis/utl-missing-basic-math-and-stat-functions-in-python-sqlite3-sql
https://github.com/rogerjdeangelis/utl-adding-the-missing-math-stat-and-string-functions-to-python-sql-pandasql-sqllite3
https://github.com/rogerjdeangelis/utl-exporting-python-panda-dataframes-to-wps-r-using-a-shared-sqllite-database
https://github.com/rogerjdeangelis/utl-highlite-sas-dataset-and-view-the-table-in-excel-without-sas-access
https://github.com/rogerjdeangelis/utl-passing-r-python-and-sas-macro-vars-to-sqllite-interface-arguments
https://github.com/rogerjdeangelis/utl-python-very-simple-interactive-sqllite-dashboard-to-query-roger-deangelis-repositories
https://github.com/rogerjdeangelis/utl-r-python-sas-sqlite-subtracting-the-means-of-a-specific-column-from-other-columns
https://github.com/rogerjdeangelis/utl-sqlite-processing-in-python-with-added-math-and-stat-functions
https://github.com/rogerjdeangelis/utl-sqllite-working-with-dates-in-r-and-python
https://github.com/rogerjdeangelis/utl-passing-arguments-to-sqldf-using-wps-python-f-text-function
https://github.com/rogerjdeangelis/utl-passing-arguments-to-sqldf-wps-r-sql-functional-sql


/**************************************************************************************************************************/
/*                               |                                              |                                         */
/*        INPUT                  |      PROCESS                                 |      OUTPUT                             */
/*                               |                                              |                                         */
/*  1 NATIVE R                   |                                              |                                         */
/*                               |                                              |                                         */
/*                               |                                              |                                         */
/*  SD1.HAVE                     |  %utl_rbegin;                                | R                                       */
/*                               |  parmcards4;                                 | > want;                                 */
/*   AGE    HEIGHT    WEIGHT     |  library(haven)                              |      AGE    HEIGHT    WEIGHT            */
/*                               |  source("c:/temp/fn_tosas9.R")               | 1.492672  5.127075 22.773933            */
/*    14     69.0      112.5     |  have<-read_sas("d:/sd1/have.sas7bdat")      |                                         */
/*    13     56.5       84.0     |  want<-apply(have,2,sd);                     | SAS                                     */
/*    13     65.3       98.0     |  want;                                       |                                         */
/*    14     62.8      102.5     |  fn_tosas9(dataf=want);                      |   COL_0     COL_1                       */
/*    ....                       |  ;;;;                                        |                                         */
/*                               |  %utl_rend;                                  |   1.4927    AGE                         */
/*                               |                                              |   5.1271    HEIGHT                      */
/*                               |  libname tmp "c:/temp";                      |  22.7739    WEIGHT                      */
/*                               |  proc print data=tmp.want;                   |                                         */
/*                               |  run;quit;                                   |                                         */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                               |                                              |                                         */
/*  2 R SQL                      |                                              |                                         */
/*                               |                                              |                                         */
/*       same input              |   %utl_rbegin;                               | R                                       */
/*                               |   parmcards4;                                | > want;                                 */
/*                               |   library(haven)                             |      sdage    sdhgt    sdwgt            */
/*                               |   library(sqldf)                             | 1 1.492672 5.127075 22.77393            */
/*                               |   source("c:/temp/fn_tosas9.R")              |                                         */
/*                               |   have<-read_sas("d:/sd1/have.sas7bdat")     | SAS                                     */
/*                               |   have                                       |                                         */
/*                               |   want<-sqldf('                              | ROWNAMES   SDAGE      SDHGT      SDWGT  */
/*                               |     select                                   |                                         */
/*                               |         stdev(AGE)     as sdage              |     1     1.49267    5.12708    22.7739 */
/*                               |        ,stdev(HEIGHT)  as sdhgt              |                                         */
/*                               |        ,stdev(WEIGHT)  as sdwgt              |                                         */
/*                               |     from                                     |                                         */
/*                               |         have                                 |                                         */
/*                               |     ')                                       |                                         */
/*                               |   want;                                      |                                         */
/*                               |   fn_tosas9(dataf=want)                      |                                         */
/*                               |   ;;;;                                       |                                         */
/*                               |   %utl_rend;                                 |                                         */
/*                               |                                              |                                         */
/*                               |   libname tmp "c:/temp";                     |                                         */
/*                               |   proc print data=tmp.want;                  |                                         */
/*                               |   run;quit;                                  |                                         */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                               |                                              |                                         */
/*  3 SAS SQL                    |                                              | SAS                                     */
/*                               |   proc sql;                                  |                                         */
/*       same input              |    create                                    |  SDAGE      SDHGT      SDWGT            */
/*                               |       table want as                          |                                         */
/*                               |    select                                    | 1.49267    5.12708    22.7739           */
/*                               |        std(AGE)     as sdage                 |                                         */
/*                               |       ,std(HEIGHT)  as sdhgt                 |                                         */
/*                               |       ,std(WEIGHT)  as sdwgt                 |                                         */
/*                               |    from                                      |                                         */
/*                               |        sd1.have                              |                                         */
/*                               |   ;quit;                                     |                                         */
/*                               |                                              |                                         */
/*                               |   proc print data=want;                      |                                         */
/*                               |   run;quit;                                  |                                         */
/*                               |                                              |                                         */
/*-----------------------------------------------------------------------------------------------------------------------0*/
/*                               |                                              |                                         */
/*  4 python sql                 |   %utl_pybegin;                              | python                                  */
/*                               |   parmcards4;                                |       sdage     sdhgt      sdwgt        */
/*     same input                |   import os                                  | 0  1.492672  5.127075  22.773933        */
/*                               |   import sys                                 |                                         */
/*                               |   import subprocess                          | SAS                                     */
/*                               |   import time                                |                                         */
/*                               |   from os import path                        |   SDAGE      SDHGT      SDWGT           */
/*                               |   import pandas as pd                        |                                         */
/*                               |   import numpy as np                         |  1.49267    5.12708    22.7739          */
/*                               |   import pyreadstat as ps                    |                                         */
/*                               |   from pandasql import sqldf                 |                                         */
/*                               |   mysql = lambda q: sqldf(q, globals())      |                                         */
/*                               |   from pandasql import PandaSQL              |                                         */
/*                               |   pdsql = PandaSQL(persist=True)             |                                         */
/*                               |   sqlite3conn = \                            |                                         */
/*                               |    next(pdsql.conn.gen).connection.connection|                                         */
/*                               |   sqlite3conn.enable_load_extension(True)    |                                         */
/*                               |   sqlite3conn.load_extension \               |                                         */
/*                               |    ('c:/temp/libsqlitefunctions.dll')        |                                         */
/*                               |   mysql = lambda q: sqldf(q, globals())      |                                         */
/*                               |   have,meta=ps.read_sas7bdat \               |                                         */
/*                               |   ("d:/sd1/have.sas7bdat")                   |                                         */
/*                               |   print(have)                                |                                         */
/*                               |   want = pdsql('''                           |                                         */
/*                               |     select                                   |                                         */
/*                               |         stdev(AGE)     as sdage              |                                         */
/*                               |        ,stdev(HEIGHT)  as sdhgt              |                                         */
/*                               |        ,stdev(WEIGHT)  as sdwgt              |                                         */
/*                               |     from                                     |                                         */
/*                               |         have                                 |                                         */
/*                               |   ''')                                       |                                         */
/*                               |  print(want)                                 |                                         */
/*                               |  exec(open('c:/temp/fn_tosas9.py').read())   |                                         */
/*                               |  fn_tosas9(                                  |                                         */
/*                               |     want                                     |                                         */
/*                               |     ,dfstr="want"                            |                                         */
/*                               |     ,timeest=3                               |                                         */
/*                               |     )                                        |                                         */
/*                               |  ;;;;                                        |                                         */
/*                               |  %utl_pyend;                                 |                                         */
/*                               |                                              |                                         */
/*                               |  libname tmp "c:/temp";                      |                                         */
/*                               |  proc print data=tmp.want;                   |                                         */
/*                               |  run;quit;                                   |                                         */
/*                               |                                              |                                         */
/**************************************************************************************************************************/

/*         _         _                           _   _
 _ __ ___ (_)___ ___(_)_ __   __ _   _ __  _   _| |_| |__   ___  _ __
| `_ ` _ \| / __/ __| | `_ \ / _` | | `_ \| | | | __| `_ \ / _ \| `_ \
| | | | | | \__ \__ \ | | | | (_| | | |_) | |_| | |_| | | | (_) | | | |
|_| |_| |_|_|___/___/_|_| |_|\__, | | .__/ \__, |\__|_| |_|\___/|_| |_|
                             |___/  |_|    |___/
  __                  _   _
 / _|_   _ _ __   ___| |_(_) ___  _ __  ___
| |_| | | | `_ \ / __| __| |/ _ \| `_ \/ __|
|  _| |_| | | | | (__| |_| | (_) | | | \__ \
|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

*/
You will need to compile?
https://sqlite.org/contrib/download/extension-functions.c/download


  Missing functions in pandasql sqllite3

  Math         String
  ==========   ================
  acos         replicate
  asin         charindex
  atan         leftstr
  atn2         rightstr
  atan2        ltrim
  acosh        rtrim
  asinh        trim
  atanh        replace
  difference   reverse
  degrees      proper
  radians      padl
  cos          padr
  sin          padc
  tan          strfilter
  cot
  cosh         Aggregate
  sinh         ================
  tanh         stdev
  coth         variance
  exp          mode
  log          median
  log10        lower_quartile
  power        upper_quartile.
  sign
  sqrt
  square
  ceil
  floor
  pi


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
