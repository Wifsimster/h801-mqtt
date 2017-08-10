require('config')
require('functions')

print("Starting ESP"..node.chipid().."...")

wifi.setmode(wifi.STATION)
wifi.sta.config(AP,PWD)

print('MAC address:', wifi.sta.getmac())

tmr.create():alarm(10000, tmr.ALARM_AUTO, function(cb_timer)
    if wifi.sta.getip() == nil then
        print("Waiting for IP address...")
    else
        cb_timer:unregister()
        print("WiFi connection established")
        print("IP address: " .. wifi.sta.getip())
        if file.open("main.lua") ~= nil then
            --dofile("main.lua")
            
            pwm.setup(RED, 1000, 0)
            pwm.setup(GREEN, 1000, 0)
            pwm.setup(BLUE, 1000, 0)
                        
            readBrightness(RED)
            readBrightness(GREEN)
            readBrightness(BLUE)
            
            fade(1, RED)
            --fade(1, GREEN)
            --fade(1, BLUE)

            pwm.setduty(RED, 1020)

        else 
            print("main.lua doesn't exist !")
        end
    end
end)
