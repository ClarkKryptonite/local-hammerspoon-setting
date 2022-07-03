local application = require("hs.application")
local hotkey = require("hs.hotkey")
local alert = require("hs.alert")

-- disable spotlight for name search
application.enableSpotlightForNameSearches(false)

-- hyper
local hyper = { "alt" }

-- this part is for open or focus app windows
local key2App = {
	["0"] = "com.apple.systempreferences",
	["1"] = "com.apple.ActivityMonitor",
	["2"] = "com.apple.iBooksX",
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
	h = "com.luckymarmot.Paw", -- h for http request paw
	i = "com.jetbrains.intellij", -- i for IDEA
	-- j = "Spotify",
	-- k = "",
	-- l = 'Dictionary',
	m = "com.tencent.QQMusicMac", -- m for Music
	n = "com.prect.NavicatPremium15", -- n for Navicat Premium
	o = "com.microsoft.onenote.mac", -- o for OneNote
	p = "com.jetbrains.pycharm", -- p for PyCharm
	q = "com.tencent.qq", -- q for QQ
	-- r = 'com.apple.reminders',
	-- s = 'com.spotify.client', -- s for spotify.If is ok for six months, it should replace 'm' key.
	t = "com.tdesktop.Telegram", -- t for Telegram
	-- u∫
	v = "com.colliderli.iina", -- v for VideoPlayer
	w = "com.tencent.xinWeChat", -- w for WeChat
	-- x = 'Sublime Text',
	-- y = 'Dictionary',
	z = "com.googlecode.iterm2", -- z for iTerm2
}

for key, app in pairs(key2App) do
	hotkey.bind(hyper, key, function()
		--application.launchOrFocus(app)
		toggle_application(app)
		--hs.grid.set(hs.window.focusedWindow(), gomiddle)
	end)
end

-- Toggle application focus
function toggle_application(_appBundleId)
	-- finds a running applications
	local app = application.get(_appBundleId)
	print("---toggle application:" .. _appBundleId)
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
		local isAppFront = app:isFrontmost()
		if true == isAppFront then
			toggle_window(app, mainwin)
		else
			app:unhide()
			app:activate(true)
			mainwin:focus()
		end
	else
		print("toggle_application mainwind null")
		-- ctrl-w close app
		application.launchOrFocusByBundleID(_appBundleId)
		app:unhide()
		app:activate(true)
	end
end

function toggle_window(app, mainwin)
	local allWindows = app:allWindows()
	print("toggle_window mainWindow:" .. mainwin:title())
	if allWindows and #allWindows > 1 then
		local focusIndex = 1
		for index, value in ipairs(allWindows) do
			print("toggle_window index:" .. index)
			print("toggle_window title:" .. value:title())
			if mainwin:id() == value:id() then
				focusIndex = index
				break
			end
		end
		-- table index start with 1
		local nextFocusIndex = focusIndex % #allWindows + 1
		print("toggle_window nextWindow:" .. allWindows[nextFocusIndex]:title())
		allWindows[nextFocusIndex]:focus()
	else
		app:hide()
	end
end
