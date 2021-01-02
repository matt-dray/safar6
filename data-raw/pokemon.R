# Generate 'pokemon' dataset
pokemon <- data.frame(
  game = "BLUE",
  area = "CENTER",
  tile = "GRASS",
  species = c("NIDORAN_F", "RHYHORN", "VENONAT", "EXEGGCUTE", "NIDORINA",
              "EXEGGCUTE", "NIDORINO", "PARASECT", "PINSIR", "CHANSEY"),
  level = c(22, 25, 22, 24, 31,
            25, 31, 30, 23, 23),
  hp_base = c(55, 80, 60, 60, 70,
              60, 61, 60, 65, 250),
  speed_base = c(41, 30, 45, 40, 56,
                 40, 65, 30, 85, 50),
  catch_base = c(25, 15, 15, 20, 10,
                 20, 5, 5, 4, 1),
  slot = 0:9,
  encounter_rate = c(0.2, 0.2, 0.15, 0.1, 0.1,
                     0.1, 0.05, 0.05, 0.04, 0.01)
)

# Write to data/
# usethis::use_data(pokemon, overwrite = TRUE)
