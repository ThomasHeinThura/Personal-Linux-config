local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library
local gears         = require("gears")                              --Utilities such as color parsing and objects
local awful         = require("awful")                              --Everything related to window managment
                      require("awful.autofocus")
local wibox         = require("wibox")                              -- Widget and layout library
local beautiful     = require("beautiful")                          -- Theme handling library
local naughty       = require("naughty")                            -- Notification library
naughty.config.defaults['icon_size'] = 100
local lain          = require("lain")
local freedesktop   = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget         -- Enable hotkeys help widget for VIM and other apps
                      require("awful.hotkeys_popup.keys")           -- when client with a matching name is opened:
local my_table      = awful.util.table or gears.table               -- 4.{0,1} compatibility
local beautiful = require("beautiful")

--Error Handling
if awesome.startup_errors then naughty.notify({ preset = naughty.config.presets.critical, title = "Oops, there were errors during startup!", text = awesome.startup_errors }) end
-- Handle runtime errors after startup --
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical, title = "Oops, an error happened!", text = tostring(err) })
        in_error = false
    end)
end

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
run_once({ "urxvtd","unclutter -root" }) -- entries must be comma-separated

--Theme Start
local themes = {
    "blackburn",       -- 1
    "copland",         -- 2
    "dremora",         -- 3
    "holo",            -- 4<fav>
    "multicolor",      -- 5<fav>
    "powerarrow",      -- 6<fav>
    "powerarrow-dark", -- 7<fav>
    "rainbow",         -- 8
    "steamburn",       -- 9
    "vertex",          -- 10
    "powerarrow-blue", -- 11
}
-- choose your theme here --
local chosen_theme = themes[5]
local theme_path   = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)
local modkey       = "Mod4"
local altkey       = "Mod1"
local modkey1      = "Control"

-- personal variables --
local browser           = "firefox"
local editor            = os.getenv("EDITOR") or "vim"
local editorgui         = "code"
local filemanager       = "nemo"
local mediaplayer       = "vlc"
local terminal          = "alacritty"
--local virtualmachine    = "virtualbox"

-- awesome variables
awful.util.terminal = terminal
--awful.util.tagnames = { " DEV ", " WWW ", " SYS ", " DOC ", " VBOX ", " CHAT ", " MUS ", " VID ", " GFX " }   --multi-tab
awful.util.tagnames = { " HanLinn's WorkStation "}  --add whatever you like this is tag settings
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.floating,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}

lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then c.minimized = true
        else c:emit_signal("request::activate", "tasklist", {raise = true}) end end),
    awful.button({ }, 3, function ()
        local instance = nil
        return function ()
            if instance and instance.wibox.visible then instance:hide()
                instance = nil
            else instance = awful.menu.clients({theme = {width = 250}}) end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))

--leftclick call menu
local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e 'man awesome'" },
    { "edit config", "emacsclient -c -a emacs ~/.config/awesome/rc.lua" },
    { "arandr", "arandr" },
    { "restart", awesome.restart },
}
awful.util.mymainmenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {{ "Awesome", myawesomemenu, beautiful.awesome_icon },},
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Exit", "systemctl poweroff" },
        -- other triads can be put here
    }
})
-- Hide the menu when the mouse leaves it
awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function()
    if not awful.util.mymainmenu.active_child or
       (awful.util.mymainmenu.wibox ~= mouse.current_wibox and
       awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox) then
        awful.util.mymainmenu:hide()
    else
        awful.util.mymainmenu.active_child.wibox:connect_signal("mouse::leave",
        function() if awful.util.mymainmenu.wibox ~= mouse.current_wibox then awful.util.mymainmenu:hide() end end)
    end
end)


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true) end
end)
-- No border for maximized clients
function border_adjust(c)
    if c.maximized then -- no borders if only 1 client visible
        c.border_width = 0
    elseif #awful.screen.focused().clients > 1 then
        c.border_width = beautiful.border_width
        c.border_color = beautiful.border_focus
    end
end
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = my_table.join(
    -- Destroy all notifications
    awful.key({ "Control",        }, "space", function() naughty.destroy_all_notifications() end,
              {description = "destroy all notifications", group = "hotkeys"}),

    -- My applications (Super+Alt+Key)
    awful.key({ modkey,           }, "c", function () awful.util.spawn( "emacsclient -c -a 'emacs'" ) end, {description = "emacs" , group = "terminal apps" }),
    awful.key({ modkey,           }, "b", function () awful.spawn( "firefox" )                 end, {description = "firefox browser", group = "MyApp"}),
    awful.key({ modkey,           }, "e", function () awful.spawn( "nemo" )                    end, {description = "nemo file browser", group = "MyApp"}),
    -- screenshots
    awful.key({ }, "Print", function () awful.util.spawn("deepin-screenshot") end, {description = "Scrot", group = "screenshots"}),
    -- awful.key({ modkey1           }, "Print", function () awful.util.spawn( "xfce4-screenshooter" ) end, {description = "Xfce screenshot", group = "screenshots"}),
    -- awful.key({ modkey1, "Shift"  }, "Print", function() awful.util.spawn("gnome-screenshot -i")    end, {description = "Gnome screenshot", group = "screenshots"}),
    --
    -- By direction client focus
    	--awful.key({ altkey }, "j",  function() awful.client.focus.global_bydirection("down")  if client.focus then client.focus:raise() end end,
        	--{description = "focus down", group = "client"}),
    	--awful.key({ altkey }, "k",  function() awful.client.focus.global_bydirection("up")    if client.focus then client.focus:raise() end end,
        	--{description = "focus up", group = "client"}),
    	--awful.key({ altkey }, "h",  function() awful.client.focus.global_bydirection("left")  if client.focus then client.focus:raise() end end,
        	--{description = "focus left", group = "client"}),
    	--awful.key({ altkey }, "l",  function() awful.client.focus.global_bydirection("right") if client.focus then client.focus:raise() end end,
       	 	--{description = "focus right", group = "client"}),
    --
    -- Default client focus
    awful.key({ modkey,}, "]",     function () awful.client.focus.byidx( 1)  end, {description = "focus next by index", group = "client"}),
    awful.key({ modkey,}, "[",     function () awful.client.focus.byidx(-1)  end, {description = "focus previous by index", group = "client"}),
    -- By direction client focus with arrows
    awful.key({  modkey   }, "Down", function() awful.client.focus.global_bydirection("down")  if client.focus then client.focus:raise() end end,
        {description = "focus down", group = "client"}),
    awful.key({  modkey   }, "Up",   function() awful.client.focus.global_bydirection("up")    if client.focus then client.focus:raise() end end,
        {description = "focus up", group = "client"}),
    awful.key({  modkey   }, "Left", function() awful.client.focus.global_bydirection("left")  if client.focus then client.focus:raise() end end,
        {description = "focus left", group = "client"}),
    awful.key({  modkey   }, "Right",function() awful.client.focus.global_bydirection("right") if client.focus then client.focus:raise() end end,
        {description = "focus right", group = "client"}),
    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show()    end, {description = "show main menu", group = "awesome"}),
    -- Hotkeys Awesome
    awful.key({                   }, "F1",     hotkeys_popup.show_help,     {description = "show help", group="awesome"}),
    -- Tag browsing modkey + tab
    --awful.key({ modkey,           }, "Tab",   awful.tag.viewnext,           {description = "view next", group = "tag"}),
    --awful.key({ modkey, "Shift"   }, "Tab",   awful.tag.viewprev,           {description = "view previous", group = "tag"}),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "[", function () awful.client.swap.byidx(  1)    end, {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "]", function () awful.client.swap.byidx( -1)    end, {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey            }, ".", function () awful.screen.focus_relative( 1) end, {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey            }, ",", function () awful.screen.focus_relative(-1) end, {description = "focus the previous screen", group = "screen"}),
    --awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,                      {description = "jump to urgent client", group = "client"}),
    --awful.key({ modkey1,          }, "Tab",function () awful.client.focus.history.previous() if client.focus then client.focus:raise() end end, 
       --{description = "go back", group = "client"}),
    -- On the fly useless gaps change
    awful.key({ altkey,	 "Shift"  }, "]",     function () lain.util.useless_gaps_resize(1)  end, {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey,  "Shift"  }, "[",     function () lain.util.useless_gaps_resize(-1) end, {description = "decrement useless gaps", group = "tag"}),
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn( terminal.." -e fish" ) end, {description = "terminal with fish shell", group = "super"}),
    awful.key({ modkey, "Shift"   }, "r",     awesome.restart,                                      {description = "reload awesome", group = "awesome"}),
    awful.key({ altkey,   	  }, "]",     function () awful.tag.incmwfact( 0.05)          end,  {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey,   	  }, "[",     function () awful.tag.incmwfact(-0.05)          end,  {description = "decrease master width factor", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "+",     function () awful.tag.incnmaster( 1, nil, true) end,  {description = "increase the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Shift"   }, "-",     function () awful.tag.incnmaster(-1, nil, true) end,  {description = "decrease the number of master clients", group = "layout"}),
    --awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,  {description = "increase the number of columns", group = "layout"}),
    --awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,  {description = "decrease the number of columns", group = "layout"}),
    awful.key({ altkey,           }, "space", function () awful.layout.inc( 1)                end,  {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "q",     awesome.quti,                                         {description = "quit awesome", group = "awesome"}),
    --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,  {description = "select previous", group = "layout"}),

    -- Focus restored client
    --awful.key({ modkey, "Control" }, "n", function () local c = awful.client.restore() 
        --if c then client.focus = c  c:raise() end end,  {description = "restore minimized", group = "client"}),

    -- Show/Hide Wibox
    awful.key({ altkey }, "h", function ()
        for s in screen do  s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then s.mybottomwibox.visible = not s.mybottomwibox.visible end end end,  {description = "toggle wibox", group = "awesome"}),
    -- Dropdown application
    awful.key({ modkey, }, "z", function () awful.screen.focused().quake:toggle() end,              {description = "dropdown application", group = "super"}),
    -- Widgets popups
    awful.key({ altkey, }, "c", function () lain.widget.cal.show(7) end,                                 {description = "show calendar", group = "widgets"}),
    awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,           {description = "show filesystem", group = "widgets"}),
    awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end, {description = "show weather", group = "widgets"}),
    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end,     {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end,   {description = "-10%", group = "hotkeys"}),
    -- ALSA volume control
    --awful.key({ modkey1 }, "Up",
    awful.key({ }, "XF86AudioRaiseVolume", function () os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel)) beautiful.volume.update() end),
    --awful.key({ modkey1 }, "Down",
    awful.key({ }, "XF86AudioLowerVolume", function () os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel)) beautiful.volume.update() end),
    awful.key({ }, "XF86AudioMute", function () os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel)) beautiful.volume.update() end),
    awful.key({ modkey1, "Shift" }, "m",function () os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel)) beautiful.volume.update() end),
    awful.key({ modkey1, "Shift" }, "0",function () os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel)) beautiful.volume.update() end),
    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end, {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel")    end, {description = "copy gtk to terminal", group = "hotkeys"}),
    -- Prompt
    --awful.key({ modkey },"space", function () awful.screen.focused().mypromptbox:run() end, {description = "run prompt", group = "launcher"}),    
    awful.key({ modkey },"space", function () awful.spawn("rofi -show run") end, {description = "run prompt", group = "launcher"}),
    -- Default
    awful.key({ altkey, "Shift" }, "x",
            function () awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"} 
            end, {description = "lua execute prompt", group = "awesome"})
)

clientkeys = my_table.join(
    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client                         ,   {description = "magnify client", group = "client"}),
    awful.key({ altkey,           }, "F4",      function (c) c:kill()                        end,   {description = "close", group = "hotkeys"}),
    awful.key({ modkey, "Shift"   }, "space",  awful.client.floating.toggle                     ,   {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,   {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,   {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,   {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = true              end ,   {description = "minimize", group = "client"}),
    -- The client currently has the input focus, so it cannot beminimized, since minimized clients can't have the focus.
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen c:raise() end, {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "m",      function (c) c.maximized = not c.maximized c:raise() end ,  {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end
    globalkeys = my_table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                function () local screen = awful.screen.focused() local tag = screen.tags[i] if tag then tag:view_only() end end, descr_view),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                function () local screen = awful.screen.focused() local tag = screen.tags[i] if tag then awful.tag.viewtoggle(tag) end end, descr_toggle),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                function () if client.focus then local tag = client.focus.screen.tags[i] if tag then client.focus:move_to_tag(tag) end end end, descr_move),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                function () if client.focus then local tag = client.focus.screen.tags[i] if tag then client.focus:toggle_tag(tag) end end end,descr_toggle_focus)
    )
end

clientbuttons = gears.table.join(
    awful.button({        }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) awful.mouse.client.move(c)   end),
    awful.button({ modkey }, 3, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) awful.mouse.client.resize(c) end))

root.keys(globalkeys)           -- Set keys

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },properties = { titlebars_enabled = false } },

    -- Set applications to be maximized at startup.
    -- find class or role via xprop command

    { rule = { class = editorgui },
          properties = { maximized = true } },

    { rule = { class = "Gimp*", role = "gimp-image-window" },
          properties = { maximized = true } },

    { rule = { class = "inkscape" },
          properties = { maximized = true } },

    { rule = { class = mediaplayer },
          properties = { maximized = true } },

    { rule = { class = "Vlc" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Manager" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Machine" },
          properties = { maximized = true } },

    { rule = { class = "Xfce4-settings-manager" },
          properties = { floating = false } },



    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Blueberry",
          "Galculator",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Oblogout",
          "Peek",
          "Skype",
          "System-config-printer.py",
          "Sxiv",
          "Unetbootin.elf",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},

}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then awful.placement.no_offscreen(c) end end)
    -- Set the windows at the slave, i.e. put it at the end of others instead of setting it master. if not awesome.startup then awful.client.setslave(c) end
    -- Prevent clients from being unreachable after screen count changes.

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", 
    function(c) if beautiful.titlebar_fun then beautiful.titlebar_fun(c) return end -- Custom
    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function() c:emit_signal("request::activate", "titlebar", {raise = true}) awful.mouse.client.move(c) end),
        awful.button({ }, 3, function() c:emit_signal("request::activate", "titlebar", {raise = true}) awful.mouse.client.resize(c) end))

    awful.titlebar(c, {size = 21}) : setup {
        { awful.titlebar.widget.iconwidget(c), buttons = buttons, layout  = wibox.layout.fixed.horizontal }, -- Left
        { -- Middle
            { align  = "center", widget = awful.titlebar.widget.titlewidget(c)}, -- Title
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal},
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", "mouse_enter", {raise = true})  end)
client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("picom --config  $HOME/.config/picom/picom.conf")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("volumeicon")

awful.spawn("nvfancontrol")
awful.spawn.with_shell(terminal.." -e unimatrix -s 90")
awful.spawn.with_shell("conky -c /home/hanlinn/.config/conky/Titus.conkyrc")

--awful.spawn.with_shell(terminal.." -e gotop --nvidia -c vice")
--awful.spawn.with_shell(terminal.." -e nvtop")
--awful.spawn.with_shell(terminal.." -e ranger")
