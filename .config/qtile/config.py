# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import subprocess
import os
from libqtile import hook

mod = "mod4"
terminal = "kitty"
config_font = "JetBrainsMono Nerd Font"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    # These 4 for monadtall
    Key([mod], "i", lazy.layout.grow()),
    Key([mod], "m", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),

    # Switch Screen
    Key([mod], "period", lazy.next_screen(), desc="Move focus to next monitor"),
    Key([mod], "comma", lazy.prev_screen(), desc="Move focus to previous monitor"),

    # These or stack
    # Key([mod, "shift"], "space", lazy.layout.flip())
    # Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    # Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    # Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    # Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawn("rofi -show run"), desc="Spawn a command using a prompt widget"),
    Key([mod, "control"], "l", lazy.spawn("i3lock -i /home/yves/.config/qtile/kate-hazen-pop-retro1080.png"), desc="Lock screen"),
    Key([mod], "x", lazy.spawn("wm_power_menu"), desc="Show power menu"),

    # Function keys
    
    Key([], "XF86AudioLowerVolume", lazy.widget["volume"].decrease_vol(), desc="Decrease volume"),
    Key([], "XF86AudioRaiseVolume", lazy.widget["volume"].increase_vol(), desc="Increase volume"),
    Key([], "XF86AudioMute", lazy.widget["volume"].mute(), desc="Mute volume"),
]

def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)

def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)

keys.extend([
    # MOVE WINDOW TO NEXT SCREEN
    Key([mod,"shift"], "Right", lazy.function(window_to_next_screen, switch_screen=True)),
    Key([mod,"shift"], "Left", lazy.function(window_to_previous_screen, switch_screen=True)),
])

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.MonadTall(
        border_focus="#8f3d3d",
        border_width=2, 
        margin=8
    ),
    # layout.Columns(
    #     border_focus_stack=["#d75f5f", "#8f3d3d"], 
    #     border_width=2, 
    #     margin=8
    # ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font=config_font,
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(
                    borderwidth=2,
                    inactive="#606060",
                    this_current_screen_border="#8f3d3d",
                    font=config_font
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                widget.DF(
                    visible_on_warn=False,
                    format=" {r:.0f}% Free: {uf}{m}",
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Memory(
                    measure_mem="G",
                    fmt="󰍛 {}",
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Battery(
                    update_interval=10,
                    not_charging_char="󱟢",
                    charge_char="󰂄",
                    discharge_char="󱧥",
                    full_char = "󱊣",
                    format="{char} {percent:2.0%} {hour:d}:{min:02d}",
                    show_short_text=False
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Volume(
                    emoji=False,
                    emoji_list=["󰝟","󰕿","󰖀","󰕾"],
                    fmt="󰕾 {}",
                    step=10,
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Wlan(
                    format="  {essid} {percent:2.0%}",
                    interface="wlp4s0"
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.KeyboardLayout(
                    fmt="󰌌 {}",
                    configured_keyboards=["us", "us intl"],
                    mouse_callback={
                        lambda: lazy.widget["keyboardlayout"].next_keyboard()
                    }
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Clock(
                    format=" %Y-%m-%d %a   %I:%M %p",
                 ),
                # widget.Sep(
                #     padding=12,
                #     linewidth=2
                # ),
                # widget.Systray(),
                # widget.Sep(
                #     padding=12,
                #     linewidth=2
                # ),
                # widget.QuickExit(),
            ],
            24,
            background="#202020",
            border_width=[0, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        x11_drag_polling_rate = 60,
    ),
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(
                    borderwidth=2,
                    inactive="#606060",
                    this_current_screen_border="#8f3d3d",
                    font=config_font
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                widget.DF(
                    visible_on_warn=False,
                    format=" {r:.0f}% Free: {uf}{m}",
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Memory(
                    measure_mem="G",
                    fmt="󰍛 {}",
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Battery(
                    update_interval=10,
                    not_charging_char="󱟢",
                    charge_char="󰂄",
                    discharge_char="󱧥",
                    full_char = "󱊣",
                    format="{char} {percent:2.0%} {hour:d}:{min:02d}",
                    show_short_text=False
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Volume(
                    emoji=False,
                    emoji_list=["󰝟","󰕿","󰖀","󰕾"],
                    fmt="󰕾 {}",
                    step=10,
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Wlan(
                    format="  {essid} {percent:2.0%}",
                    interface="wlp4s0"
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.KeyboardLayout(
                    fmt="󰌌 {}",
                    configured_keyboards=["us", "us intl"],
                    mouse_callback={
                        lambda: lazy.widget["keyboardlayout"].next_keyboard()
                    }
                ),
                widget.Sep(
                    padding=12,
                    linewidth=2
                ),
                widget.Clock(
                    format=" %Y-%m-%d %a   %I:%M %p",
                 ),
                # widget.Sep(
                #     padding=12,
                #     linewidth=2
                # ),
                # widget.Systray(),
                # widget.Sep(
                #     padding=12,
                #     linewidth=2
                # ),
                # widget.QuickExit(),
            ],
            24,
            background="#202020",
            border_width=[0, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
