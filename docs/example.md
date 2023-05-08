---
sidebar_position: 3
---

# Examples

Here are just a few examples of where I believe this module can be of great use!

### Battle Turn Sequence
You can use the `Sequence` module to run a turn-based game for players or mobs! Feel free to sort it however you'd like, the possibilities are endless!
```lua
local TurnSequence = Sequence.new({ Autotick = false }, function(playerAttacks: {})
    for _, playerAttack in playerAttacks do
        -- Yield to perform player actions
        playerAttack()
    end
end)

-- Player 1
TurnSequence:Includes(function()
    PlayerService:CastSpell("Regeneration")
end)

-- Player 2
TurnSequence:Includes(function()
    PlayerService:Attack("Kobald")
end)

-- Player 3
TurnSequence:Includes(function()
    PlayerService:Move("Forward", 1) -- Maybe moves have higher priority than attacks?
end)

-- When it comes to player turn sequence
TurnSequence:ForceTick()
```

### Round System
By turning off Autotick and ClearOnTick, we're able to call when we want our sequence to run. As well as, the functions don't get removed after being put through the `tick cycle`. This way, we can continue running the rounds recursively! You can also stop the round at anytime by using `:Clean()`.
```lua
local currentRound = 1

local RoundSequence = Sequence.new({ Autotick = false, ClearOnTick = false }, function(roundSequence)
    for _, roundFunc in roundSequence do
        roundFunc(currentRound)
    end
    
    currentRound += 1
end)

-- Intermission
RoundSequence:Includes(function(currentRound)
    -- Notify intermission timer
end)

-- Start Round
RoundSequence:Includes(function(currentRound)
    -- Teleport players into arena
    -- Spawn all weapons
end)

-- In-Game Match
RoundSequence:Includes(function(currentRound)
    -- Listen for player attacks
    -- Notify match countdown timer
end)

-- Reward Players
RoundSequence:Includes(function(currentRound)
    -- Give winner rewards
end)

-- Match End
RoundSequence:Includes(function(currentRound)
    -- Restart the match!
    RoundSequence:ForceTick()
end)

RoundSequence:ForceTick()
```

### Compacting a Network Package
You can also successfully group tons of information that you'd like to send across to client(s)!
```lua
local Package = Sequence.new({ Autotick = true }, function(packageLoad)
    PackageRemote:FireAllClients(packageLoad)
end)

Package:Includes("Purchase Success!")
Package:Includes({
    PetName = "Dog",
    PetId = 3,
})
```