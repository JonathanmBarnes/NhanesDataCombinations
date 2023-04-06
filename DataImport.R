startTime <- Sys.time()
path <- "Data/"
files <- as.list(list.files(path = path, recursive = TRUE, full.names = FALSE))
Wholedata <- lapply(lapply(list.files(path = path, recursive = TRUE, full.names = TRUE), read_xpt),as.data.frame)
Dem <- Wholedata[seq(4,25,5)]
Day1Raw <- lapply(Wholedata[seq(1,25,5)], as.data.frame)
Day2Raw <- lapply(Wholedata[seq(2,25,5)], as.data.frame)
BMRaw <- lapply(Wholedata[seq(3,25,5)], as.data.frame)
IncomeRaw <- lapply(Wholedata[seq(5,25,5)], as.data.frame)
cat("Current Elapsed Time:", Sys.time() - startTime, "Seconds" ,"\nData Read From Folders")
