local Constants = require('Constants')
local Globals = require('Globals')

return function(message, executingCommand, handler)
    local id = message.channel.id

    if id == Constants.CHANNELS.VERIFICATION and executingCommand ~= 'linkRoblox' and executingCommand ~= 'verify' then
        return 'DELETE'
    end

    if id == Constants.CHANNELS.CREATIONS and not message.attachments then
        return 'DELETE'
    end

    if id ~= Constants.CHANNELS.BOTS then
        if handler.Verification and id == Constants.CHANNELS.VERIFICATION then
            return nil
        end

        return 'NOT_VALID_CHANNEL'
    end
end
