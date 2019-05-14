#!/bin/sh
xrandr --output HDMI-1-1 --off --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-0 --primary --mode 2560x1080 --pos 1920x0 --rotate normal --output DP-1-1 --off --output DP-0 --off
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select @2560x1080 +1920+0 {ViewPortIn=2560x1080, ViewPortOut=2560x1080+0+0, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
nitrogen --restore