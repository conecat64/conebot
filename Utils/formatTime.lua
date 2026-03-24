return function(seconds, formatType)
    seconds = tonumber(seconds)

    if formatType == 'Days' then
        if seconds < 0 then
            return '???'
        end

        return ('%id %ih %02im %02is'):format(seconds / 86400, (seconds / 3600) % 24, (seconds / 60) % 60, seconds % 60)
    elseif formatType == 'Precise' then
        if seconds < 0 then
            return '0:00.00'
        end

        return ('%i:%02i.%02i'):format(seconds / 60, seconds % 60, (seconds % 1) * 100)
    end
end
