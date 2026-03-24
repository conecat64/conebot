local Purge = {
    RequiresModerator = true,
    Triggers = { 'purge' },
    Description = 'Purges a specific amount of messages from the channel.',
    Usage = '<prefix>purge [amount]'
}

function Purge.Execute(message, args)
    local stringAmount = args[2]
    local amount = tonumber(stringAmount)

    if not stringAmount or not amount then
        message:reply('Enter a number (1-50).')
        return
    end

    if amount <= 0 then
        message:reply('Not a valid number!')
        return
    end

    amount = math.min(amount, 50)
    
    local messages = message.channel:getMessages(amount)
    message.channel:bulkDelete(messages)
end

return Purge