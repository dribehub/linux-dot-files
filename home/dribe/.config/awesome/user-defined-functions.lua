local awful = require("awful")

function run(command)
    return function() 
        awful.util.spawn(command) 
    end
end

function info(desc, gr)
    return { ["description"] = desc, ["group"] = gr }
end

function shell(command)
    awful.spawn.with_shell(command)
end

function async(command, func)
    awful.spawn.easy_async_with_shell(command, func)
end

function brightness(increment)
    local get_level = "xrandr --verbose | grep Brightness | awk '{printf $NF}'"
    return function()
        awful.spawn.easy_async_with_shell(get_level,
            function(actual_brightness)
                actual_brightness = tonumber(actual_brightness)
                local command = "xrandr --output eDP-1 --brightness "
                if (actual_brightness > 1) then
                    shell(command .. 1);
                elseif (actual_brightness == 1 and increment > 0) then
                    return
                else
                    shell(command .. (actual_brightness + increment))
                end
            end)
    end
end