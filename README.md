## Synopsis

Data and code to analyze the relationship between synchronization index and traditional social capital metrics.

## Data

* __italy-shp__ contains geographical boundaries of administrative divisions in Italy, there included the provinces in our analysis
* __features-data.csv__ contains synchronization index and traditional social capital metrics for different municipalities.
	* province = province being considered (ADM_LVL = 2)
	* region = region (ADM_LVL = 1)
	* avg_within = average within synchronization
	* avg_between = average between synchronization
	* sd_within = standard deviation of within synchronization
	* sd_between = standard deviation of between synchronization
	* depriv = index of multiple deprivation
	* rpc = per-capita income
	* blood = blood donations (social capital metric)
	* assoc = association density (social capital metric)
	* referendum = referenda turnout (social capital metric)

## R Code

* __ols.r__ code for OLS regressions
* __beta-analysis.r__ code for the analysis of beta coefficients
* __spatial-auto.r__ code for testing spatial auto-regression

## Contributors

Marco Mamei (marco.mamei@unimore.it)
Francesca Pancotto (francesca.pancotto@unimore.it)
Marco De Nadai (denadai@fbk.eu)
Bruno Lepri (lepri@fbk.eu)


