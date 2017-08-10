-- Wifi Settings
AP = "WIFWIFI"
PWD = "192Wifsimster!!"

-- MQTT Broker
BROKER_IP = "192.168.0.35"
BROKER_PORT = 1883

-- MQTT Settings
CLIENT_ID = "ESP8266-"..node.chipid()
DEVICE_TYPE = "h801"

-- Device Settings
RED = 8         -- GPIO 15
GREEN = 7       -- GPIO 13
BLUE = 6        -- GPIO 12
W1 = 5          -- GPIO 14
W2 = 2          -- GPIO 4
LED_RED = 1     -- GPIO 5
LED_GREEN = 10  -- GPIO 1
