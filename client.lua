local menuCoords = Config.menucoords 
local vehicleCoords = Config.vehiclecoords

local uiTextSpawn = Config.openmenu
local uiTextDeposit = Config.vehiclelabel

local function isPlayerPolice()
    if Config.framework == 'qbx' then
        local playerData = exports.qbx_core:GetPlayerData()
        if playerData.job.name == "police" then
            return true
        end
    elseif Config.framework == 'qb' then
        local PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData.job.name == "police" then
            return true
        end
    elseif Config.framework == 'esx' then
        -- For ESX framework
        local playerData = ESX.GetPlayerData()
        if playerData.job.name == "police" then
            return true
        end
    else
       -- IF CUSTOM FRAMEWORK ADD LOGIC HERE
        return false
    end
    return false
end

local function spawnVehicle(model)
    if not isPlayerPolice() then
        lib.notify({
            title = Config.accesdeniedtitle,
            description = Config.accesdenieddesc,
            type = 'error'
        })
        return
    end

    local vehicleModel = GetHashKey(model)
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(100)
    end

    local vehicle = CreateVehicle(vehicleModel, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, vehicleCoords.w, true, false)

    if DoesEntityExist(vehicle) then
        local playerPed = PlayerPedId()
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

        SetVehicleEngineOn(vehicle, true, true, false)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleFuelLevel(vehicle, 100.0)

        SetModelAsNoLongerNeeded(vehicleModel)
    end
end

local function storeVehicle()
    if not isPlayerPolice() then
        lib.notify({
            title = Config.accesdeniedtitle,
            description = Config.accesdenieddesc,
            type = 'error'
        })
        return
    end

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle ~= 0 then
        DeleteEntity(vehicle)
        lib.hideTextUI()
        lib.notify({
            title = Config.notifydeposititle,
            description = Config.notifydepositdesc,
            type = 'success'
        })
    else
        lib.notify({
            title = Config.nocartitle,
            description = Config.nocardesc,
            type = 'error'
        })
    end
end

lib.registerContext({
    id = 'some_menu',
    title = Config.menutitle,
    options = {
        {
            title = 'Police 1',
            icon = 'car',
            onSelect = function()
                spawnVehicle("police")
            end,
        },
        {
            title = 'Police 2',
            icon = 'car',
            onSelect = function()
                spawnVehicle("police2")
            end,
        },
        {
            title = 'Police 3',
            icon = 'car',
            onSelect = function()
                spawnVehicle("police3")
            end,
        },
        {
            title = 'Police Interceptor',
            icon = 'car',
            onSelect = function()
                spawnVehicle("police4")
            end,
        },
        {
            title = 'Police Bike',
            icon = 'motorcycle',
            onSelect = function()
                spawnVehicle("policeb")
            end,
        },
    }
})

local menuPoint = lib.points.new({
    coords = menuCoords,
    distance = 20,
})

local vehiclePoint = lib.points.new({
    coords = vec3(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z),
    distance = 5, 
})

local menuMarker = lib.marker.new({
    coords = menuCoords,
    type = 1,
})

local vehicleMarker = lib.marker.new({
    coords = vec3(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z),
    type = 1,
})

function menuPoint:nearby()
    menuMarker:draw()

    if self.currentDistance < 1.5 then
        if not lib.isTextUIOpen() then
            lib.showTextUI(uiTextSpawn)
        end
        if IsControlJustPressed(0, 51) then  
            if isPlayerPolice() then
                lib.showContext('some_menu')
            else
                lib.notify({
                    title = Config.accesdeniedtitle,
                    description = Config.accesdenieddesc,
                    type = 'error'
                })
            end
        end
    else
        local isOpen, currentText = lib.isTextUIOpen()
        if isOpen and currentText == uiTextSpawn then
            lib.hideTextUI()
        end
    end
end

function vehiclePoint:nearby()
    vehicleMarker:draw()

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle ~= 0 then
        if not lib.isTextUIOpen() then
            lib.showTextUI(uiTextDeposit)
        end
        if IsControlJustPressed(0, 51) then  
            storeVehicle()
        end
    else
        local isOpen, currentText = lib.isTextUIOpen()
        if isOpen and currentText == uiTextDeposit then
            lib.hideTextUI()
        end
    end
end

-- Helicopter

local kopumenuCoords = Config.kopumenucoords 
local kopuCoords = Config.kopucoords

local uiTextSpawn = Config.openhmenu
local uiTextDeposit = Config.vehiclelabel

local function spawnVehicle(model)
    if not isPlayerPolice() then
        return
    end

    local vehicleModel = GetHashKey(model)
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(100)
    end

    local vehicle = CreateVehicle(vehicleModel, kopuCoords.x, kopuCoords.y, kopuCoords.z, kopuCoords.w, true, false)

    if DoesEntityExist(vehicle) then
        local playerPed = PlayerPedId()
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

        SetVehicleEngineOn(vehicle, true, true, false)
        SetVehicleDirtLevel(vehicle, 0.0)
        SetVehicleFuelLevel(vehicle, 100.0)

        SetModelAsNoLongerNeeded(vehicleModel)
    end
end

local function storeVehicle()
    if not isPlayerPolice() then
        lib.notify({
            title = Config.accesdeniedtitle,
            description = Config.accesdenieddesc,
            type = 'error'
        })
        return
    end

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle ~= 0 then
        DeleteEntity(vehicle)
        lib.hideTextUI()
        lib.notify({
            title = Config.notifydeposititle,
            description = Config.notifydepositdesc,
            type = 'success'
        })
    else
        lib.notify({
            title = Config.nocartitle,
            description = Config.nocardesc,
            type = 'error'
        })
    end
end

local menuPoint = lib.points.new({
    coords = kopumenuCoords,
    distance = 20,
})

local vehiclePoint = lib.points.new({
    coords = vec3(kopuCoords.x, kopuCoords.y, kopuCoords.z),
    distance = 5, 
})

local menuMarker = lib.marker.new({
    coords = kopumenuCoords,
    type = 1,
})

local vehicleMarker = lib.marker.new({
    coords = vec3(kopuCoords.x, kopuCoords.y, kopuCoords.z),
    type = 1,
})

function menuPoint:nearby()
    menuMarker:draw()

    if self.currentDistance < 1.5 then
        if not lib.isTextUIOpen() then
            lib.showTextUI(uiTextSpawn)
        end
        if IsControlJustPressed(0, 51) then
            spawnVehicle('polmav')
            if isPlayerPolice() then              
            else
                lib.notify({
                    title = Config.accesdeniedtitle,
                    description = Config.accesdenieddesc,
                    type = 'error'
                })
            end
        end
    else
        local isOpen, currentText = lib.isTextUIOpen()
        if isOpen and currentText == uiTextSpawn then
            lib.hideTextUI()
        end
    end
end

function vehiclePoint:nearby()
    vehicleMarker:draw()

    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle ~= 0 then
        if not lib.isTextUIOpen() then
            lib.showTextUI(uiTextDeposit)
        end
        if IsControlJustPressed(0, 51) then  
            storeVehicle()
        end
    else
        local isOpen, currentText = lib.isTextUIOpen()
        if isOpen and currentText == uiTextDeposit then
            lib.hideTextUI()
        end
    end
end

