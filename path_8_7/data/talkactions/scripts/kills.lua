function onSay(player, words, param)
	if player:getExhaustion(1000) <= 0 then
		player:setExhaustion(1000, 2)
		local fragTime = configManager.getNumber(configKeys.FRAG_TIME)
		if fragTime <= 0 then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You do not have any unjustified kill.")
			return false
		end

		local skullTime = player:getSkullTime()
		if skullTime <= 0 then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You do not have any unjustified kill.")
			return false
		end

		local kills = math.ceil(skullTime / fragTime)
		local remainingSeconds = math.floor((skullTime % fragTime) / 1000)

		local hours = math.floor(remainingSeconds / 3600)
		local minutes = math.floor((remainingSeconds % 3600) / 60)
		local seconds = remainingSeconds % 60

		local message = "You have " .. kills .. " unjustified kill" .. (kills > 1 and "s" or "") .. ". The amount of unjustified kills will decrease after: "
		if hours ~= 0 then
			if hours == 1 then
				message = message .. hours .. " hour, "
			else
				message = message .. hours .. " hours, "
			end
		end

		if hours ~= 0 or minutes ~= 0 then
			if minutes == 1 then
				message = message .. minutes .. " minute and "
			else
				message = message .. minutes .. " minutes and "
			end
		end

		if seconds == 1 then
			message = message .. seconds .. " second."
		else
			message = message .. seconds .. " seconds."
		end

		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, message)
		return false
	else
		player:sendTextMessage(MESSAGE_STATUS_SMALL, 'You\'re exhausted for: '..player:getExhaustion(1000)..' seconds.')
	end
end
