return {
    PREFIX = 'c!',

    GUILD_ID = '1186212011869216899',
    GUEST_ROLE = '1409280989863084206',

    CHANNELS = {
        VERIFICATION = '1409279931426541638',
        CREATIONS = '1286798310518296606',
        BOTS = '1474172093229830386'
    },

    PLACES = {
        SB64 = {
            UNIVERSE = '5402993487',
            PLACE = '15644138782',
            DATASTORE = 'ReleaseData'
        },

        SR = {
            UNIVERSE = '6182655829',
            PLACE = '18238180555',
            DATASTORE = 'SaveData',
            MAP_NAMES = {
                { ID = 'Candy', Display = 'Sweet Speedway' },
                { ID = 'Classic', Display = 'Retro Raceway' },
                { ID = 'City', Display = 'Midnight Rush' },
                { ID = 'Water', Display = 'Underwater Highway' },
                { ID = 'Bomb', Display = 'Magma Bomb Blitz' },
                { ID = 'Bedroom', Display = 'Bedroom' },
                { ID = 'SlimeFactory', Display = 'Slime Factory' },
                { ID = 'FloodedCity', Display = 'Flooded City' },
                { ID = 'Sodacan', Display = 'Sodacan Canyon' },
                { ID = 'Dream', Display = 'Lucid Lane' },
                { ID = 'Space', Display = 'Space Station' },
                { ID = 'Surf', Display = 'Surfer\'s Paradise' },
                { ID = 'Snow', Display = 'Winter Wonderland' },
                { ID = 'Cowboy', Display = 'Sunset Oasis' },
                { ID = 'Skyline', Display = 'Sky-High Ropeway' },
                { ID = 'RollBall', Display = 'Marble Mania' },
                { ID = 'Jungle', Display = 'Jungle Underpass' },
                { ID = 'WaterWalk', Display = 'Abandoned Lab' },
            }
        },

        ABJ = {
            UNIVERSE = '7813156957',
            PLACE = '110541442509291',
            DATASTORE = 'ABJData',
            GAMEPASS = '1507450319',
            ROLE = '1465072717865681018'
        },

        VERIFICATION = {
            UNIVERSE = '9758099827',
            PLACE = '89278385343266',
            DATASTORE = 'CodeStore',
        },
    },

    HEADERS = {
        { 'x-api-key',    'Nope' },
        { 'Content-Type', 'application/json' }
    },

    ERRORS = {
        NO_CODE = 'API did not provide a code.',
        FAILED_JSON_DECODE = 'Failed to decode JSON string into table.',
        FAILED_JSON_ENCODE = 'Failed to encode JSON into string.',
        RESPONSE_NOT_200 = 'Response did not return code 200.',
        GAME_NOT_FOUND = 'Game not found.\nPlease input a valid game: `sb64` | `sr` | `abj`',
        ROBLOX_ID_NOT_FOUND = 'Could not retrieve Roblox ID for inputted user.',
        NO_USERNAME = 'No username was inputted.',
        DATA_NOT_CREATED = 'No data could be retrieved.',
        NOT_VERIFIED = 'User is not verified.',
    },

    COMMANDS = {
        'help',
        'ban',
        'unban',
        'getRoblox', 
        'linkRoblox',
        'giveEarlyAccess',
        'redeemEarlyAccess',
        'say',
        'stats',
        'verify',
        'uptime',
        'test',
        'purge',
    },

    ADMIN_ROLES = {
        '1186212809789411389',
        '1394442434200735847',
        '1186213139965038622',
        '1187862837054414960'
    },
}
