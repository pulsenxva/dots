/* interval between updates (in ms) */
const unsigned int interval = 1000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

static const struct arg args[] = {
	{ run_command, "%s | ",
	  "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '/MUTED/{print \"MUTE\"; next} {printf \"%d%%\", $2*100}'" },

	{ run_command, "%s | ",
	  "xset -q | awk '/LED mask/{print (substr($10,5,1)==\"1\") ? \"RU\" : \"US\"}'" },

	{ run_command, "%s | ",
	  "ip -4 route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++){if($i==\"dev\")d=$(i+1);if($i==\"src\")s=$(i+1)}} END{if(d==\"\")print \"NO NET\"; else if(d ~ /^w/)print \"WIFI\"; else print \"ETH \" s}'" },

	{ cpu_perc,    "CPU %s%% | ", NULL },

	{ run_command, "%s°C | ",
	  "d=$(dirname $(grep -lE 'coretemp|k10temp' /sys/class/hwmon/hwmon*/name | head -1)); awk '{print int($1/1000)}' $d/temp1_input" },

	{ run_command, "%s",
	  "for b in /sys/class/power_supply/BAT*; do printf '%s %s%% | ' $(basename $b) $(cat $b/capacity); done" },

	{ datetime,    "%s ",         "%d.%m.%Y - %I:%M %p" },
};
