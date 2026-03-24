local json = require('json')
local http = require('coro-http')
local Constants = require('Constants')

local getSaveData = require('../Utils/getSaveData')
local getGameData = require('../Utils/getGameData')
local createEmptyData = require('../Utils/createEmptyData')

return function(robloxId, game, modifyFunction)
    local retrievedData = getSaveData(robloxId, game)
    local universe, _, datastore = getGameData(game)

    if not universe then
        return false, Constants.ERRORS.GAME_NOT_FOUND
    end

    if retrievedData == 'NOT_CREATED' and game:upper() == 'VERIFICATION' then
        retrievedData = createEmptyData(robloxId, game)
    end

    if not retrievedData or retrievedData == 'NOT_CREATED' then
        return false, Constants.ERRORS.DATA_NOT_CREATED
    end

    local url = 'https://apis.roblox.com/cloud/v2/universes/' .. universe .. '/data-stores/' .. datastore .. '/entries/' .. robloxId

    modifyFunction(retrievedData)

    local body = json.encode({
        value = retrievedData
    })

    if not body or type(body) ~= 'string' then
        return false, Constants.ERRORS.FAILED_JSON_ENCODE
    end

    local response = http.request('PATCH', url, Constants.HEADERS, body)

    if response.code == 200 then
        return true
    else
        return false, Constants.ERRORS.RESPONSE_NOT_200
    end
end