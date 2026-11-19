# T1 Light — development

The palette, the terminal slots, the themed surfaces, the backgrounds and the credits.

The install and use steps sit in the [README](../README.md).

## Palette

| Role | Hex | Colour name |
|---|---|---|
| Background | `#F0EDE5` | Warm off-white / ivory |
| Surface | `#E8E4D9` | Sand / warm grey |
| Elevated | `#FFFFFF` | White |
| Field | `#FFFFFF` | White |
| Hover | `#DDD8CA` | Stone / light taupe |
| Line | `#DDD8CA` | Stone / light taupe |
| Text | `#1A1A18` | Ink / near-black |
| Muted | `#4A4A46` | Charcoal |
| Helper | `#5D5D5A` | Dark grey |
| Placeholder | `#6B6B69` | Mid grey |
| Disabled | `#8A8A87` | Neutral grey |
| Accent (fill) | `#0762B4` | Steel blue |
| Accent (text/link) | `#0762B4` | Steel blue |
| On accent | `#FFFFFF` | White |
| Accent press | `#0D4B82` | Deep steel blue |
| Success | `#1A6543` | Forest green |
| Error | `#BF3922` | Terracotta / brick |
| Error text | `#8A1C0E` | Chestnut / dark red |
| Press | `#C5C3BE` | Pebble / warm grey |

The accent `#0762B4` reaches **5.26:1** on `#F0EDE5`, so one accent step
serves both the fill and the text role. White on the accent reaches
**6.15:1**. Both values pass WCAG AA for normal text.

`#0D4B82` is the only derived accent step: the accent mixed 32 % toward
`#1A1A18`, used for a pressed control.

## Terminal

The terminal uses the T1 semantic colors as ANSI slots:

| Slot | Hex | Colour name |
|---|---|---|
| black | `#F0EDE5` | Warm off-white |
| red | `#BF3922` | Terracotta |
| green | `#237F52` | Forest green |
| yellow | `#8A6100` | Ochre |
| blue | `#0762B4` | Steel blue |
| magenta | `#6929C4` | Violet |
| cyan | `#005D5D` | Petrol / dark teal |
| white | `#1A1A18` | Ink |
| bright black | `#5D5D5A` | Dark grey |
| bright red | `#A51D2D` | Deep brick |
| bright green | `#1A6543` | Deep forest green |
| bright yellow | `#765600` | Deep ochre |
| bright blue | `#055094` | Deep steel blue |
| bright magenta | `#5F259F` | Deep violet |
| bright cyan | `#005D70` | Deep petrol |
| bright white | `#1A1A18` | Ink |

The green slot `#237F52` reaches 4.24:1 on the background, below the 4.5:1
that WCAG AA asks for normal text. The deep steps carry that load: use the
bright slots for small text.

## What is themed

- Omarchy shell: bar, launcher, menus, notifications, tooltips, lock, image picker
- Hyprland borders, group bars and shadows
- Hyprlock
- Mako, Walker, SwayOSD, Waybar
- Terminals: Alacritty, Ghostty, Kitty, Foot (generated from `colors.toml`)
- btop, cava, fish, fzf, superfile
- GTK, Steam, Discord/Vencord, Zed, Chromium and Zen take the same palette:
  the base16 slots of those files carry the T1 background, surface, text and
  eight semantic colors.

## Backgrounds

- `backgrounds/1-horisont.png` — T1-toned horizon, native 6016×3384. The theme
  ships one wallpaper.

The wallpaper is colour-graded at the source resolution, not resized or
upscaled: it maps to `#F0EDE5` and `#0762B4`. The regrade keeps the pixel's mix
factor, so the tone curve of the source is untouched. The dark-toned
counterpart of the same horizon ships in T2.

### Motion in the wallpaper

The viewpoint flies forward. The wallpaper is a radial exposure around a vanishing point at 0.50 of
the width and 0.62 of the height, just above the limb: each step back in time samples the frame closer
to that point, and the samples stack with a head at the present position and a tail toward the past.
Stars therefore streak away from the vanishing point, longer toward the edges, and the planet is
pushed 12 % closer so the limb reads as approaching.

The whole effect runs on `t`, the mix factor of the ground-to-accent segment, not on RGB. A trail
computed in RGB drags each pixel off the palette — measured at 24 units of residual against the
segment. Working on `t` keeps every pixel on it: the residual stays at 8.5 units, as before the change.

One limit is worth knowing. The limb already sits at the palette's full accent along its whole length,
so it cannot be made brighter, and a blur along its own direction changes nothing. The approach cue
comes from scale, not from a smear.

### Theme intro clip

Omarchy 4.5 plays a short clip when a theme is applied. The clip sits next to the wallpaper it
belongs to, in `backgrounds/intros/`, and carries the same name: `1-horisont.png` pairs with
`1-horisont.mp4`. OWE plays the clip, then the shell shows the still.

The clip runs six seconds at 2560×1440 and 24 frames per second. Two things move. The star field
starts at 0.55 of its final radius around the vanishing point, so the stars sit near the point on
short streaks, then stream outward and lengthen. The limb highlight slides 2.5 degrees about the
planet's centre, so the planet turns. Both effects decay to nothing.

The last frame equals `backgrounds/1-horisont.png` at 2560×1440 bit for bit, so the swap from video
to still shows no jump. `tools/render-intro.py` renders the frames from the shipped wallpaper, using
only Pillow and NumPy:

    python3 tools/render-intro.py --themes T1 --bg backgrounds --width 2560 --height 1440 \
      --frames 144 --growth0 0.55 --turn -2.5 --out /tmp/intro-frames

Then encode the frames:

    ffmpeg -framerate 24 -i /tmp/intro-frames/T1/f%04d.png -c:v libx264 -profile:v high \
      -pix_fmt yuv420p -crf 18 -movflags +faststart backgrounds/intros/1-horisont.mp4

The limb geometry in the script (`GEOMETRY`) is measured on this wallpaper. A different wallpaper
needs a new circle fit: the limb's upper edge, its centre and its radius in 6016×3384 coordinates.

Turn the intros off with `omarchy theme bg intro disable`, or turn all animations off under
Appearance > Animations.


### Note on Omarchy's git-theme policy

Omarchy does not stage `alacritty.toml`, `ghostty.conf`, `kitty.conf`,
`vscode.json` or `*.lua` from themes installed from a git repository, because
those files can execute code. The palette is therefore defined in
`colors.toml`; Omarchy generates the terminal configs from it. The explicit
terminal files in this repository are used when the theme is installed as a
local (non-git) directory.

## Credits

- Original **Oxocarbon Dark** theme by
  [HANCORE-linux](https://github.com/HANCORE-linux/omarchy-oxocarbon-theme)
- The palette follows the **T1 design system**, published as
  [iliFalk/h1-design-system](https://github.com/iliFalk/h1-design-system)
- Theme structure generated with
  [Omarchist](https://github.com/tahayvr/omarchist) by
  [Taha](https://github.com/tahayvr)
- Oxocarbon colours by
  [nyoom-engineering](https://github.com/nyoom-engineering/oxocarbon.nvim)

## License

MIT — see [LICENSE](../LICENSE). The original Oxocarbon theme is MIT-licensed;
this light adaptation keeps the same licence and attribution.
