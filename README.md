Script displays the progress of the current day, week, month, and year in percentages.

```
 
 Day    : [##################................................]  36%
 Week   : [###############################...................]  62%
 Month  : [#######################...........................]  47%
 Year   : [######............................................]  12%

 ```

Requirements:
- Bash (standard shell)
- date (part of GNU coreutils)


You can integrate this script with anything you want.

Example:
- Add this line to your shell configuration file(.bashrc / .zshrc)
- `` ~/path/to/tbt.sh -d ``
- Now, every time you open a terminal, it will display the progress of the current day

```
 Day    : [##################................................]  36%
```


Flags

```bash 

tbt.sh -d # Day progress
tbt.sh -w # Week progress
tbt.sh -m # Month progress
tbt.sh -y # Year progress
```
