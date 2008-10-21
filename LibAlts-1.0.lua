--[[
Name: LibAlts-1.0
Revision: 2
Author: Sylvanaar (sylvanaar@mindspring.com)
Description: Shared handling of alt identity between addons.
Dependencies: LibStub
License: 
]]

local MAJOR, MINOR = "LibAlts-1.0", "2"
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

local _G = getfenv(0)

local Alts = {}
local Mains = nil -- reverse lookup table
local tinsert = _G.tinsert
local unpack = _G.unpack

local function generateRevLookups()
	Mains = {}
	for k,v in pairs(Alts) do
		for i,a in ipairs(v) do
			Mains[a] = k
		end
	end
end

function lib:Register(main, alt)
	Mains = nil
	Alts[main] = Alts[main] or {}
	tinsert(Alts[main], alt)
end

function lib:GetAlts(main)
	if not Alts[main] or #Alts[main] == 0 then
		return nil
	end

	return unpack(Alts[main])
end

function lib:GetMain(alt)
	if not Mains then
		generateRevLookups()
	end

	return Mains[alt]
end

function lib:IsMain(main)
	return Alts[main] and true or false
end

function lib:IsAlt(alt)
	if not Mains then
		generateRevLookups()
	end

	return Mains[alt] and true or false
end

