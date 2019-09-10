
# General Bikeshare Feed Specification - R Package

*Developed by Kaelyn M. Rosenberg (author) and Simon P. Couch (author,
maintainer)*

![CRAN Badge](http://www.r-pkg.org/badges/version/gbfs) [![Build
Status](https://travis-ci.org/ds-civic-data/gbfs.svg?branch=master)](https://travis-ci.org/ds-civic-data/gbfs)

The `gbfs` package supplies a set of functions to interface with General
Bikeshare Feed Specification .json feeds in R, allowing users to save
and accumulate tidy .rds datasets for specified cities/bikeshare
programs.

**Features**

  - Get bikeshare data by specifying city or supplying url of feed
  - All feeds for a city can be saved with a single function
  - New information from dynamic feeds can be appended to existing
    datasets

## Installation

We’re now on CRAN\! Install the latest release, 1.2.0, with:

``` r
install.packages("gbfs")
library("gbfs")
```

You can install the development version of `gbfs` from github with:

``` r
# install.packages("devtools")
devtools::install_github("ds-civic-data/gbfs")
```

## Example

Here the function `get_gbfs()` is used to create a folder and save all
existing gbfs .json feeds for Portland. Then `get_station_status()` is
used to append the most recent version of the station status .json feed
to the station status .rds dataset.

Note: Throughout this example I use a temporary directory by calling
`withr::with_dir(tempdir(), ...)` as the codes are examples. In real
life, we would skip the temporary directory stuff; just focus on the
`...` for the purpose of this
tutorial.

``` r
withr::with_dir(tempdir(), get_gbfs(city = "Portland", feeds = "all", directory = "pdx_gbfs"))
withr::with_dir(tempdir(), list.files("pdx_gbfs"))
#> [1] "free_bike_status.rds"     "station_information.rds" 
#> [3] "station_status.rds"       "system_alerts.rds"       
#> [5] "system_calendar.rds"      "system_hours.rds"        
#> [7] "system_information.rds"   "system_pricing_plans.rds"
#> [9] "system_regions.rds"
station_status <- withr::with_dir(tempdir(), readRDS("pdx_gbfs/station_status.rds"))
head(station_status)
#>   station_id num_bikes_available num_bikes_disabled num_docks_available
#> 1   hub_1512                   7                  0                   8
#> 2   hub_1513                   1                  0                   9
#> 3   hub_1514                   7                  0                   5
#> 4   hub_1515                   3                  0                  14
#> 5   hub_1516                   3                  0                  13
#> 6   hub_1517                   6                  0                   8
#>   is_installed is_renting is_returning        last_updated year month day
#> 1         TRUE       TRUE         TRUE 2019-09-09 23:16:04 2019     9   9
#> 2         TRUE       TRUE         TRUE 2019-09-09 23:16:04 2019     9   9
#> 3         TRUE       TRUE         TRUE 2019-09-09 23:16:04 2019     9   9
#> 4         TRUE       TRUE         TRUE 2019-09-09 23:16:04 2019     9   9
#> 5         TRUE       TRUE         TRUE 2019-09-09 23:16:04 2019     9   9
#> 6         TRUE       TRUE         TRUE 2019-09-09 23:16:04 2019     9   9
#>   hour minute
#> 1   23     16
#> 2   23     16
#> 3   23     16
#> 4   23     16
#> 5   23     16
#> 6   23     16
nrow(station_status)
#> [1] 153
withr::with_dir(tempdir(), get_station_status(city = "Portland", directory = "pdx_gbfs", file = "station_status.rds"))
station_status <- withr::with_dir(tempdir(), readRDS("pdx_gbfs/station_status.rds"))
nrow(station_status)
#> [1] 306
```
