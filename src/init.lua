--!strict

--[[
    @class Sequence
    License: MIT

    Author(s):
        Alex/EnDarke
    Date:
        05/06/23
    Description:
        Used to load up tasks and run them on next defer, or when forcefully flushed.

    Functions:
        ```lua
        .new<T>() : Sequence<T> | nil
            -- Creates a new Sequence object
        :Includes<T>(T) : SequenceTable<T>
            -- Adds an object to the Sequence to be run on Sequence:ForceTick()
        :Excludes<T>(number) : T
            -- Removes an object from the Sequence at given index
        :ExcludeFromObject<T>(T) : number
            -- Removes an object from the Sequence based on object given
        :Get<T>(number) : T
            -- Gets the object at given index or first
        :Set<T>(T, number) : SequenceTable<T>
            -- Sets object at given index or first
        :ForceTick() : void
            -- Forcefully runs the function Sequence:_tick() if not currently ticking
        :Iterate<T>(number) : void
            -- Like :ForceTick(), but only iterates over objects up to index input.
            -- This will run the number inputted regardless of sequence indexes.
        :GetCurrentSequence<T>() : SequenceTable<T>
            -- Gets the current sequence table
        :SetCurrentLimit(number) : void
            -- Sets the sequence limit on amount given or nil
        :Clean() : void
            -- Cleans up the Sequence for a fresh start
        :Destroy() : void
            -- Used to clean and completely remove Sequence object permanently
        ```
]]

-- Declaring Custom Types
type void = nil
type callback = () -> void
type SequenceTable<T> = { T }
type Sequence<T> = typeof(setmetatable({})) & {
    new: <T>({}, callback) -> Sequence<T>;
    Includes: <T>(T) -> SequenceTable<T>;
    Excludes: <T>(number) -> T;
    ExcludeFromObject: <T>(T) -> number;
    Get: <T>(number) -> T;
    Set: <T>(T, number) -> SequenceTable<T>;
    GetCurrentSequence: () -> SequenceTable<T>;
    SetCurrentLimit: (number) -> void;
    Iterate: (number) -> void;
    ForceTick: () -> void;
    Clean: () -> void;
    Destroy: () -> void;
}

-- Module Code
local Sequence = {}
Sequence.__index = Sequence

function Sequence.new<T>(settings: {}, callback: callback) : Sequence<T> | nil
    if not ( callback ) then
        error(".new() | Sequence needs a callback function")
    end

    local self: Sequence<T> = setmetatable({}, Sequence)

    -- Settings
    self._autotick = settings.Autotick ~= nil and settings.Autotick or true
    self._clearOnTick = settings.ClearOnTick ~= nil and settings.ClearOnTick or true
    self._limit = settings.Limit

    -- Properties
    self._sequence = {} :: Sequence<T>
    self._onTick = callback :: callback
    self._isTicking = false
    self._tickScheduled = false

    self._defer = nil :: thread

    return self
end

function Sequence:Includes<T>(object: T, index: number) : SequenceTable<T>
    if not ( index ) then
        index = self:_findNextIndex()
    end

    table.insert(self._sequence, index, object)

    -- Sequence ceiling limiter
    if ( self._limit and (#self._sequence > self._limit) ) then
        self:Excludes(#self._sequence)
    end

    -- Check if on autotick/run tick sequence
    if ( self._autotick ) then
        self:_tick()
    end

    return self._sequence
end

function Sequence:Excludes<T>(index: number) : T | nil
    if not ( index ) then
        index = 1
    end

    -- Find object and remove
    local removedObject: T = table.remove(self._sequence, index)
    if not ( removedObject ) then
        warn(":Excludes<T>() | Could not find object at index: " .. index)
        return
    end

    return removedObject
end

function Sequence:ExcludeFromObject<T>(object: T) : void
    if not ( object ) then
        error(":ExcludeFromObject<T>() | Needs object input to perform action")
    end

    local foundIndex: number = table.find(self._sequence, object)
    if not ( foundIndex ) then
        warn(":ExcludeFromObject<T>() | Could not find object within sequence")
        return
    end

    table.remove(self._sequence, foundIndex)

    return foundIndex
end

function Sequence:Get<T>(index: number) : T | nil
    if not ( index ) then
        index = 1
    end

    local foundObject: T = self._sequence[index]
    if not ( foundObject ) then
        warn(":Get<T>() | Could not find object at index: " .. index)
        return
    end

    return foundObject
end

function Sequence:Set<T>(object: T, index: number) : SequenceTable<T> | nil
    if not ( object ) then
        error(":Set<T>() | Object is missing")
    end

    if not ( index ) then
        index = 1
    end

    if ( self._limit and (index > self._limit) ) then
        warn(":Set<T>() | Cannot set object higher than limit")
    end

    self._sequence[index] = object

    return self._sequence
end

function Sequence:GetCurrentSequence<T>() : SequenceTable<T>
    return self._sequence
end

function Sequence:SetCurrentLimit(amount: number) : void
    self._limit = amount
end

function Sequence:Iterate<T>(stopAt: number) : void
    if not ( stopAt ) then
        error(":Iterate<T>() | Cannot iterate without inputting a number to stop at")
    end

    if ( self._autotick ) then
        warn(":Iterate<T>() | Cannot run whilst Autotick is enabled")
    end

    -- Local Variables
    local iteration: SequenceTable<T> = {}
    local count: number = 0

    -- Add objects to iteration table
    for index, object: T in self._sequence do
        count += 1
        if ( count > stopAt ) then break end

        table.insert(iteration, index, object)

        if ( self._clearOnTick ) then
            table.remove(self._sequence, index)
        end
    end

    -- Run tick over iteration objects
    self:_tick(iteration)
end

function Sequence:ForceTick() : void
    if ( self._isTicking ) then return end

    if ( self._autotick ) then
        warn(":ForceTick<T>() | Shouldn't run whilst Autotick is enabled")
    end

    -- Run tick for sequenced objects
    self:_tick()
end

function Sequence:_tick<T>(iteration: SequenceTable<T>) : void
    if ( self._tickScheduled ) then return end

    -- Setup
    self._tickScheduled = true

    -- Set to release all objects in sequence
    task.defer(function()
        if not ( self._tickScheduled ) then return end

        if not ( iteration ) then
            iteration = self._sequence
        end

        -- Run callback function
        self._onTick(iteration)

        -- Cleanup
        self._tickScheduled = false

        if ( self._clearOnTick ) then
            self:Clean()
        end
    end)
end

function Sequence:_findNextIndex() : number
    return #self._sequence + 1
end

function Sequence:Clean() : boolean | nil
    if ( self._tickScheduled ) then return end
    table.clear(self._sequence)
    return true
end

function Sequence:Destroy() : void
    self._tickScheduled = false
    self:Clean()
    setmetatable(self, nil)
end

return Sequence