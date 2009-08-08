﻿--[[
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


--- Register a Main<->Alt relationship 
-- @param main Name of the main character
-- @param alt Name of the alt character 
function lib:SetAlt(main, alt)
	if (not main) or (not alt) then return end
	Mains = nil

	main = main:lower()
	alt = alt:lower()

	Alts[main] = Alts[main] or {}
	tinsert(Alts[main], alt)

	callbacks:Fire("LibAlts_SetAlt", main, alt)
end

--- Get a list of alts for a given character
-- @name :GetAlt 
-- @param main Name of the main character
-- @return  list list of alts 
function lib:GetAlts(main)
	if not main then return end

	main = main:lower()

	if not Alts[main] or #Alts[main] == 0 then
		return nil
	end

	return unpack(Alts[main])
end

--- Get main for a given alt character
-- @name :IsMain 
-- @param alt Name of the alt character
-- @return string the main character 
function lib:GetMain(alt)
	if not alt then return end

	alt = alt:lower()
	if not Mains then
		generateRevLookups()
	end

	return Mains[alt]
end

--- Test if a character is a main
-- @name :IsMain
-- @param main Name of the character
-- @return boolean is this a main character
function lib:IsMain(main)
	if not main then return end
	return Alts[main:lower()] and true or false
end


--- Test if a character is a alt
-- @name :IsAlt
-- @param alt Name of the character
-- @return boolean is this a alt character
function lib:IsAlt(alt)
	if not alt then return end
	
    if not Mains then
		generateRevLookups()
	end

	return Mains[alt:lower()] and true or false
end

