local GiveEarlyAccess = {
    RequiresModerator = true,
    Triggers = { 'giveEarlyAccess', 'gea' },
    Description = 'Gives early access to the targeted user.',
    Usage = '<prefix>giveEarlyAccess [user]'
}

local modifySaveData = require('../Utils/modifySaveData')
local getRobloxId = require('../Utils/getRobloxId')

function GiveEarlyAccess.Execute(message, args)
    local robloxId, error = getRobloxId(message, args)

    if not robloxId then
        message:reply(error)
        return
    end

    local success, error = modifySaveData(robloxId, 'ABJ', function(data)
        data.EarlyAccess = true
    end)

    if success then
        message:reply('Early Access given!')
    else
        message:reply(error)
    end
end

return GiveEarlyAccess