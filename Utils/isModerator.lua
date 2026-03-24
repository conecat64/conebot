local Constants = require('Constants')

return function(message)
    if not message.member then
        return false
    end

    for _, role in pairs(message.member.roles) do
        for _, requiredRoleId in pairs(Constants.ADMIN_ROLES) do
            if role.id == requiredRoleId then
                return true
            end
        end
    end

    return false
end