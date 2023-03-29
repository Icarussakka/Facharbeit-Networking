// Simple Datentypen Networken

local myInt = 24

net.Start("TestProject.MyInt")
    net.WriteInt(myInt, 32)
net.SendToServer()

// Kommunikation sichern

hook.Add("OnPlayerChat", "TestProject.SecureNet", function(ply, text)
    if text:StartWith("!wep") then
        net.Start("TestProject.Weapon")
            net.WriteString(text:sub(6))
        net.SendToServer()
    end
end)


// Kommunikation Optimieren


myCharacters = {}

net.Receive("TestProject.Characters", function(len)
    local count = net.ReadUInt(10)
    for i = 1, count do
        local id = net.ReadString()
        local playerName = net.ReadString()
        local playerHealth = net.ReadInt(8)
        local playerArmor = net.ReadInt(8)
        local wepCount = net.ReadInt(10)

        myCharacters[id] = {}
        myCharacters[id].name = playerName
        myCharacters[id].health = playerHealth
        myCharacters[id].armor = playerArmor
        myCharacters[id].weapons = {}

        for j = 1, wepCount do
            local wep = net.ReadString()

            myCharacters[id].weapons[wep] = true
        end
    end

    print(len)
    PrintTable(myCharacters)
end)

net.Receive("ShowTheLength", function(len)
    local tbl = net.ReadTable()

    print(len)
end)
