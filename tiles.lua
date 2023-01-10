local tiles = {
    [1] = {
        id = 1,
        image = "assets/images/tiles/north.jpg",
        canMoveNorth = false,
        northTile = nil,
        canMoveSouth = true,
        southTile = 3,
        canMoveWest = false,
        westTile = nil,
        canMoveEast = false,
        eastTile = nil
    },
    [2] = {
        id = 2,
        image = "assets/images/tiles/west.jpg",
        canMoveNorth = false,
        northTile = nil,
        canMoveSouth = false,
        southTile = nil,
        canMoveWest = false,
        westTile = nil,
        canMoveEast = true,
        eastTile = 3
    },
    [3] = {
        id = 3,
        image = "assets/images/tiles/central.jpg",
        canMoveNorth = true,
        northTile = 1,
        canMoveSouth = true,
        southTile = 5,
        canMoveWest = true,
        westTile = 2,
        canMoveEast = true,
        eastTile = 4
    },
    [4] = {
        id = 4,
        image = "assets/images/tiles/east.jpg",
        canMoveNorth = false,
        northTile = nil,
        canMoveSouth = false,
        southTile = nil,
        canMoveWest = true,
        westTile = 3,
        canMoveEast = false,
        eastTile = nil
    },
    [5] = {
        id = 5,
        image = "assets/images/tiles/south.jpg",
        canMoveNorth = true,
        northTile = 3,
        canMoveSouth = false,
        southTile = nil,
        canMoveWest = false,
        westTile = nil,
        canMoveEast = false,
        eastTile = nil
    }
}

TileHelper = {}

function TileHelper:getTiles()
    return tiles
end