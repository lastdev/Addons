local __exports = LibStub:NewLibrary("ovale", 90108)
if not __exports then return end
local __imports = {}
__imports.__scriptsindex = LibStub:GetLibrary("ovale/scripts/index")
__imports.registerScripts = __imports.__scriptsindex.registerScripts
__imports.__ioc = LibStub:GetLibrary("ovale/ioc")
__imports.IoC = __imports.__ioc.IoC
local registerScripts = __imports.registerScripts
local IoC = __imports.IoC
__exports.ioc = __imports.IoC()
registerScripts(__exports.ioc.scripts)
