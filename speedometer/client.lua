-- Scripted by: zHoop :D

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

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


function speedometer()
	if getPedOccupiedVehicle(localPlayer) then
	local theVehicle = getPedOccupiedVehicle(localPlayer)
		local sWidth,sHeight = guiGetScreenSize() -- The variables
		local speed = getElementSpeed(theVehicle, 1)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", sWidth*0.76625 - 1, sHeight*0.84444444444444444444444444444444 - 1, sWidth*0.948125 - 1, sHeight*0.92333333333333333333333333333333 - 1, tocolor(0, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", sWidth*0.76625 + 1, sHeight*0.84444444444444444444444444444444 - 1, sWidth*0.948125 + 1, sHeight*0.92333333333333333333333333333333 - 1, tocolor(0, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", sWidth*0.76625 - 1, sHeight*0.84444444444444444444444444444444 + 1, sWidth*0.948125 - 1, sHeight*0.92333333333333333333333333333333 + 1, tocolor(0, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", sWidth*0.76625 + 1, sHeight*0.84444444444444444444444444444444 + 1, sWidth*0.948125 + 1, sHeight*0.92333333333333333333333333333333 + 1, tocolor(0, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", sWidth*0.76625, sHeight*0.84444444444444444444444444444444, sWidth*0.948125, sHeight*0.92333333333333333333333333333333, tocolor(255, 255, 255, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		--[[
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", 1226 - 1, 760 - 1, 1517 - 1, 831 - 1, tocolor(0, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", 1226 + 1, 760 - 1, 1517 + 1, 831 - 1, tocolor(0, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", 1226 - 1, 760 + 1, 1517 - 1, 831 + 1, tocolor(0, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", 1226 + 1, 760 + 1, 1517 + 1, 831 + 1, tocolor(0, 0, 0, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		dxDrawText("Speed: "..math.floor(tostring(speed), 0, "floor").." km/h", 1226, 760, 1517, 831, tocolor(255, 255, 255, 255), 3.00, "default", "left", "top", false, false, false, false, false)
		]]
	else
		return false
	end
end
addEventHandler("onClientRender", root, speedometer)