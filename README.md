getcleandataproject
===================

Repo for Getting and Cleaning Data course project.

PLEASE NOTE:  The "tidydataset.txt" file data will likely be truncated to 19 (out of 30) rows of data, due to the user's R settings.

The run_analysis.R file in this repo reads into R a variety of wearable computing data points, collected using the Samsung Galaxy S smartphone.  The data is read into a number of data frames via the read.table function.

Once all the relevant data has been stored in various data frames within R, the script then organizes and combines the data, piece by piece using the rbind() function, into one complete data frame that encapsulates observation points for 30 subjects (70% produced training data and 30% produced test data) across 561 variables of data gathered by the smartphone attached to the subjects' waist.

As mean and standard deviation variables were of particular interest for this analysis, the script subsets the original 561 data point variables into 86, using a combination of subsetting and regular expressions.  The script searches all 561 variables for the words "mean", "Mean", or "std" and subsets the pre-existing data frame based on the resultant index.

Next, the script attaches activity descriptions to the data frame (which evolves from the "extracted" data frame into the "labeled" data frame).  This is accomplished by aggregating the test and training labels (rbind), assigning them a description by checking their numeric value against the "activitylabels" table/data frame where, e.g., 1 = "WALKING", and then column binding them onto the "extracted" data frame.

MOving forward, the script next aggregates the subject IDs by continued use of the rbind() function.  These are given a column name, as is done with previous columns, using the colnames() funciton.

Finally, the subject IDs are column bound (cbind) at the beginning of the "labeled" data frame, resulting in the "wholeset" data frame, which is almost the final product.

The script then calls the reshape2 package to make use of the melt and acast functions.  These two functions enable the script to make the final data set much more compact and tidy, particularly with the acast function, which returns an average breakdown of all the variables by activity and subject id.

In the ultimate step, the script writes the "tidy data set" (or "avgwholemelt") into a text file using write.table() for future review and analysis.