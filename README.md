
<!-- README.md is generated from README.Rmd. Please edit that file -->

# safar6

<!-- badges: start -->

[![Project Status: Concept – Minimal or no implementation has been done
yet, or the repository is only intended to be a limited example, demo,
or
proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R-CMD-check](https://github.com/matt-dray/safar6/workflows/R-CMD-check/badge.svg)](https://github.com/matt-dray/safar6/actions)
[![CodeFactor](https://www.codefactor.io/repository/github/matt-dray/safar6/badge)](https://www.codefactor.io/repository/github/matt-dray/safar6)
[![rostrum.blog
post](https://img.shields.io/badge/rostrum.blog-post-008900?style=flat&labelColor=black&logo=data:image/gif;base64,R0lGODlhEAAQAPEAAAAAABWCBAAAAAAAACH5BAlkAAIAIf8LTkVUU0NBUEUyLjADAQAAACwAAAAAEAAQAAAC55QkISIiEoQQQgghRBBCiCAIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAAh+QQJZAACACwAAAAAEAAQAAAC55QkIiESIoQQQgghhAhCBCEIgiAIgiAIQiAIgSAIgiAIQiAIgRAEQiAQBAQCgUAQEAQEgYAgIAgIBAKBQBAQCAKBQEAgCAgEAoFAIAgEBAKBIBAQCAQCgUAgEAgCgUBAICAgICAgIBAgEBAgEBAgEBAgECAgICAgECAQIBAQIBAgECAgICAgICAgECAQECAQICAgICAgICAgEBAgEBAgEBAgICAgICAgECAQIBAQIBAgECAgICAgIBAgECAQECAQIBAgICAgIBAgIBAgEBAgECAgECAgICAgICAgECAgECAgQIAAAQIKAAA7)](https://www.rostrum.blog/2021/01/04/safar6/)
<!-- badges: end -->

## Summary

An R package containing an [R6](https://r6.r-lib.org/) class to simulate
simplified gameplay elements of [the Safari
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
programming in R. It’s purely for learning purposes. You can [read a
blog post](https://www.rostrum.blog/2021/01/04/safar6/) about it.

## Basic gameplay

Install from GitHub with `remotes::install_github("matt-dray/safar6")`.

The game is text-based and takes place entirely in the console. Start a
game like `x <- safar6::SafariZone$new()`. Be warned: it’s tricky. But
then so was the original.

Use `x$step()` to take a step through the tall grass of the Safari Zone.
There’s a chance you’ll encounter a wild Pokémon; perhaps it will be a
rare one at a high level. You’ll be prompted to throw a Safari Ball to
try and catch it, with the option to throw bait or a rock to influence
its catchability. Try to catch as many Pokémon as you can before you run
out of steps or balls.

Use `x$pause()` to ‘pause’ the game and see your current stats. You can
boot up `x$bills_pc` to see which Pokémon you’ve caught so far.

For help with fields and methods see `?safar6::SafariZone`.

<details>
<summary>
Expand for (contrived) example gameplay 👾
</summary>

``` r
> library(safar6)
# {safar6}
# Start game: x <- SafariZone$new()
# Take a step: x$step()
> x <- SafariZone$new()
# ------------------------
# First, what is your name?
# NEW NAME (1)
# BLUE (2)
# GARY (3)
# JOHN (4)
# ------------------------
# Select 1, 2, 3 or 4:
> 1
# Your name: 
> THEW
# Welcome to the SAFARI ZONE!
# For just P500, you can catch all the
# Pokemon you want in the park!
# Would you like to join the hunt?
# ------------------------
# MONEY: P500
# YES (1) or NO (2)
# ------------------------
# Select 1 or 2: 
> 1
# That'll be P500 please!
# ------------------------
# MONEY: P0
# ------------------------
# We only use a special POKe BALL here.
# THEW received 30 SAFARI BALLs!
# We'll call you on the PA when you run out of time or SAFARI BALLs!
> x$step()
# 499/500
> x$step()
# 498/500
> x$step()
# 497/500
# Wild VENONAT L22 appeared!
# ------------------------
# BALLx30 (1)     BAIT (2)
# THROW ROCK (3)  RUN (4)
# ------------------------
# Selection: 
> 3
# THEW threw a ROCK.
# Wild VENONAT is angry!
# ------------------------
# BALLx30 (1)     BAIT (2)
# THROW ROCK (3)  RUN (4)
# ------------------------
# Select 1, 2, 3 or 4: 
> 1
# THEW used SAFARI BALL!
# Wobble...
# Darn! The POKeMON broke free!
# Wild VENONAT is angry!
# ------------------------
# BALLx29 (1)     BAIT (2)
# THROW ROCK (3)  RUN (4)
# ------------------------
# Select 1, 2, 3 or 4: 
> 1
# THEW used SAFARI BALL!
# Wobble... Wobble... Wobble...
# All right!
# VENONAT was caught!
# Do you want to give a nickname to VENONAT?
# ------------------------
# YES (1) or NO (2)
# ------------------------
# Select 1 or 2:
> 1
# Nickname: 
> Tajiri
# Tajiri was transferred to BILL's PC!
> x$pause()
# 497/500
# BALLx28
# Transferred to BILL's PC: 1
> x$bills_pc
#   nickname species level
# 1   Tajiri VENONAT    22
```

</details>

## Graphics

Here’s a screenshot of the game in action using the
[gamelad](https://github.com/matt-dray/gamelad) RStudio theme and [the
VT323 font](https://fonts.google.com/specimen/VT323).

<img src="https://raw.githubusercontent.com/matt-dray/gamelad/main/img/rstudio-safar6-gamelad-vt323.png" alt="Screenshot of Rstudio showing only the console pane with green text and background, showing text that describes an encounter with a Pokemon." width="50%"/>

## Details

### The Safari Zone

The [Safari
Zone](https://bulbapedia.bulbagarden.net/wiki/Kanto_Safari_Zone) is an
enclosed area separate from the rest of the game. Game mechanics are
different here: you’re allowed 500 steps and 30 balls to capture
Pokémon. Also, wild encounters don’t result in a ‘battle’; instead you
can ‘bait’ or ‘throw a rock’ to influence the catch rate of the target.
I chose to simulate this area due to its relative simplicity compared to
other areas of the game, which use a more complex battle mechanic.

### Technicals

The fields in the `SafariZone` class are ‘overworld’ counters,
basically: the number of steps and balls remaining, and the number and
identity of captures you’ve made.

Methods are:

-   `$new()` to initialise the class and start the game
-   `$step()`, which moves your ‘player’ and may result in an encounter
-   `$pause()` (a copy of the `$print()` method) to simulate the pause
    screen from the game, showing the current number of steps and balls
    remaining

The `$step()` method does the hard work. It contains code that:

-   decides whether you encountered a target, based on the encounter
    rate of the Safari Zone (\~12%)
-   selects a wild Pokémon based on the relative encounter-rate slots
    for the Safari Zone Center Area particular to *Pokémon Blue*
    (e.g. 20% for a level 22 Nidoran Female through to 1% for a level 23
    Chansey; see `safar6::pokemon` for details)
-   generates individual variation in the selected Pokémon’s speed and
    HP (IV values), which influence catchability
-   prompts you interactively for an action: throw ball, bait, throw
    rock, run
-   adjusts the ‘angry’ and ‘eating’ values of the target and modifies
    catch rate and run probability as a result (a rock doubles the catch
    rate and the flee chance; bait halves the catch rate, but makes it
    four times less likely to run)
-   calculates whether the Pokémon will be caught or will run away
-   terminates the game if steps or balls are depleted

## Omissions

To keep things (much!) simpler than the original, this implementation
doesn’t include a number of features from the original game. Some
missing elements are:

-   visuals (everything is printed in the console)
-   movement around a map (all steps are treated as though you’re moving
    through tall grass)
-   all areas of the Safari Zone (only the Center area is used here)
-   finding items (they have no use in this context)
-   fishing and use of different rod types
-   species catch and encounter rates from the other Gen 1 versions
    (e.g. Scyther is in *Red* rather than Pinsir; and *Yellow* has some
    catch-rate changes)

## Sources

Information about game mechanics and values are relatively tricky to
come by. I used the following resources:

-   [Bulbapedia](https://bulbapedia.bulbagarden.net/) for Pokémon stats
    and game mechanics
-   [The Cave of Dragonflies](https://www.dragonflycave.com/) for game
    mechanics
-   the [Pokémon Slots](https://sites.google.com/site/pokemonslots)
    website for encounter rates
-   the [pret/pokered GitHub repo](https://github.com/pret/pokered) for
    a disassembly of the games

I also referred to a post I wrote about [using {R6} to simulate an
Automatic Bell
Dispenser](https://www.rostrum.blog/2020/04/04/repaying-tom-nook-with-r6/)
from Nintendo’s *Animal Crossing: New Horizons* (2020).

## Code of Conduct

Please note that the {safar6} project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## Disclaimer

I do not condone throwing rocks at any creature, let alone catching and
imprisoning them.
