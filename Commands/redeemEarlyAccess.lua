local RedeemEarlyAccess = {
    Triggers = { 'redeemEarlyAccess', 'rea' },
    Description = 'Checks if you have early access on your Roblox account.',
    Usage = '<prefix>redeemEarlyAccess'
}

local http = require('coro-http')
local json = require('json')

local Constants = require('Constants')
local getRobloxId = require('../Utils/getRobloxId')

function RedeemEarlyAccess.Execute(message, args)
    if message.member:hasRole(Constants.PLACES.ABJ.ROLE) then
        message:reply('You already have the role.')
        return
    end

    local robloxId, error = getRobloxId(message, args)

    if not robloxId then
        message.channel:send(error)
        return
    end

    local url = 'https://apis.roblox.com/cloud/v2/users/' .. robloxId .. '/inventory-items?filter=gamePassIds=' .. Constants.PLACES.ABJ.GAMEPASS
    local response, body = http.request('GET', url, Constants.HEADERS)

    if response.code ~= 200 and response.code ~= 403 then
        message:reply(Constants.ERRORS.NO_CODE)
        return
    end

    local data = json.decode(body)

    if type(data) ~= 'table' then
        message:reply(Constants.ERRORS.FAILED_JSON_DECODE)
        return
    end

    if data.code and data.code == 'PERMISSION_DENIED' then
        message:reply(
            'This command requires you to have your inventory set to public!\nClick [this link](<https://www.roblox.com/my/account#!/privacy/TradingAndInventory) and set it to **everyone**.\nThen run the command again. You can change it back later.\n-# If you really don\'t wanna, you can alternatively ping a moderator with a video of proof of owning the gamepass.>')
    
    elseif data.inventoryItems and #data.inventoryItems > 0 then
        message:reply('Gave you the role!')
        message.member:addRole(Constants.PLACES.ABJ.ROLE)

    else
        message:reply(
        'You don\'t have early access yet! You can buy it [here](https://www.roblox.com/game-pass/1507450319/Early-Access).')
        
    end
end

return RedeemEarlyAccess
