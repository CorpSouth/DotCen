/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 2;        /* border pixel of windows */
static const unsigned int snap     = 32;       /* snap pixel */
static const int showbar           = 1;        /* 0 means no bar */
static const int topbar            = 1;        /* 0 means bottom bar */
static const char *fonts[]         = { "ubuntusansmono nerd font propo:style=medium" };
static const char dmenufont[]      = "ubuntusansmono nerd font propo:style=medium";
static const char jet[]            = "#181818";
static const char inkstone[]       = "#3D3D3D";
static const char silk[]           = "#CCCCCC";
static const char white[]          = "#FFFFFF";
static const char purple[]         = "#762572";
static const char *colors[][3]     = {
	/*               fg     bg     border       */
	[SchemeNorm] = { silk,  jet,    inkstone    },
	[SchemeSel]  = { white, purple, purple      },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* left to right: class instance title tags mask isfloating monitor */
	{ NULL,                         "Armcord Setup","ArmCord Setup",    1 << 1, 1, -1 },
	{ "ArmCord",                    NULL,            NULL,              1 << 1, 0, -1 },
	{ "bc",                         NULL,            NULL,              1 << 4, 0, -1 },
	{ "betterbird",                 NULL,            NULL,              1,      0, -1 },
	{ "bluetoothctl",               NULL,            NULL,              1 << 4, 0, -1 },
	{ "calcurse",                   NULL,            NULL,              1 << 3, 0, -1 },
	{ "Firefox",                    NULL,            NULL,              1,      0, -1 },
	{ "Gimp",                       NULL,            NULL,              0,      1, -1 },
	{ "librewolf-default",          NULL,            NULL,              1,      0, -1 },
	{ NULL,                         NULL,            "About LibreWolf", 1,      1, -1 },
	{ "htop",                       NULL,            NULL,              1 << 4, 0, -1 },
	{ "micro",                      NULL,            NULL,              1 << 4, 0, -1 },
	{ "mpv",                        NULL,            NULL,              1 << 2, 0, -1 },
	{ "ncdu",                       NULL,            NULL,              1 << 4, 0, -1 },
	{ "nmtui",                      NULL,            NULL,              1 << 4, 0, -1 },
	{ "nnn",                        NULL,            NULL,              1 << 4, 0, -1 },
	{ "Nsxiv",                      NULL,            NULL,              1 << 4, 0, -1 },
	{ "obexctl",                    NULL,            NULL,              1 << 4, 0, -1 },
	{ "ONLYOFFICE Desktop Editors", NULL,            NULL,              1 << 3, 0, -1 },
	{ "pulsemixer",                 NULL,            NULL,              0,      1, -1 },
	{ "qDiffusion",                 NULL,            NULL,              1 << 3, 0, -1 },
	{ "steam",                      NULL,            NULL,              1 << 2, 0, -1 },
	{ "TelegramDesktop",            NULL,            NULL,              1 << 1, 0, -1 },
	{ "Virt-viewer",                NULL,            NULL,              1 << 5, 0, -1 },
	{ "XCalc",                      NULL,            NULL,              1 << 4, 0, -1 },
	{ "XClock",                     NULL,            NULL,              0,      1, -1 },
	{ "Yad",                        NULL,            NULL,              0,      1, -1 },
	{ "Zathura",                    NULL,            NULL,              1 << 3, 0, -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* Putting this here to enable the XF86 keyset (additional function keys)  
 * and to keep the rest of the source code files stock
 */
#include <X11/XF86keysym.h>

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */

static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *btmancmd[]        = { "st", "-c", "bluetoothctl", "-e", "bluetoothctl", NULL  };
static const char *calccmd1[]        = { "st", "-c", "bc", "-e", "bc", NULL };
static const char *calccmd2[]        = { "xcalc", NULL };
static const char *dmenucmd[]        = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", jet, "-nf", silk, "-sb", purple, "-sf", white, NULL };
static const char *exitcmd[]         = { "pkill", "dwm", NULL }; /* only used if dwm is started in a "while" loop */
static const char *filescmd1[]       = { "st", "-c", "nnn", "-e", "nnn", NULL };
static const char *filescmd2[]       = { "yad", "--center", "--file", NULL };
static const char *lockcmd[]         = { "slock", NULL };
static const char *mailcmd[]         = { "betterbird.sh", NULL };
static const char *mednextcmd[]      = { "playerctl", "next", NULL };
static const char *medplaypausecmd[] = { "playerctl", "play-pause", NULL };
static const char *medprevcmd[]      = { "playerctl", "previous", NULL };
static const char *medstopcmd[]      = { "playerctl", "stop", NULL };
static const char *mixercmd[]        = { "st", "-c", "pulsemixer", "-e", "pulsemixer", NULL };
static const char *netmancmd[]       = { "st", "-c", "nmtui", "-e", "nmtui", NULL };
static const char *ncducmd[]         = { "st", "-c", "ncdu", "-e", "ncdu", "--color", "dark", NULL };
static const char *obexcmd[]         = { "st", "-c", "obexctl", "-e", "obexctl", NULL };
static const char *organizercmd[]    = { "st", "-c", "calcurse", "-e", "calcurse", NULL };
static const char *playercmd2[]      = { "mpv-xclip.sh", NULL };
static const char *playercmd1[]      = { "mpv","--player-operation-mode=pseudo-gui", "--", NULL };
static const char *printcmd1[]       = { "maim.sh", NULL };
static const char *printcmd2[]       = { "maim-selection.sh", NULL };
static const char *printcmd3[]       = { "maim-xclip.sh", NULL };
static const char *sysmoncmd[]       = { "st", "-c", "htop", "-e", "htop", NULL };
static const char *termcmd[]         = { "st", NULL };
static const char *voldowncmd[]      = { "pamixer.sh", "-d", NULL };
static const char *volmutecmd[]      = { "pamixer.sh", "-t", NULL };
static const char *volupcmd[]        = { "pamixer.sh", "-i", NULL };
static const char *webcmd[]          = { "librewolf", NULL };

static const Key keys[] = {
	/* modifier           key                      function        argument */
	{ MODKEY,               XK_p,                    spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,     XK_Return,               spawn,          {.v = termcmd } },
	{ 0,                    XF86XK_Calculator,       spawn,          {.v = calccmd1 } },
	{ Mod1Mask,             XF86XK_Calculator,       spawn,          {.v = calccmd2 } },
	{ ControlMask,          XF86XK_Calculator,       spawn,          {.v = organizercmd } },
	{ 0,                    XF86XK_Explorer,         spawn,          {.v = filescmd1 } },
	{ Mod1Mask,             XF86XK_Explorer,         spawn,          {.v = filescmd2 } },
	{ 0,                    XF86XK_HomePage,         spawn,          {.v = webcmd } },
	{ 0,                    XF86XK_Mail,             spawn,          {.v = mailcmd } },
	{ 0,                    XF86XK_Tools,            spawn,          {.v = playercmd1 } },
	{ Mod1Mask,             XF86XK_Tools,            spawn,          {.v = playercmd2 } },
	{ ControlMask|MODKEY,   XK_v,                    spawn,          {.v = mixercmd } },
	{ ControlMask|MODKEY,   XK_b,                    spawn,          {.v = btmancmd } },
	{ ControlMask|MODKEY,   XK_d,                    spawn,          {.v = ncducmd } },
	{ ControlMask|MODKEY,   XK_n,                    spawn,          {.v = netmancmd } },
	{ ControlMask|MODKEY,   XK_o,                    spawn,          {.v = obexcmd } },
	{ 0,                    XF86XK_AudioLowerVolume, spawn,          {.v = voldowncmd } },
	{ 0,                    XF86XK_AudioMute,        spawn,          {.v = volmutecmd } },
	{ 0,                    XF86XK_AudioRaiseVolume, spawn,          {.v = volupcmd } },
	{ 0,                    XF86XK_AudioNext,        spawn,          {.v = mednextcmd } },
	{ 0,                    XF86XK_AudioPlay,        spawn,          {.v = medplaypausecmd } },
	{ 0,                    XF86XK_AudioPrev,        spawn,          {.v = medprevcmd } },
	{ 0,                    XF86XK_AudioStop,        spawn,          {.v = medstopcmd } },
	{ 0,                    XK_Print,                spawn,          {.v = printcmd1 } },
	{ Mod1Mask,             XK_Print,                spawn,          {.v = printcmd2 } },
	{ ControlMask,          XK_Print,                spawn,          {.v = printcmd3 } },
	{ MODKEY,               XK_Escape,               spawn,          {.v = sysmoncmd } },
	{ ControlMask|Mod1Mask, XK_Pause,                spawn,          {.v = lockcmd } },
	{ MODKEY,               XK_b,                    togglebar,      {0} },
	{ MODKEY,               XK_j,                    focusstack,     {.i = +1 } },
	{ MODKEY,               XK_k,                    focusstack,     {.i = -1 } },
	{ MODKEY,               XK_i,                    incnmaster,     {.i = +1 } },
	{ MODKEY,               XK_d,                    incnmaster,     {.i = -1 } },
	{ MODKEY,               XK_h,                    setmfact,       {.f = -0.05} },
	{ MODKEY,               XK_l,                    setmfact,       {.f = +0.05} },
	{ MODKEY,               XK_Return,               zoom,           {0} },
	{ MODKEY,               XK_Tab,                  view,           {0} },
	{ MODKEY|ShiftMask,     XK_c,                    killclient,     {0} },
	{ MODKEY,               XK_t,                    setlayout,      {.v = &layouts[0]} },
	{ MODKEY,               XK_f,                    setlayout,      {.v = &layouts[1]} },
	{ MODKEY,               XK_m,                    setlayout,      {.v = &layouts[2]} },
	{ MODKEY,               XK_space,                setlayout,      {0} },
	{ MODKEY|ShiftMask,     XK_space,                togglefloating, {0} },
	{ MODKEY,               XK_0,                    view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,     XK_0,                    tag,            {.ui = ~0 } },
	{ MODKEY,               XK_comma,                focusmon,       {.i = -1 } },
	{ MODKEY,               XK_period,               focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_comma,                tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,     XK_period,               tagmon,         {.i = +1 } },
	TAGKEYS(                XK_1,                                    0)
	TAGKEYS(                XK_2,                                    1)
	TAGKEYS(                XK_3,                                    2)
	TAGKEYS(                XK_4,                                    3)
	TAGKEYS(                XK_5,                                    4)
	TAGKEYS(                XK_6,                                    5)
	TAGKEYS(                XK_7,                                    6)
	TAGKEYS(                XK_8,                                    7)
	TAGKEYS(                XK_9,                                    8)
	{ ControlMask|Mod1Mask, XK_End,                  spawn,          {.v = exitcmd } },
	{ MODKEY|ShiftMask,     XK_r,                    quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

