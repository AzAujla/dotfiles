-- Constants
local mod = "SUPER"
local terminal = "kitty"
local filemanager = "thunar"
local menu = "rofi -show drun -theme ~/.config/rofi/launchers/type-2/style-6.rasi || pkill rofi"
local clipboard =
	"sh -c 'pkill rofi || cliphist list | rofi -dmenu -display-columns 2 -theme ~/.config/rofi/launchers/type-1/style-4.rasi | cliphist decode | wl-copy'"
local calculator = "rofi -show calc -modi calc -theme ~/.config/rofi/launchers/type-1/style-3.rasi || pkill rofi"
local emojiboard = 'rofimoji --selector-args="-theme ~/.config/rofi/launchers/type-5/style-5.rasi" --skin-tone neutral'
local MAX_ZOOM = 3
local MIN_ZOOM = 1

local monitor = {
	output = "eDP-1",
	mode = "preferred",
	position = "0x0",
	scale = 1,
}

-- Monitor
hl.monitor(monitor)
hl.bind("ALT + Tab", hl.dsp.focus({ workspace = "previous_per_monitor" }))

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("~/.config/hypr/wallpaper.sh")
	hl.exec_cmd("waybar & swaync")
	hl.exec_cmd("thunar --daemon")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	hl.exec_cmd("firefox", { workspace = "2 silent" })
	hl.exec_cmd(terminal, { workspace = "1 silent" })
end)

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 5,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(a4133cff)", "rgba(1a1a1aff)" }, angle = 45 },
			inactive_border = { colors = { "rgba(313244ff)" } },
		},
	},

	master = {
		mfact = 0.75,
	},
	scrolling = {},

	decoration = {
		rounding = 5,
		inactive_opacity = 0.7,
		dim_inactive = true,

		blur = {
			enabled = true,
			size = 2,
			passes = 1,
			new_optimizations = true,
			special = true,
			popups = false,
		},
	},

	input = {
		numlock_by_default = true,
		kb_layout = "us",
		kb_options = "compose:ralt",
		scroll_method = "on_button_click",
		scroll_button = 0,

		touchpad = {
			natural_scroll = true,
		},
	},

	misc = {
		enable_swallow = true,
		swallow_regex = "^(foot|kitty|alacritty)$",
	},

	cursor = {
		hide_on_key_press = true,
		persistent_warps = true,
		zoom_factor = 1,
		zoom_detached_camera = false,
		zoom_disable_aa = true,
	},

	animations = {
		enabled = true,
	},

	ecosystem = {
		enforce_permissions = true,
	},
})

hl.curve("overshoot", { type = "bezier", points = { { 0.5, 0.95 }, { 0.1, 1.05 } } })
hl.curve("rubber", { type = "spring", mass = 1, stiffness = 70, dampening = 10 })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "overshoot" })
hl.animation({ leaf = "windows", enabled = true, speed = 10, spring = "rubber", style = "slide" })
hl.animation({ leaf = "fade", enabled = 0 })

hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(filemanager))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mod .. " + Period", hl.dsp.exec_cmd(emojiboard))
hl.bind(mod .. " + M", hl.dsp.exec_cmd("~/.config/rofi/powermenu/type-2/powermenu.sh"))

hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill waybar && waybar"))
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("~/.config/hyprlock/scripts/hyprlock.sh"))

hl.bind(
	mod .. " + D",
	hl.dsp.exec_cmd("sh -c 'pkill -x wallpaper.sh; nohup ~/.config/hypr/wallpaper.sh >/dev/null 2>&1 &'")
)
hl.bind(
	mod .. " + I",
	hl.dsp.exec_cmd("rofi -modi nerdy -show nerdy -theme ~/.config/rofi/launchers/type-2/style-6.rasi")
)

hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.float())
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }))

for i = 1, 9 do
	hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind("CTRL + Tab", hl.dsp.exec_cmd("~/.config/hypr/scripts/ctrl-tab.sh next"))
hl.bind("CTRL + SHIFT + Tab", hl.dsp.exec_cmd("~/.config/hypr/scripts/ctrl-tab.sh prev"))

-- Screenshots
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot --freeze -m region --clipboard-only"))
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.sh"))
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-record.sh"))
hl.bind(mod .. " + CTRL + SHIFT + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-record-slurp.sh"))

-- Layout Keyboard Binds
hl.bind(mod .. " + CTRL + H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + J", hl.dsp.window.resize({ x = 0, y = -30, relative = true }))
hl.bind(mod .. " + CTRL + K", hl.dsp.window.resize({ x = 0, y = 30, relative = true }))

hl.bind(mod .. " + CTRL + left", hl.dsp.window.move({ x = -30, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + right", hl.dsp.window.move({ x = 30, y = 0, relative = true }))
hl.bind(mod .. " + CTRL + down", hl.dsp.window.move({ x = 0, y = -30, relative = true }))
hl.bind(mod .. " + CTRL + up", hl.dsp.window.move({ x = 0, y = 30, relative = true }))

-- Mouse Drag & Resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize())

-- Special Keys
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd(calculator))

-- Other Utilities
hl.bind(mod .. " + CTRL + P", hl.dsp.exec_cmd("hyprpicker | wl-copy"))

-- Cursor
hl.env("XCURSOR_THEME", "luciaic-64-hc")
hl.env("XCURSOR_SIZE", "64")
hl.env("HYPRCURSOR_THEME", "luciaic-64-hc")
hl.env("HYPRCURSOR_SIZE", "64")

-- Switch Layout Style
hl.bind(mod .. " + Tab", function()
	local layouts = { "scrolling", "dwindle", "master", "monocle" }
	local workspace = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end

	local next_layout = "dwindle"

	if not workspace then
		return
	end

	for i = 1, #layouts do
		if layouts[i] == workspace.tiled_layout then
			local next_layout_idx = (i % #layouts) + 1
			next_layout = layouts[next_layout_idx]
			break
		end
	end

	hl.notification.create({ text = "Switched to Layout " .. next_layout, timeout = 600 })
	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
end)

-- Toggle Zoom

---@param offset number
---@return nil
local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	if offset ~= nil then
		current = current + offset
	-- CHANGE: Toggle explicitly between MIN and MAX zoom boundaries
	elseif current == MIN_ZOOM then
		current = MAX_ZOOM
	else
		current = MIN_ZOOM
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end

hl.bind(mod .. " + Z", zoom)
hl.bind(mod .. " + KP_ADD", function()
	zoom(0.5)
end)
hl.bind(mod .. " + minus", function()
	zoom(-0.5)
end)

hl.window_rule({
	name = "noblueforwps",
	match = {
		class = "^(wps|et|wps-office)$",
	},
	no_blur = 1,
})
