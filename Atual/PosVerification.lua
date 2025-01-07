setDefaultTab("Main")

cdzgoldstaminarec = function()
    if isInPz() and (posx() >= 857 and posx() <= 876) and (posy() >= 898 and posy() <= 912) and (posz() == 15) then
        return true
    end
end

isinAriesSavepoint = function()
    if isInPz() and (posx() >= 954 and posx() <= 956) and (posy() >= 2300 and posy() <= 2302) then
        return true
    else
        return false
    end
end


isinGreciaSavepoint = function()
  if isInPz() and (posx() >= 1047 and posx() <= 1049) and (posy() >= 1014 and posy() <= 1016) then
        return true
    else
        return false
    end
end

IsInGreeceTemple = function()
    if isInPz() and (posx() >= 1005 and posx() <= 1026) and (posy() >= 999 and posy() <= 1013) then
        return true
    end
end


isinaiolosstart = function()
    if (posx() >= 883 and posx() <= 902) and (posy() >= 1676 and posy() <= 1683) then
        return true
    end
end

isinGreciaCity = function()
    if (posx() >= 983 and posx() <= 1082) and (posy() >= 982 and posy() <= 1060) and (posz() >= 6 and posz() <= 7) then
        return true
    end
end

isInThermalspot = function()
    if isInPz() then
        if (posx() >= 717 and posx() <= 888) and (posy() >= 895 and posy() <= 942) and (posz() == 15) then
            return true
        end
    end
end

AiolosCaveFull = function()
    if (posx() >= 883 and posx() <= 1013) and (posy() <= 1699 and posy() >= 1616) then
        return true
    end
end


sagatrap = function()
    if (posx() >= 1288 and posx() <= 1343) and (posy() <= 1112 and posy() >= 1081) and posz() == 15 then
        return true
    end
end

AtlantisSorento1 = function()
    if (posx() >= 1616 and posx() <= 1667) and (posy() <= 3631 and posy() >= 3579) and (posz() == 6 or posz() == 5) then
        return true
    end
end

entradaLeao = function()
if (posx() >= 1434 and posx() <= 1529) and (posy() <= 715 and posy() >=632) then
return true
end
end

Captchazone = function()
if (posx() >= 1019 and posx() <= 1028) and (posy() <= 1004 and posy() >= 1000) and posz() == 5 then
return true
end
end

--info('Loaded Positions')