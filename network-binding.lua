wifiWatcher = nil
workSpaceWifiSSID = "MDL@SZ"
lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == workSpaceWifiSSID and lastSSID ~= workSpaceWifiSSID then
        hs.alert.show("you connected to workSpace wifi")
    elseif newSSID ~= workSpaceWifiSSID and lastSSID == workSpaceWifiSSID then
        hs.alert.show("you are not connected to workSpace wifi")
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()