/* interval between updates (in ms) */
const unsigned int interval = 500;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

/* Nerd Font */

static const struct arg args[] = {
  { run_command, "%s   ",
  "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '/MUTED/{print \"󰝟\"; next} {v=$2*100; printf \"%s %d%%\", (v>=50)?\"󰕾\":\"󰖀\", v}'" },

	//{ run_command, "󰌌  %s   ",
	//  "xset -q | awk '/LED mask/{print (substr($10,5,1)==\"1\") ? \"RU\" : \"US\"}'" },

	{ run_command, "%s   ",
	  "ip -4 route get 1.1.1.1 2>/dev/null | awk '{for(i=1;i<=NF;i++){if($i==\"dev\")d=$(i+1);if($i==\"src\")s=$(i+1)}} END{if(d==\"\")print \"󰖪  NO NET\"; else if(d ~ /^w/)print \"󰖩 WIFI\"; else print \"󰈀  \" s}'" },

	{ cpu_perc,    "󰻠 %s%%   ", NULL },

	{ run_command, "\357\213\211 %s°C   ",
	  "d=$(dirname $(grep -lE 'coretemp|k10temp' /sys/class/hwmon/hwmon*/name | head -1)); awk '{print int($1/1000)}' $d/temp1_input" },

	{ run_command, "%s",
	  "for b in /sys/class/power_supply/BAT*; do [ -r \"$b/capacity\" ] && awk -v c=\"$(cat $b/capacity)\" -v s=\"$(cat $b/status)\" 'BEGIN{split(\"\357\211\204 \357\211\203 \357\211\202 \357\211\201 \357\211\200\",i,\" \"); k=int((c+12)/25)+1; if(k>5)k=5; printf \"%s  %d%%   \", (s==\"Charging\")?\"\357\203\247\":i[k], c}'; done" },

	{ datetime,    "󰃭 %s", "%a %d.%m" },
	{ datetime,    "   󰥔 %s ", "%I:%M %p" },
};
