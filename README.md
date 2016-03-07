# Getting And Cleaning Data Assignment - Read Me file 

Step 1: Download zip file and extract to the default folder named 'UCI HAR Dataset'.

Step 2: Copy run_analysis.R file to the roo folder (same parent folder as 'UCI HAR Dataset' folder)

Step 3: Execute the r code. There are comments in the R file to guide you through the detailed steps.
        3.1 load features and activity labels
        3.2 load all test, rename columns 'activity' and 'subjectID'. then combine into a single test data set.
        3.3 repeat same steps for train data sets.
        3.4 now that all columns match for train and test data, merge the two into a common merged data set.
        3.5 search for 'mean' and 'std' columns using grepl function. also identify 'activity' and subjectID' columns. 
            remove the rest of the columns
        3.6 make friendly names for 'activity' using factor function.
        3.7 change all column names to friendly and readble column names.
        3.8 convert merged data into data table, and calculate mean for all data by 'activity' and 'subjectID'. 
        3.9 write to a new data table and save as txt file.

Step 4: New Tidy Data file is created by running the last line of code (under STEP 5 section) in run_analysis.R file, and a copy has been uploaded to github.

Step 5: Manually generate a codebook and upload to github as codebook.txt

