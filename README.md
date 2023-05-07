# Sequence
![GitHub all releases](https://img.shields.io/github/downloads/EnDarke/Sequence/total)
![GitHub contributors](https://img.shields.io/github/contributors/EnDarke/Sequence)
![GitHub last commit](https://img.shields.io/github/last-commit/EnDarke/Sequence)

## About
### Description
 Sequence allows you to sort tasks in sequential order to run. These tasks are run either on the next resumption cycle, or on-command!

 ### Potential Uses
 - Turn-base game to determine when a player will go.
 - Setting up a network package handler.
 - Sending out notifications to players.

## Installation


## Examples
![Carbon_Sequence](https://user-images.githubusercontent.com/60949506/236703749-10d5fdff-3ef2-423e-bdfa-8a9a27f58bed.png)
```
Output:
    It is now foobar's turn!
```
![Carbon_Sequence_2](https://user-images.githubusercontent.com/60949506/236704355-2fa7ea60-1b32-4cda-92c6-734282dfd4b9.png)
```
Output:
    It is now foobar_1's turn!
    It is now foobar_1's turn!
    It is now foobar_2's turn!
```

![Carbon_Sequence_3](https://user-images.githubusercontent.com/60949506/236704611-50de53ef-69d5-42a9-b8fd-75460ba2524e.png)
```
Output:
    It is now foobar_1's turn!
    It is now foobar_3's turn!
    It is now foobar_4's turn!
```

## Functions
### new
```
Sequence.new<T>(callback: ({T}) -> nil) -> Sequence<T>
```
Creates a new Sequence object.

---
### Includes
```
Sequence:Includes(object: T) -> SequenceTable<T>
```
Adds an object to the Sequence table.

---
### Excludes
```
Sequence:Excludes(index: number) -> T
```
Removes an object from the Sequence table at given index.

---
### ExcludeFromObject
```
Sequence:ExcludeFromObject(object: T) -> number
```
Removes an object from the Sequence table from given object.

---
### Get
```
Sequence:Get(index: number) -> T
```
Gets the object at given index or first.

---
### Set
```
Sequence:Set(object: T, index: number) -> SequenceTable<T>
```
Sets the object at given index or first.

---
### ForceTick
```
Sequence:ForceTick() -> nil
```
Forcefully runs the tick cycle to flush all current Sequence tasks.

---
### Iterate
```
Sequence:Iterate(stopAt: number) -> nil
```
Like `:ForceTick()`, but only iterates over objects up to given index. Will run based on count of objects rather than count of index.

---
### GetCurrentSequence
```
Sequence:GetCurrentSequence() -> SequenceTable<T>
```
Gets the current Sequence table.

---
### SetCurrentLimit
```
Sequence:SetCurrentLimit(amount: number) -> nil
```
Sets the sequence limit to amount given (nil for limit removal).

---
### Clean
```
Sequence:Clean() -> nil
```
Cleans up the Sequence table for a fresh start.

---
### Destroy
```
Sequence:Destroy() -> nil
```
Used to clean and completely remove the Sequence object permanently.
