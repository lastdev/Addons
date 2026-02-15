local ADDON, NS = ...
NS.UI = NS.UI or {}
local View = NS.UI.Viewer or {}
NS.UI.Viewer = View

View.Util         = View.Util         or {}
View.Data         = View.Data         or {}
View.Requirements = View.Requirements or {}
View.Search       = View.Search       or {}
View.Frames       = View.Frames       or {}
View.Render       = View.Render       or {}

if not View.Create then
    function View:Create(parent)
        local r = self.Render
        if r and r.Create then
            return r:Create(parent)
        end
        return nil
    end
end

return View
