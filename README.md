
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

## Use

Install with `remotes::install_github("matt-dray/safar6")`. Initialise
with `sz <- safar6::SafariZone$new()` and access methods like
`sz$pause()` and `sz$step()`. For help with fields and methods see
`?SafariZone`.

## Details

### The Safari Zone

The Safari Zone is an enclosed area separate from the rest of the game.
Game mechanics are different here: you’re allowed 500 steps and 30 balls
to capture Pokémon. Also, wild encounters don’t result in a ‘battle’;
instead you can ‘bait’ or ‘throw a rock’ to influence the catch rate of
the target.

### Technicals

There are two types of field in the class:

-   ‘overworld’ counters: number of steps remaining, number of balls
    remaining, number of captures made
-   encounter-related states (which are refreshed at the start of an
    encounter and modified throughout): species, level, HP, speed, catch
    rate, and angry and eating statuses

The fields are `private`; they shouldn’t be influenced from outside the
class.

Methods are:

-   `$pause()` (a copy of the `$print()` method) to simulate the pause
    screen from the game, showing the current number of steps and balls
    remaining
-   `$step()`, which moves your ‘player’ and may result in an encounter

The `$step()` method contains code that:

-   decides whether you encountered a target, based on the encounter
    rate of the Safari Zone

Todo implement my pre-written `$step()` code that:

-   selects the wild Pokémon, based on the relative encounter rate for
    the Safari Zone Center Area, and generates some IVs
-   prompts you for an action
-   calculates your chance of capture if you throw a ball
-   influences the ‘angry’ and ‘eating’ values of the target
-   calculates the chance the target will flee at the end of each turn,
    based on fields like catch rate, HP, speed, anger and eating status

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