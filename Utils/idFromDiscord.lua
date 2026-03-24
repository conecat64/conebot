local getSaveData = require('../Utils/getSaveData')
local Constants   = require('Constants')

return function(discordId)
    discordId = discordId:gsub('%D+', '')

    local retrievedData = getSaveData(discordId, 'Verification')

    if not retrievedData or not retrievedData.Verified then
        return false, Constants.ERRORS.NOT_VERIFIED
    end

    return retrievedData.RobloxID
end