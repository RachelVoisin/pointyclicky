local tiles = {
    [1] = {
        id = 1,
        file = love.graphics.newImage("assets/tiles/manor.png"),
        canMoveNorth = false,
        northTile = nil,
        canMoveSouth = true,
        southTile = 2,
        canMoveWest = false,
        westTile = nil,
        canMoveEast = false,
        eastTile = nil,
        layers = {
            doorClosed = {
                file = love.graphics.newImage("assets/tiles/manor-01.png"),
                conditions = {
                    manorDoorOpen = false
                }
            },
            doorOpen = {
                file = love.graphics.newImage("assets/tiles/manor-02.png"),
                conditions = {
                    manorDoorOpen = true
                }
            }
        }
    },
    [2] = {
        id = 2,
        file = love.graphics.newImage("assets/tiles/park.png"),
        canMoveNorth = true,
        northTile = 1,
        canMoveSouth = true,
        southTile = 3,
        canMoveWest = false,
        westTile = nil,
        canMoveEast = true,
        eastTile = 5,
        layers = {}
    },
    [3] = {
        id = 3,
        file = love.graphics.newImage("assets/tiles/woods.png"),
        canMoveNorth = true,
        northTile = 2,
        canMoveSouth = false,
        southTile = nil,
        canMoveWest = false,
        westTile = nil,
        canMoveEast = false,
        eastTile = nil,
        layers = {
            shovel = {
                file = love.graphics.newImage("assets/tiles/woods-01.png"),
                conditions = {
                    inv = {
                        shovel = false
                    }
                }
            },
            statue = {
                file = love.graphics.newImage("assets/tiles/woods-02.png"),
                conditions = {
                    statueMoved = false
                }
            },
            webs = {
                file = love.graphics.newImage("assets/tiles/woods-03.png"),
                conditions = {
                    websCleaned = false
                }
            },
            stairs = {
                file = love.graphics.newImage("assets/tiles/woods-04.png"),
                conditions = {
                    statueMoved = true
                }
            }
        }
    },
    [4] = {
        id = 4,
        file = love.graphics.newImage("assets/tiles/cave.png"),
        canMoveNorth = false,
        northTile = nil,
        canMoveSouth = false,
        southTile = nil,
        canMoveWest = false,
        westTile = nil,
        canMoveEast = false,
        eastTile = nil,
        layers = {
            bucket = {
                file = love.graphics.newImage("assets/tiles/cave-01.png"),
                conditions = {
                    bucketMoved = false
                }
            },
            pickaxe = {
                file = love.graphics.newImage("assets/tiles/cave-02.png"),
                conditions = {
                    inv = {
                        pickaxe = false
                    }
                }
            },
            crystal = {
                file = love.graphics.newImage("assets/tiles/cave-03.png"),
                conditions = {
                    crystalBroken = false
                }
            },
            crystalLeft = {
                file = love.graphics.newImage("assets/tiles/cave-04.png"),
                conditions = {
                    crystalLeftBroken = false
                }
            },
            crystalRight = {
                file = love.graphics.newImage("assets/tiles/cave-05.png"),
                conditions = {
                    crystalRightBroken = false
                }
            },
            shardsClosed = {
                file = love.graphics.newImage("assets/tiles/cave-06.png"),
                conditions = {
                    crystalBroken = true,
                    chest02Open = false
                }
            },
            shardsLeft = {
                file = love.graphics.newImage("assets/tiles/cave-07.png"),
                conditions = {
                    crystalLeftBroken = true
                }
            },
            shardsRight = {
                file = love.graphics.newImage("assets/tiles/cave-08.png"),
                conditions = {
                    crystalRightBroken = true
                }
            }
        }
    },
    [5] = {
        id = 5,
        file = love.graphics.newImage("assets/tiles/church.png"),
        canMoveNorth = false,
        northTile = nil,
        canMoveSouth = true,
        southTile = 6,
        canMoveWest = true,
        westTile = 2,
        canMoveEast = false,
        eastTile = nil,
        layers = {
            note = {
                file = love.graphics.newImage("assets/tiles/church-01.png"),
                conditions = {
                    inv = {
                        note = false
                    }
                }
            },
            boxEmpty = {
                file = love.graphics.newImage("assets/tiles/church-02.png"),
                conditions = {
                    inv = {
                        bottles = true
                    }
                }
            },
            boxFull = {
                file = love.graphics.newImage("assets/tiles/church-03.png"),
                conditions = {
                    inv = {
                        bottles = false
                    }
                }
            }
        }
    },
    [6] = {
        id = 6,
        file = love.graphics.newImage("assets/tiles/farm.png"),
        canMoveNorth = true,
        northTile = 5,
        canMoveSouth = false,
        southTile = nil,
        canMoveWest = false,
        westTile = nil,
        canMoveEast = true,
        eastTile = 7,
        layers = {}
    },
    [7] = {
        id = 7,
        file = love.graphics.newImage("assets/tiles/cottage.png"),
        canMoveNorth = false,
        northTile = nil,
        canMoveSouth = false,
        southTile = nil,
        canMoveWest = true,
        westTile = 6,
        canMoveEast = false,
        eastTile = nil,
        layers = {
            chest = {
                file = love.graphics.newImage("assets/tiles/cottage-01.png"),
                conditions = {
                    chest01Open = false
                }
            }
        }
    }
}

-- manor = 1
-- park = 2
-- woods = 3
-- cave = 4
-- church = 5
-- farm = 6
-- cottage = 7

-- would need better newImage management if there were more images I imagine...

TileHelper = {}

function TileHelper:getTiles()
    return tiles
end

function TileHelper:drawTile(tx, ty)
    love.graphics.draw(CURRENT_TILE.file, tx, ty)

    for i, layer in pairs(CURRENT_TILE.layers) do
        local drawLayer = true
        for stateID, condition in pairs(layer.conditions) do
            if stateID == "inv" then
                for invID, invCondition in pairs(condition) do
                    if GameStateHelper:getInv(invID) ~= invCondition then
                        drawLayer = false
                    end
                end
            elseif GameStateHelper:get(stateID) ~= condition then
                drawLayer = false
            end
        end
        if (drawLayer) then
            love.graphics.draw(layer.file, tx, ty)
        end
    end
end