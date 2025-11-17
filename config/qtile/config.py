from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os
import subprocess
from libqtile.backend.wayland.inputs import InputConfig

@hook.subscribe.startup_once
def autostart():
    subprocess.Popen(["wl-paste", "--type", "text", "--watch", "cliphist", "store"])

def get_wifi_status():
    try:
        output = subprocess.check_output(
            'nmcli -t -f IN-USE,SSID,SIGNAL dev wifi | grep -E "^\*" | awk -F: \'{print $2 " (" $3 "%)"}\'',
            shell=True,
            text=True,
            timeout=2 
        ).strip()

        if output:
            return output
        else:
            return "Disconnected"

    except (subprocess.CalledProcessError, subprocess.TimeoutExpired, FileNotFoundError):
        return "Disconnected"

mod = "mod1"
terminal = guess_terminal()
browser = "firefox"

myTerm = "kitty" 

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod],  "b", lazy.spawn(browser), desc="Launch browser"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "F4",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod], "F3", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "d", lazy.spawn("rofi -show drun -show-icons"), desc='Run Launcher'),
    Key([], "Super_L", lazy.spawn("rofi -show drun -show-icons"), desc='Run Launcher'),
    # Bluetooth Script (Toggle/Connect)
    Key([mod, "control"], "b", lazy.spawn("/home/rio/nixos-dotfiles/config/qtile/scripts/bluetooth.sh"),
        desc="Run bluetooth.sh to manage connection"),

    # Network Script (e.g., dmenu/rofi for network selection)
    Key([mod, "control"], "n", lazy.spawn("/home/rio/nixos-dotfiles/config/qtile/scripts/network.sh"),
        desc="Run network.sh for Wi-Fi/Network selection"),

    # Powermenu Script (Shutdown/Reboot/Logout menu)
    Key([mod, "control"], "p", lazy.spawn("/home/rio/nixos-dotfiles/config/qtile/scripts/powermenu.sh"),
        desc="Run powermenu.sh to show power menu"),

    Key([mod, "control"], "e", lazy.spawn("/home/rio/nixos-dotfiles/config/qtile/scripts/emoji.sh"),
        desc="Run emoji.sh to show emoji"),

    Key([mod], "c", lazy.spawn('sh -c "cliphist list | rofi -dmenu | cliphist decode | wl-copy"'), desc="Clipboard Manager"),
    Key(
        ["control"],
        "F12",
        lazy.spawn('sh -c "maim -s | xclip -selection clipboard -t image/png -i"'),
        desc="Screenshot"
    ),

    Key([mod], "F7", lazy.spawn("brightnessctl set +5%"),
        desc="Increase screen brightness by 5%"),
    Key([mod], "F6", lazy.spawn("brightnessctl set 5%-"),
        desc="Decrease screen brightness by 5%"),

    Key([mod], "F10", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
        desc="Increase volume by 5%"),
    Key([mod], "F9", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
        desc="Decrease volume by 5%"),
    Key([mod], "F8", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
        desc="Toggle Mute"),

]

for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = [Group(i) for i in "123"] # Only three numbered groups now

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name)),
        ]
    )

colors = [
    ["#1a1b2680", "#1a1b2680"], # bg (primary.background)
    ["#a9b1d6", "#a9b1d6"],     # fg (primary.foreground)
    ["#32344a", "#32344a"],  # color01   (normal.black)
    ["#f7768e", "#f7768e"],  # color02   (normal.red)
    ["#9ece6a", "#9ece6a"],  # color03   (normal.green)
    ["#e0af68", "#e0af68"],  # color04   (normal.yellow)
    ["#7aa2f7", "#7aa2f7"],  # color05   (normal.blue)
    ["#ad8ee6", "#ad8ee6"],  # color06   (normal.magenta)
    ["#0db9d7", "#0db9d7"],  # color15   (bright.cyan)
    ["#444b6a", "#444b6a"]   # color[9]  (bright.black)
]

def C(x): return x[0] if isinstance(x, (list, tuple)) else x

layout_theme = {
    "border_width" : 1,
    "margin" : 1,
    "border_focus" : colors[6],
    "border_normal" : colors[0],
}

layouts = [
    layout.Columns(**layout_theme),
    layout.Max(),
    layout.Matrix(),
    layout.MonadTall(**layout_theme),
    layout.Zoomy(),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font Propo Bold",
    # font="Ubuntu Bold",
    fontsize=14,
    padding=0,
    background=colors[0],
)

extension_defaults = widget_defaults.copy()

sep = widget.Sep(linewidth=1, padding=8, foreground=colors[9])

screens = [
    Screen(
        top=bar.Bar(
            widgets = [
                widget.Spacer(length = 3),
                # widget.Image(
                #     filename = "~/.config/qtile/icons/debian.png",
                #     scale = "False",
                #     mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("qtilekeys-yad")},
                # ),
                widget.Prompt(
                    font = "Ubuntu Mono",
                    fontsize=14,
                    foreground = colors[1]
                ),
                widget.GroupBox(
                    fontsize = 16,
                    margin_y = 5,
                    margin_x = 5,
                    padding_y = 0,
                    padding_x = 2,
                    borderwidth = 3,
                    active = colors[8],
                    inactive = colors[9],
                    rounded = False,
                    highlight_color = colors[0],
                    highlight_method = "line",
                    this_current_screen_border = colors[7],
                    this_screen_border = colors [4],
                    other_current_screen_border = colors[7],
                    other_screen_border = colors[4],
                ),
                widget.TextBox(
                    text = '|',
                    font = "JetBrainsMono Nerd Font Propo Bold",
                    foreground = colors[9],
                    padding = 2,
                    fontsize = 14
                ),
                widget.WindowName(
                    foreground = colors[6],
                    padding = 8,
                    max_chars = 40
                ),
                widget.GenPollText(
                    update_interval=5,
                    func=get_wifi_status, # Call the new function
                    foreground=colors[5],
                    padding=8,
                    fmt=' {}', # Nerd Font Wi-Fi icon
                    mouse_callbacks={
                        'Button1': lazy.spawn(myTerm + ' -e nmcli device wifi list')
                    },
                ),
                sep,
                widget.Battery(
                    foreground=colors[6],           # pick a palette slot you like
                    padding=8,
                    update_interval=5,
                    format='{percent:2.0%} {char} {hour:d}:{min:02d}',  # e.g. "73% ⚡ 1:45"
                    fmt='Bat: {}',
                    charge_char='',               # shown while charging
                    discharge_char='',            # Nerd icon; use '-' if you prefer plain ascii
                    full_char='✔',                 # when at/near 100%
                    unknown_char='?',
                    empty_char='!',
                ),
                sep,
                widget.Clock(
                    foreground = colors[8],
                    padding = 8,
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('notify-date')},
                    #format = "%a, %b %d - %H:%M",
                    format = "%I:%M %p",
                ),
                widget.Systray(padding = 6),
                widget.Spacer(length = 8),
            ],
            margin=[0, 0, 1, 0],
            size=30
        ),
        wallpaper='~/nixos-dotfiles/images/image.png',
        wallpaper_mode='fill'
    ),
]

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

auto_minimize = True

wl_input_rules = {
    "1267:86:Elan Touchpad": InputConfig(
        tap=True,
        natural_scroll=True,
        tap_button_map='lrm'
    )
}

wl_xcursor_theme = None
wl_xcursor_size = 24

wmname = "LG3D"
