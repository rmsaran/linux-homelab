# Show battery Percentage
__bat(){
  local d=/sys/class/power_supply/BAT0
  [ -r "$d/capacity" ] || return
  local sym=""
  case "$(<"$d/status")" in
    Charging) sym="+" ;;
    Dischargin) sym="-" ;;
  esac
  printf '[%s%s%s] ' "$(<"$d/capacity")" "$sym"
}
PS1='$(__bat)'"$PS1"
