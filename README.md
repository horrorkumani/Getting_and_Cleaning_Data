# Getting_and_Cleaning_Data

##run_analysis.R

###The cleanup script (run_analysis.R) does the following:

1. Load raw data

2. Merges the training and the test sets to create one data set.

  - Binding sensor data

  - Label columns

3. Extracts only the measurements on the mean and standard deviation for each measurement.

4. Uses descriptive activity names to name the activities in the data set

5. Appropriately labels the data set with descriptive activity names.

  - Remove parentheses

  - Make syntactically valid names

  - Make clearer names

6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

7. Print code book of the data set (after changing the data frame into a data set).

(Run run_analysis.R using source() in RStudio)

#Outputs produced

- Tidy dataset file sensor_avg_by_act_sub.txt
- Codebook file CodeBook.md
