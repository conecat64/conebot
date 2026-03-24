local GetRoblox = {
    Triggers = { 'getRoblox', 'whoIs', 'who' },
    Description = 'Gets a Roblox user from a Discord mention.',
    Usage = '<prefix>getRoblox [user]'
}

local getRobloxId = require('../Utils/getRobloxId')

function GetRoblox.Execute(message, args)
    local robloxId, error = getRobloxId(message, args)

    if not robloxId then
        message:reply(error)
        return
    end

    message:reply('https://www.roblox.com/users/'..robloxId..'/profile')
end

return GetRoblox