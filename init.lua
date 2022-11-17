-- -----------------------------------------------------------------------
--           ** HammerSpoon Config File by S1ngS1ng with ❤️ **           --
-- -----------------------------------------------------------------------
--   ***   Please refer to README.MD for instructions. Cheers!    ***   --
-- -----------------------------------------------------------------------
--                         ** Something Global **                       --
-- -----------------------------------------------------------------------
-- Uncomment this following line if you don't wish to see animations
-- hs.window.animationDuration = 0
-- -----------------------------------------------------------------------
--                            ** Requires **                            --
-- -----------------------------------------------------------------------
-- require "key-binding"
-- require("network-binding")

require("toggle-application")
-- require("windows")
require("input-method")
-- require("caffeinate")

-- -----------------------------------------------------------------------
--                            ** For Debug **                           --
-- -----------------------------------------------------------------------
local function reloadConfig(paths)
    local doReload = false
    for _, path in pairs(paths) do
        print("reloadConfig path:" .. path)
        if string.find(path, ".lua") then
            print("has lua file")
            doReload = true
            break
        end
    end
    if doReload then
        hs.reload()
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "h", function()
    hs.reload()
end)
hs.alert.show("Config loaded")
