set -l color00 '#F0EDE5'
set -l color01 '#BF3922'
set -l color02 '#237F52'
set -l color03 '#8A6100'
set -l color04 '#0762B4'
set -l color05 '#6929C4'
set -l color06 '#005D5D'
set -l color07 '#1A1A18'
set -l color08 '#5D5D5A'
set -l color09 '#A51D2D'
set -l color0A '#DDD8CA'
set -l color0B '#DDD8CA'
set -l color0C '#055094'
set -l color0D '#1A1A18'
set -l color0E '#005D70'
set -l color0F '#1A1A18'

set -l FZF_NON_COLOR_OPTS

for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
    if not string match -q -- "--color*" $arg
        set -a FZF_NON_COLOR_OPTS $arg
    end
end

set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"" --color=bg+:$color00,bg:$color00,spinner:$color0E,hl:$color0D"" --color=fg:$color07,header:$color0D,info:$color0A,pointer:$color0E"" --color=marker:$color0E,fg+:$color06,prompt:$color0A,hl+:$color0D"
