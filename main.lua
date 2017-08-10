require('config')
require('functions')

pwm.setup(RED, 1000, 0)
pwm.setup(GREEN, 1000, 0)
pwm.setup(BLUE, 1000, 0)

--gpio.mode(LED_RED, gpio.OUTPUT)
--gpio.write(LED_RED, gpio.HIGH)
--gpio.mode(LED_GREEN, gpio.OUTPUT)
--gpio.write(LED_GREEN, gpio.HIGH)

mac = wifi.sta.getmac()
ip = wifi.sta.getip()
m = mqtt.Client(CLIENT_ID, 120, "", "")

m:lwt("/lwt", '{"mac":"'..mac..'"}', 0, 0)

-- Try to reconnect to broker when communication is down
m:on("offline", function(con)
    ip = wifi.sta.getip()
    print ("MQTT reconnecting to "..BROKER_IP.." from "..ip)
    tmr.alarm(1, 10000, 0, function()
        node.restart()
    end)
end)

-- Toggle relay when message received from MQTT broker
m:on("message", function(conn, topic, data)
    mqtt_activity()
    print("Message received: " .. topic .. " : " .. data)
    parse = sjson.decode(data)
    mac = parse.mac
    action = parse.action
    print('MAC : '.. wifi.sta.getmac())
    if(mac == wifi.sta.getmac()) then
        if (action == "ON") then
            print("RGB on")
            setRed(1023)
            setGreen(1023)
            setBlue(1023)
            mqtt_state()
        elseif (action == "OFF") then
            print("RGB off")
            setRed(0)
            setGreen(0)
            setBlue(0)
            mqtt_state()
        elseif (action == "STATE") then
            mqtt_state()
        elseif (action == "PING") then
            mqtt_ping()
        elseif (action == "ONLINE") then
            mqtt_online()
        elseif (action == "IP") then
            mqtt_ip()
        elseif (action == "NAME") then
            mqtt_name()
        elseif (action == "TYPE") then
            mqtt_type()
        elseif (action == "RESET") then
            print("Restart node")
            node.restart()
        else
            print("Invalid action (" .. action .. ")")
        end
    end
end)

print("Connecting to "..BROKER_IP..":"..BROKER_PORT.."...")
m:connect(BROKER_IP, BROKER_PORT, 0, 1, function(conn)
    print("Connected to "..BROKER_IP..":"..BROKER_PORT.." as "..CLIENT_ID)
    --gpio.write(LED, gpio.HIGH)
    mqtt_online()
    mqtt_subscribe()
end)
