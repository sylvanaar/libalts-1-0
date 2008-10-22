--[[
Name: LibAlts-1.0
Revision: 5
Author: Sylvanaar (sylvanaar@mindspring.com)
Description: Shared handling of alt identity between addons.
Dependencies: LibStub
License: 
]]

local MAJOR, MINOR = "LibAlts-1.0", "5"
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

local _G = getfenv(0)

local Alts = {}
local Mains = nil -- reverse lookup table
local tinsert = _G.tinsert
local unpack = _G.unpack

local callbacks = LibStub("CallbackHandler-1.0"):New(lib)

local function generateRevLookups()
	Mains = {}
	for k,v in pairs(Alts) do
		for i,a in ipairs(v) do
			Mains[a] = k
		end
	end
end

function lib:SetAlt(main, alt)
	Mains = nil

	main = main:lower()
	alt = alt:lower()

	Alts[main] = Alts[main] or {}
	tinsert(Alts[main], alt)

	callbacks:Fire("LibAlts_SetAlt", main, alt)
end

function lib:GetAlts(main)
	main = main:lower()

	if not Alts[main] or #Alts[main] == 0 then
		return nil
	end

	return unpack(Alts[main])
end

function lib:GetMain(alt)
	alt = alt:lower()
	if not Mains then
		generateRevLookups()
	end

	return Mains[alt]
end

function lib:IsMain(main)
	return Alts[main:lower()] and true or false
end

function lib:IsAlt(alt)
	if not Mains then
		generateRevLookups()
	end

	return Mains[alt:lower()] and true or false
end

