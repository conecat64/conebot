local Help = {
    Verification = true,
    Triggers = { 'help', 'cmds', 'commands' },
    Description = 'Gets help about a specific command.',
    Usage = '<prefix>help [command]'
}

local Constants = require('Constants')
local Globals = require('Globals')

local isModerator = require('./Utils/isModerator')

function Help.Execute(message, args)
    local command = args[2]

    if command then
        local content = '**Command usage**\n'
        local handler = Globals.Commands[command]

        if not handler then
            message:reply('Command not found!')
            return
        end

        local triggers = table.concat(handler.Triggers, ', ')
        local usage = handler.Usage
        local description = handler.Description

        usage = usage:gsub('<prefix>', Constants.PREFIX)
        usage = usage:gsub('<games>', '[sb64 | sr | abj]')

        content = '**Triggers**: ' ..
        triggers ..
        '\n**Description**: ' .. description .. '\n**Usage**: ' .. usage

        message:reply(content)
    else
        local authorIsModerator = isModerator(message)
        local content = '**Command list**\n'
        local commandList = {}
        local modCommands = {}

        for command, handler in pairs(Globals.Commands) do
            if not handler.RequiresModerator then
                table.insert(commandList, command)
            else
                table.insert(modCommands, command)
            end
        end

        content = content .. table.concat(commandList, ', ')
        
        if authorIsModerator then
            content = content .. '\n**Moderator commands**\n' .. table.concat(modCommands, ', ')
        end

        content = content .. '\n-# You can use ' .. Constants.PREFIX .. 'help [command] to view more info.'

        message:reply(content)
    end
end

return Help
