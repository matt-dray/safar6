
<!-- README.md is generated from README.Rmd. Please edit that file -->

# safar6

<!-- badges: start -->

[![Project Status: Concept – Minimal or no implementation has been done
yet, or the repository is only intended to be a limited example, demo,
or
proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R-CMD-check](https://github.com/matt-dray/safar6/workflows/R-CMD-check/badge.svg)](https://github.com/matt-dray/safar6/actions)
[![CodeFactor](https://www.codefactor.io/repository/github/matt-dray/safar6/badge)](https://www.codefactor.io/repository/github/matt-dray/safar6)
<!-- badges: end -->

## Summary

Work in progress: an R package containing an [R6](https://r6.r-lib.org/)
class to simulate simplified gameplay elements of [the Safari
Zone](https://bulbapedia.bulbagarden.net/wiki/Kanto_Safari_Zone)
sub-area from [*Pokémon
Blue*](https://bulbapedia.bulbagarden.net/wiki/Generation_I) (1998) with
OOP.

The first generation of *Pokémon* games were developed for [the Nintendo
Game Boy](https://en.wikipedia.org/wiki/Game_Boy) by [Game
Freak](https://www.gamefreak.co.jp/) and published by
[Nintendo](https://www.nintendo.com). Pokémon as a property is owned by
[The Pokémon Company](https://www.pokemon.co.jp/).

This project is a demonstration of [the {R6}
package](https://r6.r-lib.org/) and the R6-class for object-oriented
programming in R. It’s purely for learning purposes.

## Play

Install from GitHub with `remotes::install_github("matt-dray/safar6")`.

Initialise with e.g. `sz <- safar6::SafariZone$new()`.

`sz$step()` to take a step in the Safari Zone. There’s an x% chance
you’ll encounter a Pokémon. The species and level of that Pokémon are
based on an encounter rate. You’ll be prompted to throw a Safari Ball,
throw bait, throw a rock or run. Bait and rocks influence catch rates.
The Pokémon’s level and HP also influence catchability. Try to catch as
many Pokémon as you can before you run out of steps or balls.

`sz$pause()` to ‘pause’ the game and see current stats.

For help with fields and methods see `?safar6::SafariZone`.

## Details

### The Safari Zone

The Safari Zone is an enclosed area separate from the rest of the game.
Game mechanics are different here: you’re allowed 500 steps and 30 balls
to capture Pokémon. Also, wild encounters don’t result in a ‘battle’;
instead you can ‘bait’ or ‘throw a rock’ to influence the catch rate of
the target.

### Technicals

The fields in the `SafariZone` class are ‘overworld’ counters: number of
steps remaining, number of balls remaining and number of captures made.

Methods are:

-   `$pause()` (a copy of the `$print()` method) to simulate the pause
    screen from the game, showing the current number of steps and balls
    remaining
-   `$step()`, which moves your ‘player’ and may result in an encounter

The `$step()` method contains code that:

-   decides whether you encountered a target, based on the encounter
    rate of the Safari Zone
-   selects the wild Pokémon, based on the relative encounter rate for
    the Safari Zone Center Area, and generates some IVs
-   prompts you for an action
-   calculates your chance of capture if you throw a ball
-   influences the ‘angry’ and ‘eating’ values of the target
-   calculates the chance the target will flee at the end of each turn,
    based on fields like catch rate, HP, speed, anger and eating status

TODO:

-   “New POKeDEX data will be added for \[x\].”
-   “Do you want to give a nickname to \[x\]?”
-   “\[x\] was transferred to BILL’s PC!”
-   BILL’s PC
-   IVs
-   wobble
-   an Easter egg…

### Not included

This implementation doesn’t include a number of features from the
original. Some missing elements are:

-   visuals (everything is printed in the console)
-   movement around a map (all steps are treated as though you’re moving
    through tall grass)
-   all areas of the Safari Zone (Center, East, West and North)
-   fishing and use of different rod types
-   species and catch and encounter rates from the other Gen 1 versions
    (*Red* and *Yellow*)

## Sources

Information about game mechanics and values are relatively tricky to
come by. I used the following resources:

-   [Bulbapedia](https://bulbapedia.bulbagarden.net/) for Pokémon stats
-   [The Cave of Dragonflies](https://www.dragonflycave.com/) for
    explanations of game mechanics
-   The [pret/pokered GitHub repo](https://github.com/pret/pokered) for
    a dissassembly of the games
-   The [Pokémon Slots](https://sites.google.com/site/pokemonslots)
    website for encounter rates

I also referred to a post I wrote about [using {R6} to simulate an
Automatic Bell
Dispenser](https://www.rostrum.blog/2020/04/04/repaying-tom-nook-with-r6/)
from Nintendo’s *Animal Crossing: New Horizons* (2020).

## Code of Conduct

Please note that the {safar6} project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
