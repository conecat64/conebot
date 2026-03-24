local json = require('json')
local http = require('coro-http')
local Constants = require('Constants')

local getGameData = require('../Utils/getGameData')

return function(robloxId, game)
    local universe, _, datastore = getGameData(game)

    if not universe then
        return false, Constants.ERRORS.GAME_NOT_FOUND
    end
    
    local url = 'https://apis.roblox.com/cloud/v2/universes/' .. universe .. '/data-stores/' .. datastore .. '/entries'..'?id='..robloxId
    local body = json.encode({
        value = {}
    })

    if type(body) ~= 'string' then
        return false, Constants.ERRORS.FAILED_JSON_ENCODE
    end

    local response = http.request('POST', url, Constants.HEADERS, body)

    if response.code == 200 then
        return {}
    else
        return false, Constants.ERRORS.RESPONSE_NOT_200
    end
end