local idFromUsername = require('../Utils/idFromUsername')
local idFromDiscord = require('../Utils/idFromDiscord')
local Constants     = require('Constants')

return function(message, args)
    local authorDiscordId = message.author.id
    local pingOrUsername = args[2] or authorDiscordId

    if not pingOrUsername then
        return false, Constants.ERRORS.NO_USERNAME
    end

    if pingOrUsername == 'me' then
        pingOrUsername = authorDiscordId
    end

    local robloxId = idFromUsername(pingOrUsername) or idFromDiscord(pingOrUsername)

    if robloxId then
        return robloxId
    else
        return false, Constants.ERRORS.ROBLOX_ID_NOT_FOUND
    end
end