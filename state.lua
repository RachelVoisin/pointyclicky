local GameState = {
    bucketMoved = false,
    chest01Open = false,
    chest02Open = false,
    crystalBroken = false,
    crystalLeftBroken = false,
    crystalRightBroken = false,
    manorDoorOpen = false,
    statueMoved = false,
    websCleaned = false,
    inv = {
        bottles = false,
        note = false,
        shovel = false,
        pickaxe = false
    }
}

GameStateHelper = {}

function GameStateHelper:get(id)
    return GameState[id]
end

function GameStateHelper:getInv(id)
    return GameState.inv[id]
end