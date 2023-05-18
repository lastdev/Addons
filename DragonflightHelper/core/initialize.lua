local _, ns = ...

ns.media = {}

ns.events = {}
ns.config = {}
ns.theme = {}

ns.components = {}

if DRAGONFLIGHT_HELPER_CONFIG == nil then
  DRAGONFLIGHT_HELPER_CONFIG = {}
end

if DRAGONFLIGHT_HELPER_CONFIG.theme == nil then
  DRAGONFLIGHT_HELPER_CONFIG.theme = {}
end
