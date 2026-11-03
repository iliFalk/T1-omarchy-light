-- Mirrors hyprland.conf — H1 Light (iliFalk/h1-design-system).
-- Keep both files in step: Omarchy 4.5 reads the Lua form when Hyprland runs with Lua config.

hl.config({
  general = {
    col = {
      active_border = "rgb(0762B4)",
      inactive_border = "rgb(DDD8CA)",
    },
    border_size = 6,
    gaps_in = 5,
    gaps_out = 5,
  },
  group = {
    col = {
      border_active = "rgba(0762B4ee)",
      border_inactive = "rgb(DDD8CA)",
    },
    groupbar = {
      col = {
        active = "rgba(0762B499)",
        inactive = "rgba(DDD8CA88)",
      },
      text_color = "rgb(1A1A18)",
      text_color_inactive = "rgba(0762B4ee)",
    },
  },
  decoration = {
    rounding = 4,
    rounding_power = 3,
    shadow = {
      enabled = true,
      render_power = 8,
      range = 16,
      color = "rgba(00000033)",
    },
  },
})
