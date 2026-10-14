# Blast pattern CLI
Simulate simple blast patterns on the command line. 

A small CLI that draws a blast pattern as an SVG. Provide a grid of holes, the delays between them, and a time. You get a the approximations of the wavefronts in that point in time. 

> This is a learning exercise in Haskell and Nix

## Requirements
[Nix](https://nixos.org/download) with flakes enabled. No further installations required.

## Usage
```bash
nix run . -- --rows 3 --cols 5 --burden 3 --spacing 3.5 --row-delay 42 --hole-delay 17 --at 120 --speed 0.1 > blast.svg
```

Then open `blast.svg` in a browser. The SVG is printed to stdout, so we need to redirect it to the file as above.

### Options
| Flag           | Unit | Description                               |
|----------------|------|-------------------------------------------|
| `--rows`       |      | Number of rows                            |
| `--cols`       |      | Holes per row                             |
| `--burden`     | m    | Distance between rows                     |
| `--spacing`    | m    | Distance between hole within a row        |
| `--row-delay`  | ms   | Delay between rows                        |
| `--hole-delay` | ms   | Delay between holes within a row          |   
| `--at`         | ms   | Time to simulate                          |
| `--speed`      | m/ms | Wave speed (default 4.0, i.e. 4000m/s)    |

`blast --help` print the same list.

## Layout
```bash
flake.nix
backend/
├── blast.cabal
├── app/Main.hs              
└── src/Blast/
    ├── Pattern.hs           
    ├── Simulate.hs          
    └── Render/Svg.hs        
```
