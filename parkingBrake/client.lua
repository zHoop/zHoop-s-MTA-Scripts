-- Scripted by zHoop

local hasParkingBrake = false
local tooFastForBrake = false
local d = 0

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function parkingBrake()
	if isPlayerInVehicle(localPlayer) == true then
		if ( hasParkingBrake ~= true ) then
			local theVehicle = getPedOccupiedVehicle(localPlayer)
				if theVehicle then
				setElementFrozen(theVehicle, false)
				else
					return false
				end
			return false
		elseif ( hasParkingBrake ~= false ) then
			local text = "Parking Brake : ON"
			local iText = tostring(text)
			dxDrawText(iText, 1226 - 1, 810 - 1, 1474 - 1, 856 - 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
				dxDrawText(iText, 1226 + 1, 810 - 1, 1474 + 1, 856 - 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
					dxDrawText(iText, 1226 - 1, 810 + 1, 1474 - 1, 856 + 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
				dxDrawText(iText, 1226 + 1, 810 + 1, 1474 + 1, 856 + 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
			dxDrawText(iText, 1226, 810, 1474, 856, tocolor(255, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
			local theVehicle = getPedOccupiedVehicle(localPlayer)
			setElementFrozen(theVehicle, true)
		end
	else
		return false 
	end
end
addEventHandler("onClientPreRender", root, parkingBrake)

function i()
	hasParkingBrake = false
	toggleControl ( "accelerate", true )
	tooFastForBrake = false
end

function x()
	if tooFastForBrake == true then
	local text = "Cannot Operate\nParking Brake"
	local iText = tostring(text)
	if d == 120 then
		tooFastForBrake = false
		d = 0
		return false
	else
		d = d + 1
	dxDrawText(iText, 1226 - 1, 810 - 1, 1474 - 1, 856 - 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
		dxDrawText(iText, 1226 + 1, 810 - 1, 1474 + 1, 856 - 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
			dxDrawText(iText, 1226 - 1, 810 + 1, 1474 - 1, 856 + 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
		dxDrawText(iText, 1226 + 1, 810 + 1, 1474 + 1, 856 + 1, tocolor(0, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
	dxDrawText(iText, 1226, 810, 1474, 856, tocolor(255, 0, 0, 255), 2.00, "default", "left", "top", false, false, false, true, false)
	end
	else
		return false
	end
end
addEventHandler("onClientPreRender", root, x)

function toggleParkingBrake()
	if ( hasParkingBrake ~= true ) then
		local theVehicle = getPedOccupiedVehicle(localPlayer)
		local vehSpeed =  getElementSpeed(theVehicle, 1) 
		if (vehSpeed > 20) then
			tooFastForBrake = true
			parkingBrake()
		else
			tooFastForBrake = false
			hasParkingBrake = true
			toggleControl ( "accelerate", false )
		end
	elseif ( hasParkingBrake ~= false ) then
		tooFastForBrake = false
		setTimer(i, 700, 1)
	end
end
bindKey("space", "down", toggleParkingBrake)