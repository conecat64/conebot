local json = require('json')
local http = require('coro-http')
local Constants = require('Constants')

local getGameData = require('../Utils/getGameData')

return function(id, game)
    if not id then
        return false, Constants.ERRORS.NO_USERNAME
    end

    local universe, _, datastore = getGameData(game)

    if not universe or not datastore then
        return false, Constants.ERRORS.GAME_NOT_FOUND
    end
    
    local url = 'https://apis.roblox.com/cloud/v2/universes/'..universe..'/data-stores/'..datastore..'/entries/'..id
    local response, body = http.request('GET', url, Constants.HEADERS)

    if response.code == 404 then
        return 'NOT_CREATED', Constants.ERRORS.DATA_NOT_CREATED
        
    elseif response.code ~= 200 then
        return false, Constants.ERRORS.RESPONSE_NOT_200

    else
        return json.decode(body).value

    end
end