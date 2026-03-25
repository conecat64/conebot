local discordia = require('discordia')
local Constants = require('Constants')
local Globals = require('Globals')
local isModerator = require('./Utils/isModerator')
local getMessageStatus = require('./Utils/getMessageStatus')

local client = discordia.Client()

discordia.extensions()

for _, command in pairs(Constants.COMMANDS) do
    local handler = require('./Commands/' .. command)
    Globals.Commands[command] = handler
end

for line in io.lines('.env') do
   local key, value = string.match(line, '(.*)=(.+)')
   process.env[key] = value
end

Constants.HEADERS[1][2] = process.env.ROBLOX_API_KEY

local function findHandler(command)
    for commandName, handler in pairs(Globals.Commands) do
        for _, trigger in pairs(handler.Triggers) do
            if trigger:lower() == command then
                return handler, commandName
            end
        end
    end
end

client:on('ready', function()
    Globals.StartTime = os.time()
    print('Logged in as ' .. client.user.username .. '!')
    client:setActivity(Constants.PREFIX..'help || conecorp.cc')
end)

client:on('messageCreate', function(message)
    local content = message.content:lower()
    local args = content:split(' ')
    local prefixLength = #Constants.PREFIX

    local prefix = args[1]:sub(1, prefixLength):match(Constants.PREFIX)
    local isMod = isModerator(message)

    if message.author.bot then
        return
    end

    local command = args[1]:gsub(Constants.PREFIX, '')
    local handler, executingCommand = findHandler(command)

    if not handler then
        return
    end

    local status = getMessageStatus(message, executingCommand, handler)

    if not isMod then
        if status == 'DELETE' then
            message:delete()
            return

        elseif status == 'NOT_VALID_CHANNEL' then
            return
        end
    end

    if not prefix or not handler or (handler.RequiresModerator and not isMod) then
        return
    end

    handler.Execute(message, args)
end)

client:run('Bot ' .. process.env.BOT_TOKEN)
