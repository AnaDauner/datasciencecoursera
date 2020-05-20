# Programming Assignment - Course "R Programming" - Week 4:

setwd("C:/Users/anada/Desktop/")
library(dplyr)


### 1. Reading the COMMON data ------------------------------------------------

    # Reading the "activity_labels.txt" file
activity_labels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt",
                              header = FALSE)

    # Changing from Capital letter to lower case
activity_labels[ , 2] <- tolower(activity_labels[ , 2])

# Changing the names of the columns
names(activity_labels) <- c("Activ_index", "Activity")


# Reading the "features.txt" file
features <- read.table(file = "./UCI HAR Dataset/features.txt",
                       header = FALSE)

# Changing the names of the columns
names(features) <- c("Feat_index", "Features")


### 2. Reading the TRAIN data -------------------------------------------------

# Reading the "subject_train.txt" file
subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt",
                            header = FALSE)

# Changing the name of the column
names(subject_train) <- c("Subject")

# Converting the subject IDs into factors
subject_train$Subject <- as.factor(subject_train$Subject)


# Reading the "y_train.txt" file
y_train <- read.table(file = "./UCI HAR Dataset/train/y_train.txt",
                      header = FALSE)

# Changing the name of the column
names(y_train) <- c("Activ_index")

# Converting the activity IDs into factors
y_train$Activ_index <- as.factor(y_train$Activ_index)


# Reading the "X_train.txt" file
X_train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt",
                      header = FALSE)


### 3. Reading the TEST data --------------------------------------------------

    # Reading the "subject_test.txt" file
subject_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt",
                           header = FALSE)

    # Changing the name of the column
names(subject_test) <- c("Subject")

    # Converting the subject IDs into factors
subject_test$Subject <- as.factor(subject_test$Subject)


    # Reading the "y_test.txt" file
y_test <- read.table(file = "./UCI HAR Dataset/test/y_test.txt",
                     header = FALSE)

    # Changing the name of the column
names(y_test) <- c("Activ_index")

    # Converting the activity IDs into factors
y_test$Activ_index <- as.factor(y_test$Activ_index)


    # Reading the "X_test.txt" file
X_test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt",
                     header = FALSE)


### 4. Subsetting X_train and X_test ------------------------------------------

    # Extracting the positions of the mean and standard-devation values from
        # the "features$Features" vector
mean_SD_posit <- grepl(pattern = "\\bmean()\\b", x = features$Features) | 
    grepl(pattern = "\\bstd()\\b", x = features$Features)

    # Creating a vector with the names of only the variables related to means
        # and standard-deviations 
features_filtered <- features[mean_SD_posit, ]
mean_SD_names <- as.character(features_filtered$Features)

    # Subsetting X_train
X_train_mean_SD <- X_train[ , mean_SD_posit]

    # Subsetting X_test
X_test_mean_SD <- X_test[ , mean_SD_posit]


### 5. Merging the TRAIN and TEST datasets ------------------------------------

    # TRAIN - Combining the datasets "X_mean_SD", "subjet" and "activity"
train_dataset <- mutate (X_train_mean_SD,
                         dataset = "train",
                         subject = subject_train$Subject,
                         activity = y_train$Activ_index)

    # TEST - Combining the datasets "X_mean_SD", "subjet" and "activity"
test_dataset <- mutate (X_test_mean_SD,
                        dataset = "test",
                        subject = subject_test$Subject,
                        activity = y_test$Activ_index)

    # Merging both datasets
complete_dataset <- rbind(train_dataset, test_dataset)


### 6. Reordering the columns -------------------------------------------------

complete_dataset <- complete_dataset[, c(67, 68, 69, 1:66)]


### 7. Renaming the activities ------------------------------------------------

complete_dataset$activity <- recode(complete_dataset$activity,
                                `1` = as.character(activity_labels$Activity[1]),
                                `2` = as.character(activity_labels$Activity[2]),
                                `3` = as.character(activity_labels$Activity[3]),
                                `4` = as.character(activity_labels$Activity[4]),
                                `5` = as.character(activity_labels$Activity[5]),
                                `6` = as.character(activity_labels$Activity[6]))


### 8. Renaming the variables -------------------------------------------------

names(complete_dataset) <- c(names(complete_dataset [1:3]),
                             mean_SD_names)


### 9. Generating the output --------------------------------------------------

write.table(x = complete_dataset, file = "Output.txt", row.names = FALSE)

