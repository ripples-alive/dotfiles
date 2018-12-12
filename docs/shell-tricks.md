# shell tricks

### help

```bash
help export
run-help export
```

### using alias and functions in sudo

for alias only: https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo/22043#22043

```
alias sudo='sudo '
```

it also has side effect: https://superuser.com/questions/749314/how-do-you-set-alias-sudo-nocorrect-sudo-correctly

https://serverfault.com/questions/177699/how-can-i-execute-a-bash-function-with-sudo

https://serverfault.com/questions/177699/how-can-i-execute-a-bash-function-with-sudo/423546#423546

### Create alias if it doesn't already exist

```bash
command -v gdircolors >/dev/null 2>&1 || alias gdircolors="dircolors"

# this may be zsh only…
which glocate > /dev/null && alias locate=glocate
```

### compress and extract shit

```bash
7z a -tle files.7z this_stuff.json
7z e files.7z

gzip -k this_stuff.json
gunzip -k files.json.gz
```


### ag wont find things in my dotfiles because it treats them as hidden...


### print all colors

http://jafrog.com/2013/11/23/colors-in-terminal.html

```
for code in {0..255}
	do echo -e "\e[38;5;${code}m"'\\e[38;5;'"$code"m"\e[0m"
done
```

