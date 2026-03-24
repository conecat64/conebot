local Stats = {
    Triggers = { 'stats', 'statistics' },
    Description = 'Gets statistics of a Roblox user in a game.',
    Usage = '<prefix>stats [user] <games>'
}

local formatTime = require('../Utils/formatTime')
local addCommas = require('../Utils/addCommas')
local getSaveData = require('../Utils/getSaveData')
local getRobloxId = require('../Utils/getRobloxId')

local Constants = require('Constants')

function Stats.Execute(message, args)
    local robloxId, error = getRobloxId(message, args)

    if not robloxId then
        message:reply(error)
        return
    end

    local game = (args[3] or ''):upper()
    local data, error = getSaveData(robloxId, game)

    if not data or data == 'NOT_CREATED' then
        message:reply(error)
        return
    end

    if game == 'SB64' then
        local content = ''

        for fileNum = 1, 2 do
            local fileData = data['File' .. fileNum]
            local playerPoints = #(fileData.Points.Normal or {})
            local goldPoints = #(fileData.Points.Gold or {})
            local playtime = formatTime(fileData.Playtime, 'Days')

            content = content .. '**File ' .. fileNum .. '**:```ansi'
            content = content .. '\n\u{001b}[1;2m' .. 'Player Points' .. '\u{001b}[0m: ' .. playerPoints..' + '..goldPoints
            content = content .. '\n\u{001b}[1;2m' .. 'Playtime' .. '\u{001b}[0m: ' .. playtime
            content = content .. '```\n'
        end

        message:reply(content)

    elseif game == 'SR' then
        local longestLength = -1
        local totalTimesPlayed = 0
        local maps = {}

        for key, info in pairs(data.Stats.Maps) do
            local displayName = Constants.PLACES.SR.MAP_NAMES[key]

            if not displayName then goto continue end

            local bestTime = formatTime(info.BestTime, 'Precise')
            local timesPlayed = addCommas(info.TimesPlayed)

            if longestLength < #displayName then
                longestLength = #displayName
            end

            maps[key] = {
                Display = displayName,
                BestTime = bestTime,
                TimesPlayed = timesPlayed
            }

            totalTimesPlayed = totalTimesPlayed + info.TimesPlayed

            ::continue::
        end

        local content = '**Best Times**\n```ansi\n'

        for _, info in pairs(maps) do
            local spacesNumber = longestLength - #info.Display
            local spaces = ''

            for i = 1, spacesNumber do
                spaces = spaces .. ' '
            end

            content = content ..
                '\u{001b}[1;2m' ..
                info.Display ..
                '\u{001b}[0m: ' .. spaces .. info.BestTime .. ' (Played ' .. info.TimesPlayed .. ' times)\n'
        end

        local playtime = formatTime(data.Stats.General.Playtime, 'Days')
        local gems = addCommas(data.Collectibles.Gems)
        local winstreak = addCommas(data.Stats.General.HighestWinStreak)
        local deaths = addCommas(data.Stats.General.Deaths)
        local roundsCompleted = addCommas(data.Stats.General.RoundsCompleted)
        local formattedTotalTimesPlayed = addCommas(totalTimesPlayed)

        content = content .. '```\n<:playtime:1484943179466801303> **Playtime**: ' .. playtime
        content = content .. '\n<:gems:1484943181459226764> **Gems**: ' .. gems
        content = content .. '\n<:deaths:1484943183082422302> **Deaths**: ' .. deaths
        content = content .. '\n<:wins:1484943178149925076> **Highest Win Streak**: ' .. winstreak
        content = content .. '\n<:mapscompleted:1484943180477759548> **Rounds Completed**: ' .. roundsCompleted
        content = content .. '\n**Sum of Maps Played**: ' .. formattedTotalTimesPlayed

        message:reply(content)
    elseif game == 'ABJ' then
        local content = ''
        local earlyAccess = 'No'

        if data.EarlyAccess then
            earlyAccess = 'Yes'
        end

        for fileNum = 1, 3 do
            local fileData = data.Files['File' .. fileNum]
            local powerOrbs = 0

            for _, worlds in pairs(fileData.PowerOrbs) do
                for _, _ in pairs(worlds) do
                    powerOrbs = powerOrbs + 1
                end
            end

            local playtime = formatTime(fileData.Stats.Playtime, 'Days')
            local sparks = addCommas(fileData.Coins)

            content = content .. '**File ' .. fileNum .. '**:```ansi'
            content = content .. '\n\u{001b}[1;2m' .. 'Power Orbs' .. '\u{001b}[0m: ' .. powerOrbs
            content = content .. '\n\u{001b}[1;2m' .. 'Playtime' .. '\u{001b}[0m: ' .. playtime
            content = content .. '\n\u{001b}[1;2m' .. 'Sparks' .. '\u{001b}[0m: ' .. sparks
            content = content .. '```\n'
        end

        content = content .. '**Early Access**: ' .. earlyAccess

        message:reply(content)
    end
end

return Stats
