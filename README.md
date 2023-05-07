# Sequence
![GitHub all releases](https://img.shields.io/github/downloads/EnDarke/Sequence/total)
![GitHub contributors](https://img.shields.io/github/contributors/EnDarke/Sequence)
![GitHub last commit](https://img.shields.io/github/last-commit/EnDarke/Sequence)

## About
### Description
 Sequence allows you to sort tasks in sequential order to run. These tasks are run either on the next resumption cycle, or on-command!

 You have 3 settings you can set:
    *Autotick:*
        Default: true
        Will run a tick cycle upon adding objects to the queue
    *ClearOnTick:*
        Default: true
        Will clear sequence after tick cycle has been completed
    *Limit:*
        Default: nil
        Limits the amount of objects that can be in the sequence

 ### Potential Uses
 - Turn-base game to determine when a player will go.
 - Setting up a network package handler.
 - Sending out notifications to players.

## Installation


## Examples

#### In this example, you can see that I have Autotick enabled. This way, it'll automatically tick on the next cycle.

![Carbon_Sequence](https://user-images.githubusercontent.com/60949506/236703749-10d5fdff-3ef2-423e-bdfa-8a9a27f58bed.png)
```
Output:
    It is now foobar's turn!
```

#### In this example, you can see that I have Autotick disabled, as well as ClearOnTick. ClearOnTick set to false will ensure that when hitting the tick cycle, previous object within the sequence don't get removed.

![Carbon_Sequence_2](https://user-images.githubusercontent.com/60949506/236704355-2fa7ea60-1b32-4cda-92c6-734282dfd4b9.png)
```
Output:
    It is now foobar_1's turn!
    It is now foobar_1's turn!
    It is now foobar_2's turn!
```

#### In this example, you can see that I have set a limit. This limit will keep the sequence from going over than said limit.

![Carbon_Sequence_4](https://user-images.githubusercontent.com/60949506/236704902-5b23035f-fb58-4ddc-9697-a258085d6f28.png)
```
Output:
    It is now foobar_1's turn!
    It is now foobar_2's turn!
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
