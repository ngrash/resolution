function secondsToClock(seconds)
	return string.format("%.2d:%.2d", seconds/(60*60), seconds/60%60)
end