--!strict

--[[
    Author(s):
        Alex/EnDarke
    Date:
        05/06/23
    Description:
        Used to load up tasks and run them on next defer, or when forcefully flushed.
]]

--[=[
    @class Sequence
    @__index sequence

    The Sequence Module is an advanced task management system that enables users to meticulously arrange tasks in a sequential order for execution. The execution of these tasks can be configured to occur either in the Roblox engine resumption cycle or upon the issuance of the `:ForceTick()` command.

    This module is characterized by its versatility, making it applicable across various domains. For instance, here are some examples where this module may be applicable!
    - **Turn-Based Games:** Calculate and dictate the order of play, ensuring a structured and engaging gaming experience.
    - **Network Packet Handling:** Develop an efficient network packet handler to maintain the reliability and performance of data communications.
    - **Notification Management:** Devise an organized system for the dissemination of notifications, enhancing communication and user involvement.

]=]

--[=[
    Commonly used term for a function that has no return value

    @type void nil
    @within Sequence
]=]
--[=[
    Used to hold all given objects

    @type SequenceTable<T> { T }
    @within Sequence
]=]
--[=[
    Object in which you run the `Sequence` code with

    @type Sequence<T> metatable
    @within Sequence
]=]

-- Declaring Custom Types
type void = nil
type callback = () -> void
type SequenceSettings = { Autotick: boolean, ClearOnTick: boolean, Limit: number }
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

-- Declaring Constants
local DEFAULT_AUTOTICK = true
local DEFAULT_CLEARONTICK = true
local DEFAULT_LIMIT = nil

--[=[
    @within Sequence
    @prop Autotick boolean
    @tag true by default
    When enabled, it will automatically run a `tick cycle` on next resumption cycle
]=]
--[=[
    @within Sequence
    @prop ClearOnTick boolean
    @tag true by default
    When enabled, `SequenceTable<T>` is cleared after the `tick cycle` has completed
]=]
--[=[
    @within Sequence
    @prop Limit number
    @tag nil by default
    When set to a number, SequenceTable<T> won't allow any more objects than limit amount. If you `:Include()` an object that pushes `SequenceTable<T>` over the limit, it will remove any objects over said limit
]=]

-- Module Code
local Sequence = {}
Sequence.__index = Sequence

--[=[
    @tag Sequence
    @param settings {}
    @param callback function

    Creates a new Sequence object

    ```lua
    local MySequence.new({ Autotick = true, ClearOnTick = true, Limit = 10 }, function(sequenceTable)
        for _, object in sequenceTable do
            print("Object " .. object .. " is in the sequence!")
        end
    end)
    ```
]=]

function Sequence.new<T>(settings: {}, callback: callback) : Sequence<T>
    if not ( callback ) then
        error(".new() | Sequence needs a callback function")
    end

    local self: Sequence<T> = setmetatable({}, Sequence)

    -- Settings
    self.Autotick = if ( typeof(settings.Autotick) == "boolean" ) then settings.Autotick else DEFAULT_AUTOTICK
    self.ClearOnTick = if ( typeof(settings.ClearOnTick) == "boolean" ) then settings.ClearOnTick else DEFAULT_CLEARONTICK
    self.Limit = if ( typeof(settings.Limit) == "number" ) then settings.Limit else DEFAULT_LIMIT

    -- Properties
    self._sequence = {} :: Sequence<T>
    self._onTick = callback :: callback
    self._isTicking = false
    self._tickScheduled = false

    self._defer = nil :: thread

    return self
end

--[=[
    Adds an object to the Sequence to be run on Sequence:ForceTick()

    @param object T
    @param index number -- Places at end if nil

    ```lua
    local MySequence.new({ Autotick = true }, function(sequenceTable) end)

    local currentSequence = MySequence:Includes("Hey there!")
    print(newSequence)
    ```
    ```
    <Output>
    { "Hey there!" }
    ```
]=]

function Sequence:Includes<T>(object: T, index: number) : SequenceTable<T>
    if not ( index ) then
        index = self:_findNextIndex()
    end

    table.insert(self._sequence, index, object)

    -- Sequence ceiling limiter
    if ( self.Limit and (#self._sequence > self.Limit) ) then
        self:Excludes(#self._sequence)
    end

    -- Check if on autotick/run tick sequence
    if ( self.Autotick ) then
        self:_tick()
    end

    return self._sequence
end

--[=[
    Bulk adds objects to the Sequence from an array to be run on Sequence:ForceTick()

    @param array { T }
    @param index number -- Places at the end of the sequence if nil

    ```lua
    local MySequence = Sequence.new({ Autotick = true }, function(sequenceTable)
        print(sequenceTable)
    end)

    local myTable = {"I've been good!", "What about you?"}
    MySequence:Includes("Hey there!")
    MySequence:Includes("Nice to meet you!")
    MySequence:IncludeArray(myTable, 2)
    ```
    ```
    <Output>
    { "Hey there!", "I've been good!", "What about you?", "Nice to meet you!" }
    ```
]=]

function Sequence:IncludeArray<T>(array: { T }, index: number)
    if ( typeof(array) ~= "table" ) then
        error(":IncludeArray<T>() | Must input an array!")
    end

    if not ( index ) then
        index = if ( #self._sequence < 1 ) then 0 else self:_findNextIndex()
    else
        index -= 1
    end

    for ind, obj in ipairs( array ) do
        self:Includes(obj, index + ind)
    end
end

--[=[
    Removes an object from the Sequence at given index

    @param index number

    ```lua
    local MySequence.new({ Autotick = true }, function(sequenceTable) end)

    MySequence:Includes("Hey there!")
    local removedObject = MySequence:Excludes(1)
    print(removedObject)
    ```
    ```
    <Output>
    Hey there!
    ```
]=]

function Sequence:Excludes<T>(index: number) : T
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

--[=[
    Removes an object from the Sequence at given index

    @param object T

    ```lua
    local MySequence.new({ Autotick = true }, function(sequenceTable) end)

    MySequence:Includes("Hey there!")
    print(MySequence:GetCurrentSequence())

    MySequence:ExcludeFromObject("Hey there!")
    print(MySequence:GetCurrentSequence())
    ```
    ```
    <Output>
    { "Hey there!" }
    {}
    ```
]=]

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

--[=[
    Used to find the object at index

    @param index number

    ```lua
    local MySequence.new({ Autotick = true }, function(sequenceTable) end)

    MySequence:Includes("Hey there!")

    local foundObject = MySequence:Get(1)
    print(foundObject)
    ```
    ```
    <Output>
    Hey there!
    ```
]=]

function Sequence:Get<T>(index: number) : T
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

--[=[
    Adds object to sequence, but replaces any current value at given index

    @param object T
    @param index number -- Sets object at index 1 if nil

    ```lua
    local MySequence.new({ Autotick = true }, function(sequenceTable)
        print(sequenceTable)
    end)

    MySequence:Includes("Hey there!")

    local currentSequence = MySequence:Set("Nice to meet you!", 1)
    ```
    ```
    <Output>
    { "Nice to meet you!" }
    ```
]=]

function Sequence:Set<T>(object: T, index: number) : SequenceTable<T>
    if not ( object ) then
        error(":Set<T>() | Object is missing")
    end

    if not ( index ) then
        index = 1
    end

    if ( self.Limit and (index > self.Limit) ) then
        warn(":Set<T>() | Cannot set object higher than limit")
    end

    self._sequence[index] = object

    return self._sequence
end

--[=[
    Returns current status of the `SequenceTable<T>`

    ```lua
    local MySequence.new({ Autotick = false }, function(sequenceTable) end)

    MySequence:Set("Hey there!")

    local currentSequence = MySequence:GetCurrentSequence()
    print(currentSequence)
    ```
    ```
    <Output>
    { "Hey there!" }
    ```
]=]

function Sequence:GetCurrentSequence<T>() : SequenceTable<T>
    return self._sequence
end

--[=[
    Changes the limit of objects that the `SequenceTable<T>` can hold

    @param amount number

    ```lua
    local MySequence.new({ Autotick = true, Limit = 1 }, function(sequenceTable)
        print(sequenceTable)
    end)

    MySequence:Includes("Hey there!")
    MySequence:Includes("Nice to meet you!", 1)

    MySequence:SetCurrentLimit(3)

    MySequence:Includes("I've been good!", 1)
    MySequence:Includes("What about you?")
    MySequence:Includes("Nothing much!", 2)

    -- Remember that :Includes() always places the object at the end.
    -- But inputting a number pushes all that are ahead of it, up!
    ```
    ```
    <Output>
    { "I've been good!", "Nothing much!", "Nice to meet you!" }
    ```
]=]

function Sequence:SetCurrentLimit(amount: number) : void
    self.Limit = amount
end

--[=[
    Runs a `tick cycle` over objects from first till `stopAt`

    @param stopAt number

    ```lua
    local MySequence.new({ Autotick = false }, function(sequenceTable)
        print(sequenceTable)
    end)

    MySequence:Includes("Hey there!")
    MySequence:Includes("Nice to meet you!")
    MySequence:Includes("I've been good!")
    MySequence:Includes("What about you?")
    MySequence:Includes("Nothing much!")

    MySequence:Iterate(4)
    ```
    ```
    <Output>
    { "Hey there!", "Nice to meet you!", "I've been good!", "What about you?" }
    ```
]=]

function Sequence:Iterate<T>(stopAt: number) : void
    if not ( stopAt ) then
        error(":Iterate<T>() | Cannot iterate without inputting a number to stop at")
    end

    if ( self.Autotick ) then
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

        if ( self.ClearOnTick ) then
            table.remove(self._sequence, index)
        end
    end

    -- Run tick over iteration objects
    self:_tick(iteration)
end

--[=[
    Forcefully runs a `tick cycle` through every sequence object

    ```lua
    local MySequence.new({ Autotick = false }, function(sequenceTable)
        print(sequenceTable)
    end)

    MySequence:Includes("Hey there!")
    MySequence:Includes("Nice to meet you!")

    task.wait(10)

    MySequence:Includes("I've been good!")

    MySequence:ForceTick()
    ```
    ```
    <Output>
    { "Hey there!", "Nice to meet you!", "I've been good!" }
    ```
]=]

function Sequence:ForceTick() : void
    if ( self._isTicking ) then return end

    if ( self.Autotick ) then
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

        if ( self.ClearOnTick ) then
            self:Clean()
        end
    end)
end

function Sequence:_findNextIndex() : number
    return #self._sequence + 1
end

--[=[
    Cleans up Sequence object and empties the `SequenceTable<T>`

    ```lua
    local MySequence = Sequence.new({ Autotick = false }, function(sequenceTable) end)

    MySequence:Includes("Hey there!")
    print(MySequence:GetCurrentSequence())

    MySequence:Clean()

    print(MySequence:GetCurrentSequence())
    ```
    ```
    <Output>
    { "Hey there!" }
    {}
    ```
]=]

function Sequence:Clean() : boolean
    if ( self._tickScheduled ) then return end
    table.clear(self._sequence)
    return true
end

--[=[
    Destroys `Sequence` object permanently to never be restored
]=]

function Sequence:Destroy() : void
    self._tickScheduled = false
    self:Clean()
    setmetatable(self, nil)
end

return Sequence