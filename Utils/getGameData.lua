local Constants = require('Constants')

return function(game)
    game = game:upper()

    local info = Constants.PLACES[game]
    
    if not info then
        return false, Constants.ERRORS.GAME_NOT_FOUND
    end

    return info.UNIVERSE, info.PLACE, info.DATASTORE
end