setDefaultTab("Main")

AldebaSpot = function()
    if (posx() >= 665 and posx() <= 678) and (posy() >= 1492 and posy() <= 1504) and (posz() == 9) then
        return true
    end
end

ushiospot = function()
    if (posx() >= 955 and posx() <= 965) and (posy() >= 1161 and posy() <= 1169) then
        return true
    else
        return false
    end
end


aiolotspot = function()
  if (posx() >= 2017 and posx() <= 2026) and (posy() >= 1238 and posy() <= 1245 and (posz() == 3)) then
        return true
end

mdmspot = function()
    if (posx() >= 1206 and posx() <= 1220) and (posy() >= 760 and posy() <= 772 and (posz() == 6)) then
        return true
    end
end


daichispot = function()
    if (posx() >= 1078 and posx() <= 1085) and (posy() >= 1102 and posy() <= 1107 and (posz() == 6)) then
        return true
    end
end

banspot = function()
    if (posx() >= 839 and posx() <= 852) and (posy() >= 999 and posy() <= 1015 and (posz() == 6)) then
        return true
    end
end

ikkispot = function()
    if isInPz() then
        if (posx() >= 839 and posx() <= 852) and (posy() >= 999 and posy() <= 1015 and (posz() == 6)) then
            return true
        end
    end
end

seiyaspot = function()
    if (posx() >= 976 and posx() <= 986) and (posy() >= 805 and posy() <= 812 and (posz() == 6)) then
        return true
    end
end


shospot = function()
    if (posx() >= 1117 and posx() <= 1129) and (posy() >= 948 and posy() <= 960 and (posz() == 6)) then
        return true
    end
end

cassiusspot = function()
    if (posx() >= 952 and posx() <= 964) and (posy() >= 1105 and posy() <= 1112 and (posz() == 7)) then
        return true
    end
end

hyogaspot = function()
    if (posx() >= 1453 and posx() <= 1489) and (posy() >= 1078 and posy() <= 1094 and (posz() == 6)) then
        return true
    end
end