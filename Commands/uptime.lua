local Uptime = {
    RequiresModerator = false,
    Triggers = { 'uptime', 'ut' },
    Description = 'Gets the bot\'s uptime.',
    Usage = '<prefix>uptime'
}

local Globals = require('Globals')
local formatTime = require('../Utils/formatTime')

function Uptime.Execute(message, args)
    local diff = os.time() - Globals.StartTime
    local formatted = formatTime(diff, 'Days')
    local content = 'Uptime: '..formatted

    message:reply(content)
end

return Uptime