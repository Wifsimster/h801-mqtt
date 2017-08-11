require('config')

function setColor(pin, val)
    if(tonumber(val) > 1023) then
        val = 1023
    end
    pwm.setduty(pin, tonumber(val))
end

function mqtt_state()
    TOPIC = '/data/'
    DATA = '{"mac":"'..mac..'","red":"'..pwm.getduty(RED)..'","green":"'..pwm.getduty(GREEN)..'","blue":"'..pwm.getduty(BLUE)..'"}'
    m:publish(TOPIC, DATA, 0, 0, function(conn)
        print(TOPIC.." : "..CLIENT_ID.." - "..DATA)
    end)
end

function mqtt_subscribe()
    TOPIC = '/action/'
    m:subscribe(TOPIC, 2, function(m)
        print("Successfully subscribed to the topic: "..TOPIC)
    end)
end

function mqtt_ping()
    TOPIC = '/ping/'
    DATA = '{"mac":"'..mac..'"}'
    m:publish(TOPIC, DATA, 0, 0, function(conn)
        print(TOPIC.." : "..CLIENT_ID)
    end)
end

function mqtt_online()
    TOPIC = '/online/'
    DATA = '{"mac":"'..mac..'","ip":"'..ip..'","name":"'..CLIENT_ID..'","type":"'..DEVICE_TYPE..'"}'
    m:publish(TOPIC, DATA, 0, 0, function(conn)
        print(TOPIC.." : "..CLIENT_ID)
    end)
end

function mqtt_ip()
    TOPIC = '/ip/'
    DATA = '{"mac":"'..mac..'","ip":"'..ip..'"}'
    m:publish(TOPIC, DATA, 0, 0, function(conn)
        print(TOPIC.." : "..DATA)
    end)
end

function mqtt_name()
    TOPIC = '/name/'
    DATA = '{"mac":"'..mac..'","name":"'..CLIENT_ID..'"}'
    m:publish(TOPIC, DATA, 0, 0, function(conn)
        print(TOPIC.." : "..DATA)
    end)
end

function mqtt_type()
    TOPIC = '/type/'
    DATA = '{"mac":"'..mac..'","type":"'..DEVICE_TYPE..'"}'
    m:publish(TOPIC, DATA, 0, 0, function(conn)
        print(TOPIC.." : "..DATA)
    end)
end
