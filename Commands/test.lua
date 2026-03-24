local Test = {
    RequiresModerator = true,
    Triggers = { 'test' },
    Description = 'A simple test command.',
    Usage = '<prefix>test'
}

function Test.Execute(message, args)
    local content = 'hi'
    message:reply(content)
end

return Test