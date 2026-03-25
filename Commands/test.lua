local Test = {
    RequiresModerator = true,
    Triggers = { 'test' },
    Description = 'A simple test command.',
    Usage = '<prefix>test'
}

local http = require('coro-http')
local json = require('json')
local htmlparser = require('htmlparser')
local Constants = require('Constants')

function Test.Execute(message, args)
    local game = args[2]

    if not game then
        message:reply(Constants.ERRORS.GAME_NOT_FOUND)
        return
    end

    if not args[3] then
        message:reply(Constants.ERRORS.PAGE_NOT_PROVIDED)
        return
    end

    game = game:lower()

    local page = table.concat(args, '_', 3)
    local clickUrl = '<https://' .. game .. '.conecorp.cc/' .. page .. '>'
    local url = 'https://' .. game .. '.conecorp.cc/w/api.php?action=query&prop=extracts&exintro&titles=' .. page .. '&format=json'
    local headers = {
        { 'User-Agent', 'DiscordBot/conebot' }
    }

    local _, body = http.request('GET', url, headers)
    local decodedBody = json.decode(body)

    if not decodedBody then
        return
    end

    for _, content in pairs(decodedBody.query.pages) do
        if not content.extract or content.extract == '' then
            message:reply('Page `' .. page .. '` was not found on the wiki!')
            return
        end

        local finalContent = ''
        local root = htmlparser.parse(content.extract)

        for _, p in pairs(root:select('p')) do
            finalContent = finalContent .. p:getcontent()
        end
        
        finalContent = string.gsub(finalContent, '<b>', '**')
        finalContent = string.gsub(finalContent, '</b>', '**')
        finalContent = string.gsub(finalContent, '<i>', '*')
        finalContent = string.gsub(finalContent, '</i>', '*')
        finalContent = string.gsub(finalContent, '<span.*</span>', '')

        finalContent = finalContent .. '\nYou can view the Wiki Page [here]('.. clickUrl .. ')!'

        message:reply(finalContent)
    end
end

return Test