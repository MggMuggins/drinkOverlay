# drinkOverlay
A script I wrote to generate all the drinks images for the LOTR Mod

# Usage:
The script must be given the __assets__ directory inside an extracted LOTR mod jarfile. I reccomend only using complete paths with the script, because when I tried to use anything else I got a lot of errors.

```sh
./drinkOverlay.sh /path/to/lotr/assets /path/to/out/dir
```
The output directory must contain the ```Overlays/``` folder with all four overlays! Otherwise you will break things. I reccomend just giving it the full path of the directory you cloned this repo to.

I really don't have a lot of safeguards in this thing, so you have to basically use it exactly right or you get lots of errors.

Output can be found in ```Out/```.
