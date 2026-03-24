local LinkRoblox = {
    Verification = true,
    Triggers = { 'linkRoblox', 'link', 'robloxLink', 'rl' },
    Description = 'Links your Discord account to your Roblox account.',
    Usage = '<prefix>linkRoblox [user]'
}

local idFromUsername = require('../Utils/idFromUsername')
local modifySaveData = require('../Utils/modifySaveData')
local Constants = require('Constants')

function LinkRoblox.Execute(message, args)
    local username = args[2]

    if not username then
        message:reply('Provide a username.')
        return
    end

    if username == 'robloxusername' then
        message:reply('Input your **actual** Roblox username...')
        return
    end

    username = username:gsub('@', '')

    local discordId = message.author.id:gsub('%D+', '')
    local robloxId = idFromUsername(username)
    local success, error = modifySaveData(robloxId, 'Verification', function(data)
        data.DiscordID = discordId
    end)

    if not success then
        message:reply(error)
    end

    success, error = modifySaveData(discordId, 'Verification', function(data)
        data.RobloxID = robloxId
        data.Verified = false
    end)

    if success then
        message:reply('Join this [game](<https://www.roblox.com/games/89278385343266/>) on the inputted account.\nThen run `'..Constants.PREFIX..'verify` again to get access to the server.')
    else
        message:reply(error)
    end
end

return LinkRoblox