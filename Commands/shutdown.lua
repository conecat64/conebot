local Shutdown = {
    RequiresModerator = true,
    Triggers = { 'shutdown', 'kill' },
    Description = 'Shuts down the bot. Only usable by conecat.',
    Usage = '<prefix>shutdown'
}

function Shutdown.Execute(message, args)
    if message.author.id ~= '846669251989340171' then
        return
    end

    process:exit(200)
end

return Shutdown