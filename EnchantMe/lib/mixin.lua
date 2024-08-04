local _, addon = ...

--- Add mixins into an object
function addon.mixin(object, ...)
    return Mixin(object, ...)
end

--- Create an object from the mixin
function addon.new(mixin, ...)
    if mixin.Init then
        return CreateAndInitFromMixin(mixin, ...)
    end

    return CreateFromMixins(mixin)
end

--- Override a mixin method
--
-- The first argument to newImpl is a super() function to call the original method.
function addon.overrideMixin(mixin, method, newImpl)
    local orig = mixin[method]

    mixin[method] = function (self, ...)
        local function super(...)
            return orig(self, ...)
        end

        return newImpl(self, super, ...)
    end
end

--- Bind a method to the given self
function addon.bind(self, method)
    return function (...)
        return self[method](self, ...)
    end
end
