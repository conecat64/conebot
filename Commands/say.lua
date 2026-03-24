local Say = {
    RequiresModerator = true,
    Triggers = { 'say' },
    Description = 'Repeats what you say.',
    Usage = '<prefix>say [message]'
}

function Say.Execute(message, args)
    local result = ''

    for index, value in pairs(args) do
        if index == 1 then goto continue end
        result = result..value..' '
        ::continue::
    end

    message:reply(result)
    message:delete()
end

return Say