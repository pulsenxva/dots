/* dwm config modeled after the Hyprland setup. Put into the dwm sources, then: sudo make clean install */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* was 0 in Hyprland; dwm needs a border to show focus */
static const unsigned int snap      = 32;       /* snap distance of floating windows to edges, px */
static const unsigned int refreshrate = 60;     /* refresh rate while moving/resizing with the mouse */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Fira Sans:style=SemiBold:pixelsize=13" };   /* font from waybar style.css */
static const char dmenufont[]       = "Fira Sans:style=SemiBold:pixelsize=13";
static const char col_gray1[]       = "#1a1a1a";   /* inactive window border */
static const char col_bar[]         = "#181a1f";   /* bar background (rgba 24,26,31 from waybar) */
static const char col_gray2[]       = "#2a2e37";   /* selected tag background */
static const char col_gray3[]       = "#DCD7BA";   /* text color (same as waybar) */
static const char col_gray4[]       = "#DCD7BA";   /* selected tag text color */
static const char col_cyan[]        = "#268bd2";   /* active window border */
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_bar,   col_gray1 },
	[SchemeSel]  = { col_gray4, col_gray2, col_cyan  },
};

/* tagging: 10 workspaces like in Hyprland */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
};

/* layouts */
static const float mfact     = 0.5;     /* master area size: 0.5 splits the screen exactly in half */
static const int nmaster     = 1;       /* number of clients in the master area */
static const int resizehints = 0;       /* 0 makes windows fill all space, no gaps around terminals */
static const int lockfullscreen = 1;    /* keep focus on a fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* default: master on the left, the rest on the right */
	{ "><>",      NULL },    /* floating windows */
	{ "[M]",      monocle }, /* one window fills the screen */
};

/* key definitions */
#define MODKEY Mod4Mask   /* Super */
#define ALT    Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* run a command through the shell */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* required by dwm.c spawn(), filled in automatically */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]    = { "alacritty", NULL };
static const char *tmuxcmd[]    = { "alacritty", "-e", "tmux", NULL };
static const char *menucmd[]    = { "rofi", "-show", "drun", NULL };   /* replacement for wofi --show drun */
static const char *browsercmd[] = { "firefox", NULL };
static const char *filescmd[]   = { "nautilus", NULL };
static const char *telegramcmd[]= { "Telegram", NULL };
static const char *emacscmd[]   = { "emacs", NULL };
static const char *lockcmd[]    = { "/bin/sh", "-c", "$HOME/.local/bin/lock.sh", NULL };  /* hyprlock replacement, with blur */
static const char *calccmd[]    = { "gnome-calculator", "--mode=keyboard", NULL };
static const char *bluetoothcmd[]={ "blueman-manager", NULL };
static const char *networkcmd[] = { "throne", NULL };

static const Key keys[] = {
	/* modifier                     key                        function        argument */

	/* programs */
	{ MODKEY,                       XK_q,                      spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_Return,                 spawn,          {.v = termcmd } },
	{ MODKEY|ALT,                   XK_Return,                 spawn,          {.v = tmuxcmd } },
	{ MODKEY,                       XK_t,                      spawn,          {.v = telegramcmd } },
	{ MODKEY,                       XK_d,                      spawn,          {.v = emacscmd } },
	{ MODKEY,                       XK_l,                      spawn,          {.v = lockcmd } },
	{ MODKEY,                       XK_b,                      spawn,          {.v = browsercmd } },
	{ MODKEY,                       XK_r,                      spawn,          {.v = menucmd } },
	{ MODKEY,                       XK_space,                  spawn,          {.v = menucmd } },
	{ MODKEY,                       XK_e,                      spawn,          {.v = filescmd } },
	{ MODKEY,                       XK_k,                      spawn,          {.v = calccmd } },
	{ MODKEY,                       XK_m,                      spawn,          {.v = bluetoothcmd } },
	{ MODKEY,                       XK_n,                      spawn,          {.v = networkcmd } },
	/* clipboard history (needs clipmenu and clipmenud running in autostart) */
	{ MODKEY,                       XK_o,                      spawn,          SHCMD("clipmenu") },
	/* region screenshot (maim + xclip) */
	{ MODKEY|ShiftMask,             XK_s,                      spawn,          SHCMD("mkdir -p ~/Pictures/Screenshots; f=~/Pictures/Screenshots/$(date +%F_%H-%M-%S).png; maim -s \"$f\" && xclip -selection clipboard -t image/png \"$f\"") },

	/* windows */
	{ MODKEY,                       XK_c,                      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_q,                      killclient,     {0} },
	{ MODKEY,                       XK_v,                      togglefloating, {0} },
	{ MODKEY,                       XK_f,                      setlayout,      {.v = &layouts[2]} },  /* monocle instead of fullscreen */
	{ MODKEY|ShiftMask,             XK_f,                      setlayout,      {.v = &layouts[0]} },  /* back to tile */
	/* with the fullscreen patch, use this instead of the two lines above: { MODKEY, XK_f, togglefullscr, {0} }, */
	{ MODKEY,                       XK_w,                      togglebar,      {0} },

	/* focus with arrows (dwm has no directional focus, so we walk the window stack) */
	{ MODKEY,                       XK_Left,                   focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_Up,                     focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_Right,                  focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Down,                   focusstack,     {.i = +1 } },

	/* move windows with Alt+arrows: needs the movestack patch, then uncomment
	{ ALT,                          XK_Left,                   movestack,      {.i = -1 } },
	{ ALT,                          XK_Up,                     movestack,      {.i = -1 } },
	{ ALT,                          XK_Right,                  movestack,      {.i = +1 } },
	{ ALT,                          XK_Down,                   movestack,      {.i = +1 } },
	*/
	/* without the patch: swap the selected window with master */
	{ MODKEY|ShiftMask,             XK_Return,                 zoom,           {0} },

	/* master area width: Super+[ and Super+] */
	{ MODKEY,                       XK_bracketleft,            setmfact,       {.f = -0.02} },
	{ MODKEY,                       XK_bracketright,           setmfact,       {.f = +0.02} },
	/* number of windows in the master area */
	{ MODKEY|ShiftMask,             XK_bracketleft,            incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_bracketright,           incnmaster,     {.i = +1 } },
	/* height resize with Ctrl+Up/Down: needs the cfacts patch, then uncomment
	{ ControlMask,                  XK_Up,                     setcfact,       {.f = +0.25} },
	{ ControlMask,                  XK_Down,                   setcfact,       {.f = -0.25} },
	*/

	/* monitors */
	{ MODKEY|ShiftMask,             XK_comma,                  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,                 tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_comma,                  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,                 focusmon,       {.i = +1 } },

	/* workspaces 1..10 */
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	TAGKEYS(                        XK_0,                      9)

	/* quit dwm */
	{ MODKEY|ShiftMask,             XK_Escape,                 quit,           {0} },

	/* volume and brightness */
	{ 0, XF86XK_AudioRaiseVolume,   spawn, SHCMD("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+") },
	{ 0, XF86XK_AudioLowerVolume,   spawn, SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") },
	{ 0, XF86XK_AudioMute,          spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") },
	{ 0, XF86XK_MonBrightnessUp,    spawn, SHCMD("brightnessctl set +5%") },
	{ 0, XF86XK_MonBrightnessDown,  spawn, SHCMD("brightnessctl set 5%-") },
};

/* button definitions */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },   /* Super+LMB: move window */
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },   /* Super+RMB: resize window */
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
