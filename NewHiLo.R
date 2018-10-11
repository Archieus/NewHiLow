library(Quandl)
library(quantmod)

Sys.setenv(TZ = "UTC")
Quandl.api_key("LDvEJuPkQWrPGpHwokVx")

NYSEUnc <- Quandl("URC/NYSE_UNCH", type = "xts", start_date = "2006-11-01")
NYSEDec <- Quandl("URC/NYSE_DEC", type = "xts", start_date = "2006-11-01")
NYSEAdv <- Quandl("URC/NYSE_ADV", type = "xts", start_date = "2006-11-01")

NYSEUncVol <- Quandl("URC/NYSE_UNCH_VOL", type = "xts", start_date = "2006-11-01")
NYSEDecVol <- Quandl("URC/NYSE_DEC_VOL", type = "xts", start_date = "2006-11-01")
NYSEAdvVol <- Quandl("URC/NYSE_ADV_VOL", type = "xts", start_date = "2006-11-01")

NYSETotVol <- cbind(NYSEUncVol,NYSEDecVol,NYSEAdvVol)
names(NYSETotVol) <- c("Unch", "Decline", "Advance")
NYSETotVol$Total <- rowSums(NYSETotVol)
NYSETotVol$Avg50 <- EMA(NYSETotVol$Total,50)
NYSEVol.EMA <- EMA(NYSETotVol$Total,50)

NYSE <- cbind(NYSEUnc, NYSEDec, NYSEAdv)
names(NYSE) <- c("Unch", "Decline", "Advance")
NYSE$Total <- rowSums(NYSE)

NYSE52WkHi <- Quandl("URC/NYSE_52W_HI", type = "xts", start_date = "2006-11-01")
NYSE52WkLo <- Quandl("URC/NYSE_52W_LO", type = "xts", start_date = "2006-11-01")

NYSE$AdvPct <- (NYSE$Advance/NYSE$Total)*100
NYSE$DecPct <- (NYSE$Decline/NYSE$Total)*100

NYSE$HiPct52Wk <- (NYSE52WkHi/NYSE$Total)*100
NYSE$LoPct52Wk <- (NYSE52WkLo/NYSE$Total)*100


NAZUnc <- Quandl("URC/NASDAQ_UNCH", type = "xts", start_date = "2006-11-01")
NAZDec <- Quandl("URC/NASDAQ_DEC", type = "xts", start_date = "2006-11-01")
NAZAdv <- Quandl("URC/NASDAQ_ADV", type = "xts", start_date = "2006-11-01")

NASDAQ <- cbind(NAZUnc,NAZDec,NAZAdv)
names(NASDAQ) <- c("Unch", "Decline", "Advance")
NASDAQ$Total <- rowSums(NASDAQ)

NAZ52WkHi <- Quandl("URC/NASDAQ_52W_HI", type = "xts", start_date = "2006-11-01")
NAZ52WkLo <- Quandl("URC/NASDAQ_52W_LO", type = "xts", start_date = "2006-11-01")

NASDAQ$AdvPct <- (NASDAQ$Advance/NASDAQ$Total)*100
NASDAQ$DecPct <- (NASDAQ$Decline/NASDAQ$Total)*100

NASDAQ$HiPct52Wk <- (NAZ52WkHi/NASDAQ$Total)*100
NASDAQ$LoPct52Wk <- (NAZ52WkLo/NASDAQ$Total)*100

View(tail(NYSE))
View(tail(NASDAQ))
View(tail(NYSETotVol))
