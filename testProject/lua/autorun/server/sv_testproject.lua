util.AddNetworkString("TestProject.MyInt")
util.AddNetworkString("TestProject.Weapon")
util.AddNetworkString("TestProject.Characters")
util.AddNetworkString("ShowTheLength")

// Simple Datentypen Networken
net.Receive("TestProject.MyInt", function(len, ply)
    local myInt = net.ReadInt(32)

    print("Received " .. myInt)
end)


// Sicherheit bei der Kommunikation

net.Receive("TestProject.Weapon", function(len, ply)
    if not ply:IsAdmin() then return end

    local wep = net.ReadString()

    ply:Give(wep)
end)


// Kommunikation Optimieren


local characters = {
    ["PLAYER01"] = {
        name = "Player 1",
        health = 100,
        armor = 0,
        inventory = {
            ["weapon_pistol"] = true,
            ["weapon_smg1"] = true,
        }
    },
    ["PLAYER02"] = {
        name = "Player 2",
        health = 100,
        armor = 0,
        inventory = {
            ["weapon_pistol"] = true,
            ["weapon_smg1"] = true,
        }
    },
    ["PLAYER03"] = {
        name = "Player 3",
        health = 100,
        armor = 0,
        inventory = {
            ["weapon_pistol"] = true,
            ["weapon_smg1"] = true,
        }
    },
    ["Player04"] = {
        name = "Player 4",
        health = 100,
        armor = 0,
        inventory = {
            ["weapon_pistol"] = true,
            ["weapon_smg1"] = true,
        }
    }
}

net.Start("TestProject.Characters")
    net.WriteInt(table.Count(characters), 10)
    for id, players in pairs(characters) do
        net.WriteString(id)
        net.WriteString(players.name)
        net.WriteInt(players.health, 8)
        net.WriteInt(players.armor, 8)
        net.WriteInt(table.Count(players.inventory), 10)
        for weapon, _ in pairs(players.inventory) do
            net.WriteString(weapon)
        end
    end
net.Send(Entity(1))

net.Start("ShowTheLength")
    net.WriteTable(characters)
net.Send(Entity(1))

