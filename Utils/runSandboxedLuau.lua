local Constants = require('Constants')
local http = require('coro-http')
local json = require('json')

local getGameData = require('../Utils/getGameData')

return function(scriptContent, game)
    local universe, place = getGameData(game)

    if not universe or not place then
        return false, Constants.ERRORS.GAME_NOT_FOUND
    end

    local url = 'https://apis.roblox.com/cloud/v2/universes/' .. universe .. '/places/' .. place .. '/luau-execution-session-tasks'
    local body = json.encode({
        ['script'] = scriptContent
    })

    if not body or type(body) ~= 'string' then
        return false, Constants.ERRORS.FAILED_JSON_ENCODE
    end

    local response = http.request('POST', url, Constants.HEADERS, body)

    return response.code == 200
end