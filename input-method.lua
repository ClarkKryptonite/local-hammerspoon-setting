-- helper hotkey to figure out the app path and name of current focused window
hs.hotkey.bind({ "ctrl", "cmd" }, ".", function()
	hs.alert.show(
		"App path:        "
			.. hs.window.focusedWindow():application():path()
			.. "\n"
			.. "App name:      "
			.. hs.window.focusedWindow():application():name()
			.. "\n"
			.. "BundleID:    "
			.. hs.window.focusedWindow():application():bundleID()
			.. "\n"
			.. "IM source id:  "
			.. hs.keycodes.currentSourceID()
	)
end)

function applicationWatcher(appName, eventType, appObject)
	if eventType == hs.application.watcher.activated or eventType == hs.application.watcher.launched then
		hs.keycodes.currentSourceID("im.rime.inputmethod.Squirrel.Hans")
	end
end

appWathcer = hs.application.watcher.new(applicationWatcher)
appWathcer:start()
