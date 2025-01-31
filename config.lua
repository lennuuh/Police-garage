Config = {
    framework = 'qbx', -- esx, qb, qbx, custom. -- if custom edit client.lua line 25
    menucoords = vec3(459.6695, -986.6153, 24.90),  --  Car garage menu open location
    vehiclecoords = vec4(458.7417, -992.4564, 24.80, 177.2746), -- Spawn & deposit location for car
    kopumenucoords = vec4(458.7358, -987.7928, 42.8914, 85.4700), -- Where is the helicopter spawned from
    kopucoords = vec4(449.1470, -981.4072, 42.8914, 91.4779), -- Where the helicopter will be spawned
    
    -- Labels
    openmenu = "[E] Open police garage", -- Label for the textui when opening garage
    openhmenu = "[E] Take a helicopter out", -- Label for the textui when taking out a helicopter
    vehiclelabel = "[E] Deposit the vehicle", -- Label for the textui when depositing a vehicle
    notifydeposititle = "Vehicle deposited", -- Notification title when vehicle is deposited
    notifydepositdesc = "Vehicle is now deposited", -- Notification description when vehicle is deposited
    nocartitle = "Police Garage", -- Notification title when trying to deposit but not in a car
    nocardesc = "You are not in a vehicle!", -- Notification description when trying to deposit but not in a car
    menutitle = "Police Garage", -- Context menu title
    accesdeniedtitle = 'Access Denied', -- Notification title if trying to access garage when not police
    accesdenieddesc = 'You are not police!' -- Notification description if trying to access garage when not police
}
