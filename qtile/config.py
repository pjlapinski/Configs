import os
import subprocess
import copy

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = 'mod4'

browser = 'vivaldi-stable'

terminal = 'kitty'
terminal_file_manager = 'ranger'
terminal_command_prefix = 'sh -c'

graphical_file_manager = 'dolphin'

text_editor = 'gvim'

font = 'Fira Mono for Powerline'

home = os.path.expanduser('~')
config_path = f'{home}/.config/qtile'

colors = {
    'foreground': '#fbf1c7',
    'foreground_alt': '#282828',
    'background': '#282828',
    'gray': '#928374',
    'blue': '#83a598',
    'red': '#fb4934',
    'purple': '#d3869b',
    'orange': '#fe8019',
    'yellow': '#fabd2f',
    'green': '#b8bb26'
}

keys = [
    Key([mod, 'control'], 'r', lazy.reload_config(), desc='Reload the config'),
    Key([mod, 'control'], 'q', lazy.shutdown(), desc='Shutdown Qtile'),
    # Switch between windows
    Key([mod], 'h', lazy.layout.left(), desc='Move focus to left'),
    Key([mod], 'l', lazy.layout.right(), desc='Move focus to right'),
    Key([mod], 'j', lazy.layout.down(), desc='Move focus down'),
    Key([mod], 'k', lazy.layout.up(), desc='Move focus up'),
    Key([mod], 'space', lazy.layout.next(),
        desc='Move window focus to other window'),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, 'shift'], 'h', lazy.layout.shuffle_left(),
        desc='Move window to the left'),
    Key([mod, 'shift'], 'l', lazy.layout.shuffle_right(),
        desc='Move window to the right'),
    Key([mod, 'shift'], 'j', lazy.layout.shuffle_down(), desc='Move window down'),
    Key([mod, 'shift'], 'k', lazy.layout.shuffle_up(), desc='Move window up'),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, 'control'], 'j', lazy.layout.shrink(), desc='Grow window'),
    Key([mod, 'control'], 'k', lazy.layout.grow(), desc='Shrink window'),
    # Toggle between different layouts as defined below
    Key([mod], 'Tab', lazy.next_layout(), desc='Toggle between layouts'),
    Key([mod], 'w', lazy.window.kill(), desc='Kill focused window'),
    Key([mod], 'f', lazy.window.toggle_floating(),
        desc='Toggle floating of a window'),
    Key([mod, 'shift'], 'f', lazy.window.toggle_fullscreen(),
        desc='Toggle window fullscreen mode'),
    # Move between screens
    Key([mod], 'period', lazy.next_screen(), desc='Move focus to next screen'),
    Key([mod], 'comma', lazy.prev_screen(),
        desc='Move focus to previous screen'),
    # Running programs
    Key([mod], 'Return', lazy.spawn(terminal), desc='Launch terminal'),
    Key([mod], 'r', lazy.spawn(
        f'''dmenu_run -i -fn "{font}" \
        -nb {colors['background']} \
        -nf {colors['foreground']} \
        -sb {colors['orange']} \
        -sf {colors['foreground_alt']} \
        -p "Run: "'''), desc='Run dmenu'),
    Key([mod, 'shift'], 'slash', lazy.spawn(
        f'python {config_path}/list_keys.py'), desc='Spawn a window that lists all keybindings'),
    Key([mod], 'b', lazy.spawn(browser), desc='Spawn a browser window'),
    Key([mod], 'e', lazy.spawn(f'{terminal} {terminal_command_prefix} "{terminal_file_manager}"'), desc='Spawn the terminal file manager'),
    Key([mod, 'shift'], 'e', lazy.spawn(graphical_file_manager), desc='Spawn the graphical file manager'),
    Key([], 'Print', lazy.spawn('spectacle'), desc='Spawn the screenshot utility'),
    Key([mod], 't', lazy.spawn(text_editor), desc='Spawn the text editor')
]

layouts = [
    layout.MonadTall(border_normal='#000000', border_focus=colors['blue'], margin=8),
    layout.Max(),
    layout.Floating(border_normal='#000000', border_focus=colors['blue'])
]

groups = [
    Group('DEV', layout='monadtall'),
    Group('WWW', layout='monadtall', matches=[Match(wm_class=browser)]),
    Group('GAME', layout='max'),
    Group('CHAT', layout='monadtall', matches=[Match(wm_class='telegram-desktop'), Match(wm_class='discord')]),
    Group('MISC', layout='monadtall')
]

for i, group in enumerate(groups, 1):
    # mod1 + letter of group = switch to group
    keys.append(Key([mod], str(i), lazy.group[group.name].toscreen(
    ), desc=f'Switch to group {group.name}')),
    # mod1 + shift + letter of group = move focused window to group
    keys.append(Key([mod, 'shift'], str(i), lazy.window.togroup(
        group.name), desc=f'Move focused window to group {group.name}'))

widget_defaults = {
    'font': font,
    'fontsize': 12,
    'padding': 6,
    'background': colors['background'],
    'foreground': colors['foreground']
}

extension_defaults = widget_defaults.copy()

powerline_left_arrow = u'\ue0b2'

def make_widgets():
    widget_styling = {
        widget.CurrentScreen: {'padding': 6, 'inactive_color': colors['red'], 'active_color': colors['green']},
        widget.GroupBox: {
            'use_mouse_wheel': False,
            'rounded': False,
            'highlight_method': 'block',
            'block_highlight_text_color': colors['foreground_alt'],
            'inactive': colors['gray'],
            'active': colors['foreground'],
            'other_current_screen_border': colors['yellow'],
            'other_screen_border': colors['yellow'],
            'this_current_screen_border': colors['orange'],
            'this_screen_border': colors['orange'],
            'urgent_border': colors['red'],
            'urgent_text': colors['foreground']
        },
        widget.TaskList: {'icon_size': 0, 'rounded': False, 'padding_y': 2, 'max_title_width': 300},
        widget.CurrentLayout: {'background': colors['blue'], 'foreground': colors['foreground_alt']},
        widget.Volume: {
            'background': colors['purple'],
            'foreground': colors['foreground_alt'],
            'fmt': 'Volume: {}',
            'volume_app': 'pavucontrol-qt'
        },
        widget.Clock: {
            'background': colors['yellow'],
            'foreground': colors['foreground_alt'],
            'format': '%a, %d.%m.%Y %I:%M %p'
        }
    }

    powerline_arrow_styling = {
        'text': powerline_left_arrow,
        'fontsize': 24,
        'padding': 0,
        'width': 14
    }
    return [
        widget.CurrentScreen(**widget_styling[widget.CurrentScreen]),
        widget.Sep(foreground=colors['gray'], padding=0),
        widget.GroupBox(**widget_styling[widget.GroupBox]),
        widget.Sep(foreground=colors['gray']),
        widget.TaskList(**widget_styling[widget.TaskList]),

        # right side
        widget.Systray(),
        widget.Sep(linewidth=0),
        widget.TextBox(
            background=colors['background'],
            foreground=colors['blue'],
            **powerline_arrow_styling
        ),
        widget.CurrentLayout(**widget_styling[widget.CurrentLayout]),
        widget.TextBox(
            background=colors['blue'],
            foreground=colors['purple'],
            **powerline_arrow_styling
        ),
        widget.Volume(**widget_styling[widget.Volume]),
        widget.TextBox(
            background=colors['purple'],
            foreground=colors['orange'],
            **powerline_arrow_styling
        ),
        widget.Net(
            background=colors['orange'],
            foreground=colors['foreground_alt'],
            interface='enp37s0', format='{down} ↓↑ {up}',
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn('nm-connection-editor')}
        ),
        widget.TextBox(
            background=colors['orange'],
            foreground=colors['green'],
            **powerline_arrow_styling
        ),
        widget.CheckUpdates(
            background=colors['green'],
            colour_have_updates=colors['foreground_alt'],
            colour_no_updates=colors['foreground_alt'],
            no_update_string='Updates: 0',
            custom_command='yay -Qu',
            update_interval=20,
            mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(f'{terminal} {terminal_command_prefix} "yay -Syyu ; fish"')},
        ),
        widget.TextBox(
            background=colors['green'],
            foreground=colors['yellow'],
            **powerline_arrow_styling
        ),
        widget.Clock(**widget_styling[widget.Clock]),
        widget.Sep(linewidth=0, padding=10, background=colors['yellow']),
    ]

main_screen_widgets = make_widgets()

# There can be only one systray, and there is no need for another net monitor
second_screen_widgets = [
    w for w in make_widgets() if not
    (isinstance(w, widget.Net | widget.Systray | widget.CheckUpdates) or
     isinstance(w, widget.TextBox) and (w.background == colors['purple'] or w.background == colors['orange']))
]

# Fix the 'powerline' colors
[w for w in second_screen_widgets if isinstance(w, widget.TextBox)][-1].background = colors['purple']


screens = [
    Screen(top=bar.Bar(widgets=main_screen_widgets, size=23)),
    Screen(top=bar.Bar(widgets=second_screen_widgets, size=23))
]

# Drag floating layouts.
mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class='confirmreset'),  # gitk
        Match(wm_class='makebranch'),  # gitk
        Match(wm_class='maketag'),  # gitk
        Match(wm_class='ssh-askpass'),  # ssh-askpass
        Match(title='branchdialog'),  # gitk
        Match(title='pinentry'),  # GPG key password entry
        Match(wm_class='Yad'), # custom dialogue boxes
        Match(wm_class='Mirage'), # image viewer
        Match(wm_class='mpv'), # video player
    ]
)

auto_fullscreen = True
focus_on_window_activation = 'smart'
reconfigure_screens = True

auto_minimize = False
wl_input_rules = None
wmname = 'LG3D'

# Run the autostart file
@hook.subscribe.startup_once
def autostart():
    subprocess.run([f'{config_path}/autostart.sh'])
