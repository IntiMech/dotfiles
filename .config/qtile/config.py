from libqtile import bar, layout, qtile, widget, hook
import subprocess
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()    

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.spawn("rofi -show run"), desc="Launch Rofi"),
    # Key([mod], "space", lazy.layout.next(), desc=jMove window focus to other window"),
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
    # Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

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
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


# First, adjust the widget_defaults to increase padding, making everything more spaced out.
widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=10,  # Increased padding for dramatic spacing
)
extension_defaults = widget_defaults.copy()

# Then, adjust the bar settings to increase its size and possibly add margin,
# ensuring widgets have more room and don't overlap.
screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.GroupBox(
                    padding_x=5,  # Additional padding around the text
                    padding_y=5,  # Additional padding around the text
                    margin_x=5,  # Space between each group box
                    margin_y=5,  # Space above and below each group box
                    borderwidth=3,  # Thickness of the border around each group box
                ),
                widget.Prompt(
                    padding=10,  # Increase if you want more space around the prompt text
                ),
                widget.WindowName(
                    padding=10,  # Increase to give more space around the window name
                ),
                widget.Systray(
                    padding=10,  # Increase to space out systray icons
                ),
                widget.Clock(
                    format="%Y-%m-%d %a %I:%M %p",
                    padding=10,  # Increase to space out the clock from its neighbors
                ),
                # Add more widgets here with similar padding/margin adjustments as needed
            ],
            30,  # Increased bar size to accommodate larger padding and spacing
            # You can also add margin here if needed, for example:
            # margin=[10, 10, 10, 10]  # Margins for top, right, bottom, left
        ),
    ),
]

# Your other configurations remain the same...
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

# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

# Start Network Manager Applet
subprocess.Popen(["nm-applet"])

@hook.subscribe.startup_once
def autostart():
    import subprocess
    import time

    # Start Alacritty
    subprocess.Popen(["alacritty", "-e", "zsh"])

    # A delay to ensure Alacritty starts up before Brave, adjust the delay as needed
    time.sleep(2)  # 2-second delay

    # Start Brave
    subprocess.Popen(["brave"])

    # Start Notion
    subprocess.Popen(["notion-app"])
    time.sleep(1)  # Give Notion a moment to organize its thoughts

    # Start Obsidian
    subprocess.Popen(["/usr/bin/obsidian"])
    # Obsidian now takes a moment to unlock the vault


@hook.subscribe.client_new
def move_window_to_workspace(client):
    wm_class = client.window.get_wm_class()
    if wm_class:
        wm_class = wm_class[0].lower()  # Use the first part of WM_CLASS for matching
    else:
        return  # Exit if there's no WM_CLASS

    # Mapping of WM_CLASS names to workspace names/numbers, now with Notion and Obsidian
    window_to_workspace = {
        "brave-browser": "2",  # Brave heads to workspace 2
        "alacritty": "1",      # Alacritty prefers the solitude of workspace 1
        "obsidian": "3",       # Obsidian, the keeper of knowledge, claims workspace 3
        "notion": "4"          # Notion, ever the planner, moves to workspace 4
    }

    target_workspace = window_to_workspace.get(wm_class)

    if target_workspace:
        # Move the client to the target group without switching to it
        client.togroup(target_workspace, switch_group=False)
