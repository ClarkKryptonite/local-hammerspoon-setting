local application = require "hs.application"
local hotkey = require "hs.hotkey"
local alert = require "hs.alert"

-- hyper
local hyper = {"alt"}

-- this part is for open or focus app windows
local key2App = {
    ["0"] = "com.apple.systempreferences",
    ["1"] = "com.apple.ActivityMonitor",
    ["3"] = "com.apple.calculator",
    ["4"] = "com.apple.Dictionary",
    ["5"] = "com.apple.Notes",
    ["6"] = "com.apple.finder",
    ["7"] = "com.apple.Preview",
    ["9"] = "com.apple.reminders",
    a = "com.google.android.studio",
    b = "com.google.Chrome", -- b for Browser
    c = "com.jetbrains.CLion", --c for Clion
    d = "com.alibaba.DingTalkMac", -- d for DingTalk
    e = "com.microsoft.VSCode", -- e for Editor
    -- f = "com.apple.finder", -- f for finder
    -- g used --center babe
    h = 'com.luckymarmot.Paw', -- h for http request paw
    i = "com.jetbrains.intellij", -- i for IDEA
    -- j = "Spotify",
    -- k = "",
    -- l = 'Dictionary',
    m = "com.tencent.QQMusicMac", -- m for Music
    n = 'com.prect.NavicatPremium15', -- n for Navicat Premium
    o = "com.microsoft.onenote.mac", -- o for OneNote
    p = "com.jetbrains.pycharm", -- p for PyCharm
    q = "com.tencent.qq", -- q for QQ
    -- r = 'com.apple.reminders',
    s = 'com.spotify.client', -- s for spotify.If is ok for six months, it should replace 'm' key.
    t = "com.tdesktop.Telegram", -- t for Telegram
    -- u∫
    v = 'com.colliderli.iina', -- v for VideoPlayer
    w = 'com.tencent.xinWeChat', -- w for WeChat
    -- x = 'Sublime Text',
    -- y = 'Dictionary',
    z = 'com.googlecode.iterm2' -- z for iTerm2
}

for key, app in pairs(key2App) do
    hotkey.bind(
        hyper,
        key,
        function()
            --application.launchOrFocus(app)
            toggle_application(app)
            --hs.grid.set(hs.window.focusedWindow(), gomiddle)
        end
    )
end

-- Toggle application focus
function toggle_application(_appBundleId)
    -- finds a running applications
    local app = application.get(_appBundleId)
    if not app then
        -- application not running, launch app
        -- alert.show("not appBundleId : ".._appBundleId)
        application.launchOrFocusByBundleID(_appBundleId)
        return
    end
    -- application running, toggle hide/unhide
    local mainwin = app:mainWindow()
    -- confirm app name, usually application name is in left-top corner besides apple icon.
    -- alert.show("pid:"..tostring(app:pid()).."-bundleId:"..tostring(app:bundleID()).."-name:"..app:name())
    if mainwin then
        if true == app:isFrontmost() then
            app:hide()
        else
            mainwin:application():activate(true)
            mainwin:application():unhide()
            mainwin:focus()
        end
    else
        -- no windows, maybe hide
        -- don't use isHidden(), if u hide app with cmd+w, isHidden() is false
        -- if true == app:hide() then
        --     -- focus app
        --     application.launchOrFocusByBundleID(_appBundleId)
        -- else
        --     -- do nothing
        --     alert.show("do nothing")
        -- end
        application.launchOrFocusByBundleID(_appBundleId)
    end
end