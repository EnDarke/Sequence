---
sidebar_position: 1
---

# Getting Started

I thankfully can say installing this package is actually quite easy regardless of your method of choice!

## Wally Dependencies (Recommended)
Wally is a quick way to get the packages you need! Wally is a package manager for Roblox created by, Uplift Games. This allows us to pull whatever package within the database at any time!

You can install Wally [here](https://wally.run/)

#### What now?
You can now get to configuring your Wally files! Once you make sure Wally is installed on your computer. Run `wally init` in your terminal whilst within your project directory. Open up  the file `wally.toml` to see the configuration settings for Wally. Then, under dependencies add the code `Sequence = "endarke/sequence@*"`.
Once you've added the package to your dependencies. You're gonna want to run `wally install` in your terminal.

`wally.toml` should look something like this:
```
[package]
name = "your_name_here/repository_name"
version = "0.1.0"
registry = "https://github.com/UpliftGames/wally-index"
realm = "shared"

[dependencies]
Sequence = "endarke/sequence@*"
```

## Source
If you don't have Wally or aren't too interested in using Wally, fear not! You are *also* able to download the latest version directly from the Sequence Repository [here](https://github.com/EnDarke/Sequence/releases)!