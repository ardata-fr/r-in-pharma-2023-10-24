library(tidyverse)
library(here)
library(flextable)

set_flextable_defaults(big.mark=" ",
                       font.family = "Open Sans")
gdtools::register_gfont("Open Sans")
tennis_players <-
  data.frame(
    Rank = 1:10,
    Player = c(
      "Roger Federer", "Lleyton Hewitt", "Feliciano Lopez", "Ivo Karlovic", "Andy Murray",
      "Pete Sampras", "Greg Rusedski", "Tim Henman", "Novak Djokovic", "Andy Roddick"
    ),
    Percentage = c(92.63, 85.29, 89.86, 94.87, 88.89, 92.66, 90.33, 83.77, 89.12, 92.76),
    `Games Won` = c(2739L, 1740L, 1684L, 1645L, 1528L, 1478L, 1476L, 1461L, 1442L, 1410L),
    `Total Games` = c(2957L, 2040L, 1874L, 1734L, 1719L, 1595L, 1634L, 1744L, 1618L, 1520L),
    Matches = c(205L, 149L, 122L, 113L, 121L, 105L, 116L, 110L, 106L, 103L),
    head = c(
      "federer_head.png", "hewitt_head.png", "lopez_head.png", "karlovic_head.png",
      "murray_head.png", "sampras_head.png", "rusedski_head.png", "henman_head.png",
      "djokovic_head.png", "roddick_head.png"
    ),
    flag = c(
      "sui.png", "aus.png", "esp.png", "cro.png", "gbr.png", "usa.png",
      "gbr.png", "gbr.png", "srb.png", "usa.png"
    ),
    stringsAsFactors = FALSE
  ) |>
  mutate(
    head = here("examples/tennis-player", "players", head),
    flag = here("examples/tennis-player", "flags", flag)
  )

ft <- flextable(tennis_players,
                col_keys = c("flag",
                             "Rank", "Player", "Percentage",
                             "Games.Won", "Total.Games", "Matches"
                )
)

ft <- mk_par(ft,
              j = "flag",
              value = as_paragraph(
                as_image(src = flag, width = .5, height = 0.33)
              )
) |>
  set_header_labels(flag = "Country")
ft <- mk_par(ft,
              j = "Player",
              value = as_paragraph(
                as_image(src = head, width = .33, height = 0.33),
                " ",
                as_chunk(x = Player)
              )
)

ft <- theme_vanilla(ft) |>
  align(align = "center", part = "all") |>
  align(align = "left", j = "Player", part = "all") |>
  autofit(add_w = .1, unit = "cm")

save_as_image(ft, path = here("assets/img/tennis-players.png"))
