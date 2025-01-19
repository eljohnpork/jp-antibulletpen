-- Config
local MAX_ALLOWED_PENETRATION = 0.5 -- Max penetration meters
local WARNING_THRESHOLD = 3 -- Hoeveelheid waarschuwingen voordat speler word gekicked / banned
local COOLDOWN_TIME = 3000 -- Tijd in sec voor reset van warnings
local KICK_MESSAGE = "Cheating: bullet penetration."
local playerWarnings = {}

-- Functie voor uitrekenen
local function calculateDistance(startCoords, endCoords)
    return #(startCoords - endCoords)
end

local function isBulletPenetrating(entityHit, startCoords, endCoords)
    if not DoesEntityExist(entityHit) then return false end

    local hitDistance = calculateDistance(startCoords, endCoords)

    return hitDistance > MAX_ALLOWED_PENETRATION
end

local function trackPlayerWarnings(playerId)
    if not playerWarnings[playerId] then
        playerWarnings[playerId] = {count = 0, lastWarning = os.time()}
    end

    local warningData = playerWarnings[playerId]
    local currentTime = os.time()

    -- Reset warnings if the cooldown time has passed
    if currentTime - warningData.lastWarning > COOLDOWN_TIME then
        warningData.count = 0
    end

    warningData.count = warningData.count + 1
    warningData.lastWarning = currentTime

    return warningData.count
end

local function handleCheater(playerId)
    for _, adminId in ipairs(GetPlayers()) do
        if IsPlayerAdmin(adminId) then
            TriggerClientEvent('chat:addMessage', adminId, {
                args = {"Anti-Cheat", "Speler " .. GetPlayerName(playerId) .. " waarschuwing voor mogelijk bullet pen."}
            })
        end
    end
    print("[Anti-Cheat] Speler " .. GetPlayerName(playerId) .. " gebruikt cheats.")
    DropPlayer(playerId, KICK_MESSAGE)
end

AddEventHandler('gameEventTriggered', function(eventName, eventData)
    if eventName == "CEventGunShotBulletImpact" then
        local shooter = eventData[1]
        local entityHit = eventData[4]
        local startCoords = vector3(eventData[5], eventData[6], eventData[7])
        local endCoords = vector3(eventData[8], eventData[9], eventData[10])

        if shooter and DoesEntityExist(shooter) and IsEntityAPed(shooter) then
            local playerId = NetworkGetPlayerIndexFromPed(shooter)

            if isBulletPenetrating(entityHit, startCoords, endCoords) then
                local warningCount = trackPlayerWarnings(playerId)

                if warningCount >= WARNING_THRESHOLD then
                    handleCheater(playerId)
                else
                    print("[Anti-Cheat] Speler " .. GetPlayerName(playerId) .. " heeft een waarschuwing " .. warningCount .. " voor bullet pen.")
                end
            end
        end
    end
end)

RegisterCommand('checkbulletpen', function(source, args, rawCommand)
    if source > 0 then
        TriggerClientEvent('chat:addMessage', source, {
            args = {"Anti-Cheat", "Pen checks staan aan."}
        })
    else
        print("Pen checks staan aan.")
    end
end, false)

-- Check deze g@y shit na want waarschijnlijk heb ik het fout gedaan de return is goed alleen check welke group je de melding krijgt en shit
function IsPlayerAdmin(playerId)
    local xPlayer = playerId()
    if xPlayer.getGroup() == 'admin' then
        return IsPlayerAceAllowed(playerId, "command")
    end
end
