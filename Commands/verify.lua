local Verify = {
    Verification = true,
    Triggers = { 'verify' },
    Description = 'Attempts to verify your Roblox account with Discord.',
    Usage = '<prefix>verify'
}

local Constants = require('Constants')
local getRobloxId = require('../Utils/getRobloxId')

function Verify.Execute(message)
    local robloxId = getRobloxId(message, args)
    local hasRole = message.member:hasRole(Constants.GUEST_ROLE)

    if hasRole and robloxId then
        message:reply('You\'re already verified!')
        return
    end

    if not robloxId then
        message:reply('Run `' ..  Constants.PREFIX .. 'linkRoblox RobloxUsername` first!\n**Need more help?** Run `' .. Constants.PREFIX .. 'help verify`!')
        return
    end

    message:reply('Welcome to CONECORP, ' .. message.author.name:gsub('@', '') .. '!')
    message.member:addRole(Constants.GUEST_ROLE)
end

return Verify
