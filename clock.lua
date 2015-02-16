function secondsToClock(seconds)
	return secondsToCountdown(seconds)
	--return os.date("!%H:%M",seconds)
	--return string.format("%.2d:%.2d", seconds/(60*60), seconds/60%60)
end

function secondsToCountdown(seconds)
	return os.date("!%X",seconds)
	--return string.format("%.2d:%.2d:%.2d", seconds/(60*60), seconds/60%60, seconds%60)
end