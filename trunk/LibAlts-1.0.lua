--[[
Name: LibAlts-1.0
Revision: 1
Author: Sylvanaar (sylvanaar@mindspring.com)
Description: Shared handling of alt identity between addons.
Dependencies: LibStub
License: 
]]

local MAJOR, MINOR = "LibAlts-1.0", "1"
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

local _G = getfenv(0)

function lib:Register(main, alt)
end

function lib:GetAlts(main)
end

function lib:GetMain(alt)
end

function lib:IsMain(main)
end

function lib:IsAlt(alt)
end

