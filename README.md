# linux-jcd
Quickly jump to a specific directory in the Linux shell.

## Important
Before installing this tool, please refer to [this page](https://github.com/siyuanl96/cmdAutoComp) to install `CmdAutoComp`, which is used to auto-complete commands.

## Usage
1. Run **`chmod +x jumpdir.sh`** to give `jumpdir.sh` execute permisson.
2. Append the contents of the `bashrc` to the `.bashrc` in your home directory. And replace `path/to/jumpdir.sh` with the path where you put `jumpdir.sh`.
3. Run **`source ~/.bashrc`**.
4. Try the following commands.
	- Run **`./jumpdir.sh -h`** to get the help info.
	- Run **`./jumpdir.sh -a `***`<alias>`***`=`***`<path>`* to add an alias for the specified directory.
	- Run **`./jumpdir.sh -l`** to list all aliases.
	- Run **`./jumpdir.sh -t `***`<alias>`* to get the path related to an alias.
5. Run **`jcd `** to list all aliases.
6. Run **`jcd `***`<alias>`* to jump to the specified directory.

### Exampe

```
source@debian:~/opensource/mine/linux-jcd$ ls
bashrc  jumpdir.sh  LICENSE  README.md
source@debian:~/opensource/mine/linux-jcd$ chmod +x jumpdir.sh
source@debian:~/opensource/mine/linux-jcd$ pwd
/home/source/opensource/mine/linux-jcd
source@debian:~/opensource/mine/linux-jcd$ vim ~/.bashrc
source@debian:~/opensource/mine/linux-jcd$ tail -3 ~/.bashrc
function jcd {
	cd $(/home/source/opensource/mine/linux-jcd/jumpdir.sh -t $1)
}
source@debian:~/opensource/mine/linux-jcd$ source ~/.bashrc
source@debian:~/opensource/mine/linux-jcd$ ./jumpdir.sh -a test=~
The alias test already exists, do you want to replace it? (y/n)
y
source@debian:~/opensource/mine/linux-jcd$ ./jumpdir.sh -l
test=/home/source
source@debian:~/opensource/mine/linux-jcd$ jcd test
source@debian:~$
```
