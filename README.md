# PeaversGetThereData

[![AddonSentry](https://addonsentry.io/api/public/repos/peavers-warcraft/PeaversGetThereData/badge.svg)](https://addonsentry.io/dashboard/peavers-warcraft/PeaversGetThereData)

A data library addon for World of Warcraft that provides the static travel data behind [PeaversGetThere](https://github.com/peavers-warcraft/PeaversGetThere): the portal/boat/zeppelin/tram travel graph, the teleport catalog, flight points, dungeon entrances, and extra searchable names.

## Features

<!-- peavers:features -->
- Travel graph of portals, boats, zeppelins and trams (nodes + typed, costed edges) for cross-continent routing
- Teleport catalog covering hearthstones and toy variants, class teleports, engineering wormholes and M+ dungeon teleports
- Flight-point and dungeon-entrance databases generated from wago.tools db2 exports (fills the "only discovered" gaps in the client APIs)
- Search-extras blob with names and aliases the client cannot enumerate (auction houses, portal rooms, barbers, ...)
- Clean public API consumed by PeaversGetThere and available to any addon
- No configuration, no saved variables — pure data provider
<!-- /peavers:features -->

<!-- peavers:custom -->
## API

The addon exposes a global `PeaversGetThereData.API`:

```lua
local API = PeaversGetThereData.API

-- Plain accessors: shared, read-only tables of shape { updated = "...", <payload> }
local nodes = API.GetTravelNodes()          -- .nodes[nodeID] = { kind, map, x, y, name, faction, req }
local edges = API.GetTravelEdges()          -- .edges[i] = { from, to, method, cost, req }
local teleports = API.GetTeleports()        -- .teleports[i] = { id, type, dest, ... }
local taxi = API.GetTaxiNodes()             -- .nodes[taxiNodeID] = { map, x, y, name, faction, edges }
local entrances = API.GetDungeonEntrances() -- .entrances[journalInstanceID] = { map, x, y, name, kind, faction }

-- Ownership transfer: search-extras chunks are handed over once so the caller
-- can free them after concatenating. Returns nil on subsequent calls.
local extras = API.TakeSearchExtras()       -- { payloads = {...}, chunks = {...} }
```
<!-- /peavers:custom -->


## Installation

This is a data library used by other Peavers addons and doesn't require direct user interaction. [PeaversUpdater](https://github.com/peavers-warcraft/PeaversUpdater/releases/latest) installs and updates it automatically alongside its parent addon, or download it directly from [CurseForge](https://www.curseforge.com/wow/addons/peaversgettheredata).

---

*Part of the [Peavers](https://peavers.io) addon collection · [Report an issue](https://github.com/peavers-warcraft/PeaversGetThereData/issues) · [Support development on Patreon](https://www.patreon.com/Peavers)*
