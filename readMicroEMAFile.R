## Read the uEMA file

uEMAFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", header = TRUE, sep = ",")

user_id = "uema01@micropa_com"

uEMAUser <- subset(uEMAFile, uEMAFile$USER_ID == user_id)


uEMAUser$VAL <- 70000

uEMAUser$RESPONDED[uEMAUser$ACTIVITY_TYPE != "MISSED" & uEMAUser$ACTIVITY_TYPE != "DISMISSED"] <- "RESPONSE"
uEMAUser$RESPONDED[uEMAUser$ACTIVITY_TYPE == "MISSED" | uEMAUser$ACTIVITY_TYPE == "DISMISSED"] <- "NO RESPONSE"

uEMAUser$PROMPT_TIME <- as.POSIXct(uEMAUser$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")

library(plotly)

responsePlot <- plot_ly(uEMAUser, x = ~PROMPT_TIME, y=~VAL, color = ~RESPONDED, type = "bar")

uEMAUser$RESPONSE_TIME <- as.numeric(uEMAUser$RESPONSE_TIME)

responseTimePlot <- plot_ly(uEMAUser,x = ~PROMPT_TIME, y=~RESPONSE_TIME, type = "bar")


subplot(distPlot, cumPlot4Weeks, responsePlot, responseTimePlot, shareX = TRUE, nrows = 4)
