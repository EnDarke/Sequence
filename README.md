# Sequence
### Description
 Sequence allows you to sort tasks in sequential order to run. These tasks are run either on the next resumption cycle, or on-command!

 ### Potential Uses
 - Turn-base game to determine when a player will go.
 - Setting up a network package handler.
 - Sending out notifications to players.

 ## Functions
 ### new
```
Sequence.new<T>(callback: ({T}) -> void) -> Sequence<T>
```
Creates a new Sequence object.
-----
### Includes
```
Sequence:Includes(object: T) -> SequenceTable<T>
```
Adds an object to the Sequence table.
-----
### Excludes
`Sequence:Excludes(index: number) -> T`
Removes an object from the Sequence table at given index.
---
### ExcludeFromObject
```
Sequence:ExcludeFromObject(object: T) -> number
```
Removes an object from the Sequence table from given object.
---
### Get
`Sequence:Get(index: number) -> T`
Gets the object at given index or first.
---
### Set
`Sequence:Set(object: T, index: number) -> SequenceTable<T>`
Sets the object at given index or first.
---
### ForceTick
`Sequence:ForceTick() -> void`
Forcefully runs the tick cycle to flush all current Sequence tasks.
---
### Iterate
`Sequence:Iterate(stopAt: number) -> void`
Like `:ForceTick()`, but only iterates over objects up to given index. Will run based on count of objects rather than count of index.
---
### GetCurrentSequence
`Sequence:GetCurrentSequence() -> SequenceTable<T>`
Gets the current Sequence table.
---
### SetCurrentLimit
`Sequence:SetCurrentLimit(amount: number) -> void`
Sets the sequence limit to amount given (nil for limit removal).
---
### Clean
`Sequence:Clean() -> void`
Cleans up the Sequence table for a fresh start.
---
### Destroy
`Sequence:Destroy() -> void`
Used to clean and completely remove the Sequence object permanently.