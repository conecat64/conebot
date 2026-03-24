local Ban = {
    RequiresModerator = true,
    Triggers = { 'ban' },
    Description = 'Bans a user from a game.',
    Usage = '<prefix>ban [user] <games> [reason?]'
}

local getRobloxId = require('../Utils/getRobloxId')
local runSandboxedLuau = require('../Utils/runSandboxedLuau')

function Ban.Execute(message, args)
    local robloxId, error = getRobloxId(message, args)
    local game = args[3]
    local reason = ''

    if args[4] then
        reason = table.concat(args, ' ', 4)
    else
        reason = 'Banned by Admin'
    end

    if not robloxId then
        message:reply(error)
        return
    end

    if type(robloxId) ~= 'number' and type(robloxId) ~= 'string' then
        message:reply('Invalid Roblox ID type: `' .. type(robloxId) .. '`')
        return
    end

    local success, error = runSandboxedLuau(([[
        local config = { UserIds = { <ID> }, Duration = -1, DisplayReason = '<reason>', PrivateReason = 'Banned by Admin' }
        game.Players:BanAsync(config)
    ]]):gsub('<ID>', robloxId):gsub('<reason>', reason), game)

    if success then
        message:reply('Successfully banned user.')
    else
        message:reply(error)
    end
end

return Ban