local isTeleporting = false -- Track teleportation state

local function tryTeleport(ID)
    if isTeleporting then
        print("Already teleporting. Waiting...")
        repeat
            task.wait(0.5)
        until not isTeleporting
    end

    print("Attempting to teleport to server ID:", ID)
    table.insert(AllIDs, ID)
    saveIDs()
    isTeleporting = true -- Mark teleportation as in progress

    local success, errorMsg = pcall(function()
        TeleportService:TeleportToPlaceInstance(PlaceID, ID, Players.LocalPlayer)
    end)

    if not success then
        print("Teleport failed:", errorMsg)
        isTeleporting = false -- Reset teleportation state if it fails
    end
end

-- Teleporting Completed Event
TeleportService.TeleportInitFailed:Connect(function()
    print("Teleport failed. Resetting state.")
    isTeleporting = false
end)

Players.LocalPlayer.OnTeleport:Connect(function()
    print("Teleport completed.")
    isTeleporting = false
end)
