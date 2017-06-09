local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local aur = {}
local script = require("awful.util").getdir("config") .. "aur-widget/aur.py"

aur.widget = wibox.widget {
    {
        id = "indicator",
        widget = wibox.widget.textbox,
        align = "center"
    },
    widget = wibox.container.background,
    bg = "#A54242",
    fg = "#FFFFFF",
    forced_height = 15,
    forced_width = 15,
    shape = gears.shape.circle,
    buttons = gears.table.join(
        awful.button({}, 1, function() aur.status() end)
    ),
    set_text = function(self, text)
        if text ~= nil then
            self.indicator:set_text(text)
        end
    end
}

aur.popup = awful.tooltip({
    align = "bottom",
    objects = {aur.widget}
})

function aur.init(timeout)
    aur.widget:set_visible(false)
    if not timeout then return end
    aur.status()
    gears.timer {
        timeout = timeout,
        autostart = true,
        callback = aur.status
    }
end

function aur.status()
    local count = 0
    local updates
    local list

    awful.spawn.with_line_callback("python " .. script, {
        stdout = function(line)
            if count == 0 and tonumber(line) ~= nil then
                updates = line
                count = count + 1
            elseif count == 1 and line ~= nil then
                list = line
            end
        end,
        output_done = function()
            if count == 1 then
                if tonumber(updates) == 0 then
                    aur.widget:set_visible(false)
                elseif tonumber(updates) > 0 then
                    aur.widget:set_text(updates)
                    aur.widget:set_visible(true)
                    popup(updates, list)
                    aur.popup.text = list
                end
            end
        end
    })
end

function popup(update, list)
    naughty.notify{
        title = update .. " update(s) available",
        text = list,
        timeout = 5, hover_timeout = 0.5,
        position = "bottom_right",
        width = 300,
    }
end

return aur
