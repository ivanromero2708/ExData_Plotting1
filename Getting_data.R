### Getting the data

## Cleaning Environment
rm(list=ls())

## 1. Loading required packages
library(dplyr)

## 2. Getting de raw dataset

# Creating directory and downloads dataset
if(!file.exists("data")) {dir.create("data")}
fileloc <- "./data/electric_power_consumption.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, fileloc, method = "curl")

# 3. Assigning all data frames

# Decompressing the zip file
unzip(fileloc, exdir = "./data")