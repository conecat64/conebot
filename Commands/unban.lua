local Unban = {
    RequiresModerator = true,
    Triggers = { 'unban' },
    Description = 'Unbans a user from a game.',
    Usage = '<prefix>unban [user] <games>'
}

local getRobloxId = require('../Utils/getRobloxId')
local runSandboxedLuau = require('../Utils/runSandboxedLuau')

function Unban.Execute(message, args)
    local robloxId, error = getRobloxId(message, args)
    local game = args[3]

    if not robloxId then
        message:reply(error)
        return
    end

    local success, error = runSandboxedLuau(([[
        local config = { UserIds = { <ID> }, ApplyToUniverse = true }
        game.Players:UnbanAsync(config)
    ]]):gsub('<ID>', robloxId), game)

    if success then
        message:reply('Successfully unbanned user.')
    else
        message:reply(error)
    end
end

return Unban