from libqtile import bar, layout, qtile, widget, hook
import os
import time
import subprocess
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget.pulse_volume import PulseVolume

mod = "mod4"
terminal = guess_terminal()    

# Define groups with screen affinity for dual screen setup
groups = [
    Group("1", screen_affinity=0),
    Group("2", screen_affinity=0),
    Group("3", screen_affinity=0),
    Group("4", screen_affinity=0),

    Group("5", screen_affinity=1),
    Group("6", screen_affinity=1),
    Group("7", screen_affinity=1),
    Group("8", screen_affinity=1),
    Group("9", screen_affinity=1),


]


def go_to_group(name: str):
    def _inner(qtile):
        target_screen = 0 if name in '123456789' else 1  # Assuming workspace 1-4 on screen 0, and 5-8 on screen 1
        if len(qtile.screens) > 1:
            qtile.focus_screen(target_screen)
        if qtile.current_screen.index == target_screen:
            qtile.groups_map[name].toscreen()
    return _inner


def go_to_group_and_move_window(name: str):
    def _inner(qtile):
        # Determine the target screen based on the workspace number
        target_screen = 0 if name in '1234' else 1  # Workspaces 1-4 on screen 0 (DP), 5-9 on screen 1 (HDMI)
        
        # No focus change on screen, just move the window to the desired group
        qtile.current_window.togroup(name)

        # Optionally: Move the group to the current screen if desired, but without focusing
        # qtile.groups_map[name].toscreen(toggle=False) # Uncomment this if you want the group also visible

    return _inner

# Keybindings
keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.spawn("rofi -show drun"), desc="Launch Rofi"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "p", lazy.spawn("flameshot gui"), desc="Take a screenshot"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]


# Update key bindings for moving windows without focusing
for group in groups:
    keys.extend([
        Key([mod, "shift"], group.name, lazy.function(go_to_group_and_move_window(group.name)), desc=f"Move window to group {group.name} without focusing"),
    ])

# Define screens with specific group visibility
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(visible_groups=["1", "2", "3", "4"]),
                widget.Wallpaper(
                    directory='~/Pictures/Wallpapers/',
                    random_selection=True,
                    label='',
                    wallpaper_command=None,
                    option='fill',
                    mouse_callbacks={'Button1': lazy.widget["wallpaper"].eval('self.set_wallpaper()')}
                ),
            ],
            24,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(visible_groups=["5", "6", "7", "8", "9"]),
                # widget.Prompt(),
                widget.Systray(),
                widget.PulseVolume(),
                widget.Bluetooth(
                    default_show_battery=True,
                    device_battery_format=" ({battery}%)",
                    device_format="{battery_level} [{symbol}]",
                    symbols={
                        "BT Adv360 Pro": "🎧",  # Headphone emoji
                        "MDR-1000X": "🎧",
                        },
                    ),
                widget.Wallpaper(
                    directory='~/Pictures/Wallpapers/',
                    random_selection=True,
                    label='',
                    wallpaper_command=None,
                    option='fill',
                    mouse_callbacks={'Button1': lazy.widget["wallpaper"].eval('self.set_wallpaper()')}
                ),
            ],
            18,
        ),
    ),
]
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class='VirtualBox Machine'),  # Add this line
    ]
)
layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    floating_layout
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

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')  # Resolve the home directory path
    log_path = os.path.join(home, 'startup.log')  # Specify a log file path in your home directory

    def launch_app(command, delay=0, cwd=None):
        """Launch an application with an optional delay and in a specific working directory."""
        if delay:
            time.sleep(delay)  # Introduce a delay if specified
        with open(log_path, 'a') as log_file:
            log_file.write(f"Executing command: {' '.join(command)} at {time.ctime()} in {cwd or 'default directory'}\n")
            try:
                subprocess.Popen(command, cwd=cwd, stdout=log_file, stderr=subprocess.STDOUT)  # Redirect stdout and stderr to log file
            except Exception as e:
                log_file.write(f"Error starting {command}: {e}\n")  # Log any errors in launching

    # Set up the D-Bus environment
    if 'DBUS_SESSION_BUS_ADDRESS' not in os.environ:
        subprocess.Popen(['dbus-launch', '--sh-syntax', '--exit-with-session'], stdout=subprocess.PIPE)
        dbus_output = subprocess.check_output(['dbus-launch', '--sh-syntax', '--exit-with-session'])
        for line in dbus_output.decode().split(';'):
            if line.strip().startswith('export'):
                key, val = line.replace('export ', '').split('=')
                os.environ[key] = val.strip()


    # Start core applications with optional delays
    launch_app(['picom'])
    launch_app(['blueman-applet'])  # Bluetooth management
    launch_app(['nm-applet'])  # Network manager applet
    launch_app(["alacritty", "-e", "zsh"])  # Terminal
    launch_app(["brave"], delay=2)  # Browser
    launch_app(["notion-app"], delay=1)  # Notion
    launch_app(["/usr/bin/obsidian"])  # Obsidian

    # Start Docker services for N8N and others
    launch_app(['docker-compose', 'up', '-d'], cwd=os.path.join(home, 'N8N'))
    launch_app(['ngrok', 'start', '--all', '--config', os.path.join(home, 'N8N', 'ngrok.yml')])

    # More Docker containers for other projects
    launch_app(['docker-compose', 'up', '-d'], cwd=os.path.join(home, 'Projects', 'gpt-researcher'))
    launch_app(['docker-compose', 'up', '-d'], cwd=os.path.join(home, 'Applications', 'Ollama'))

    # Launch the AppImage via the symbolic link
    launch_app([os.path.join(home, 'Applications', 'Beeper', 'beeper.AppImage')])
    launch_app(['zoom'])


    subprocess.run([
        "xrandr", "--output", "HDMI-0", "--mode", "1920x1080", "--pos", "0x0", "--rotate", "normal",
        "--output", "DP-0", "--primary", "--mode", "2560x1440", "--pos", "1920x0", "--rotate", "normal"
    ])

@hook.subscribe.client_new
def move_window_to_workspace(client):
    wm_class = client.window.get_wm_class()[0].lower() if client.window.get_wm_class() else ""

    # Mapping applications to specific workspaces
    app_workspace_map = {
        "alacritty": "1",
        "beeper": "2",
        "brave-browser": "5",
        "obsidian": "6",
        "notion": "7",
        "zoom": "9",
    }

    # Default workspace if app not specified
    default_workspace = "8"
    target_workspace = app_workspace_map.get(wm_class, default_workspace)

    # Move the client to the specified workspace
    client.togroup(target_workspace)
    if client.screen.index != int(target_workspace) - 1:
        client.toscreen(int(target_workspace) - 1)

