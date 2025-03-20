local _G = modules._G;

local client_entergame = modules.client_entergame;
local executeAutoReconnect = client_entergame.executeAutoReconnect;

if (_G.original_schedule == nil) then
    _G.original_schedule = _G.scheduleEvent;
end

_G.scheduleEvent = function(func, time)
    if (func == executeAutoReconnect) then
        time = math.random(5000, 10000);
    end
    return _G.original_schedule(func, time);
end