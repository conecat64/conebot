local json = require('json')
local http = require('coro-http')
local Constants = require('Constants')

return function(username)
    if not username then
        return
    end

    local url = 'https://users.roblox.com/v1/usernames/users'
    local body = {
        usernames = { username },
        excludeBannedUsers = true,
    }

    local encodedBody = json.encode(body)

    if type(encodedBody) ~= 'string' then
        return false, Constants.ERRORS.FAILED_JSON_ENCODE
    end

    local response, data = http.request('POST', url, Constants.HEADERS, encodedBody)
    
    if response.code ~= 200 then
        return false, Constants.ERRORS.NO_CODE
    end

    local decoded = json.decode(data)

    if not decoded then
        return false, Constants.ERRORS.FAILED_JSON_DECODE
    end

    local userInfo = decoded.data[1]

    if not userInfo then
        return false, Constants.ERRORS.ROBLOX_ID_NOT_FOUND
    end

    return userInfo.id
end