tabel<- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
tabel$Date <- as.Date(tabel$Date, "%d/%m/%Y")
tabel <- subset(tabel,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
tabel <- tabel[complete.cases(tabel),]

#combine
dateTime <- paste(tabel$Date, tabel$Time)
dateTime <- setNames(dateTime, "DateTime")

#delete
tabel <- tabel[ ,!(names(tabel) %in% c("Date","Time"))]
#add to table
tabel <- cbind(dateTime, tabel)

#format
tabel$dateTime <- as.POSIXct(dateTime)

#2nd plot
plot(tabel$Global_active_power~tabel$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#save plot2 to png
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

