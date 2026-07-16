local _, addonTable = ...

-- Create the global addon table
_G["PeaversGetThereData"] = _G["PeaversGetThereData"] or {}
local publicAPI = _G["PeaversGetThereData"]

-- Create the API namespace
publicAPI.API = publicAPI.API or {}
local API = publicAPI.API

---Returns the travel-graph node database (see src\Data\TravelNodes.lua).
---Shape: { updated = "YYYY-MM-DD HH:MM:SS", nodes = { [nodeID] = {...}, ... } }.
---The table is shared, not copied - treat it as read-only.
---@return table data
function API.GetTravelNodes()
	return addonTable.TravelNodes
end

---Returns the travel-graph edge database (see src\Data\TravelEdges.lua).
---Shape: { updated = "...", edges = { { from, to, method, cost, req }, ... } }.
---The table is shared, not copied - treat it as read-only.
---@return table data
function API.GetTravelEdges()
	return addonTable.TravelEdges
end

---Returns the teleport catalog (see src\Data\Teleports.lua).
---Shape: { updated = "...", teleports = { { id, type, dest, ... }, ... } }.
---`dest` uses two namespaces: a TravelNodes key (e.g. "hub:stormwind",
---"region:northrend"), or "dungeon:<journalInstanceID>" which resolves against
---GetDungeonEntrances().entrances[journalInstanceID] - currently empty pending
---the scraper, so consumers must handle unresolvable dungeon dests gracefully
---(skip the entry, don't error). Entries with no `dest` carry `hearthstone` or
---`menu` instead. The table is shared, not copied - treat it as read-only.
---@return table data
function API.GetTeleports()
	return addonTable.Teleports
end

---Returns the flight-point database (see src\Data\TaxiNodes.lua).
---Shape: { updated = "...", nodes = { [taxiNodeID] = {...}, ... } }.
---The table is shared, not copied - treat it as read-only.
---@return table data
function API.GetTaxiNodes()
	return addonTable.TaxiNodes
end

---Returns the dungeon/raid entrance database (see src\Data\DungeonEntrances.lua).
---Shape: { updated = "...", entrances = { [journalInstanceID] = {...}, ... } }.
---The table is shared, not copied - treat it as read-only.
---@return table data
function API.GetDungeonEntrances()
	return addonTable.DungeonEntrances
end

---Returns the search-extras blob and releases this addon's reference to it.
---Shape: { updated = "...", payloads = { [i] = {...} }, chunks = { ... } } where
---each chunk holds "payloadIndex:Display Name<TAB>search tags" lines (see
---src\Data\SearchExtras.lua). Handing over ownership lets the caller free the
---chunks after concatenating, so the data is never held in memory twice.
---Subsequent calls return nil.
---@return table|nil data Search-extras table, or nil if already taken
function API.TakeSearchExtras()
	local data = addonTable.SearchExtrasData
	addonTable.SearchExtrasData = nil
	return data
end
