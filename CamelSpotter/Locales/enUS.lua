local addOn = select(2,...)
addOn.L = addOn.L or {}

setmetatable(addOn.L, {
    __index = function(self, key)
        self[key] = (key or true)
        return key
    end
    }
)