# rancinette

a fork of the [Francinette](https://github.com/xicodomingues/francinette) aiming to maintain the project just enough to be able to be installed and used.

this is not a revival of the original project.

despite the name change, which only concerns the present repository, every relevant aspect of the Francinette remains unaffected.

## this project is on life support.
i have wasted way too much time bringing it back from the dead, fixing issues that prevented installation partially or entirely.
the only point of this repository, besides featuring a less opinionated installer (as i consider that you should not touch config the user's config files without their consent), is to continue providing support for the ubiquitous unit tester that this remains, despite its many flaws.
## consider writing your own tests, and complementing yours with those of others.

An easy to use testing framework for the 42 projects.

Use `francinette` or `paco` inside a project folder to run it.

Currently has tests for: `libft`, `ft_printf`, `get_next_line`, `minitalk` and `pipex`.

`Francinette` is only tested and confirmed to work on MacOS on non ARM chips. Some testers may work on
Linux and ARM, but I give no guaranties of any test working or even compiling.

## :exclamation: Important note:

If you have little to no experience programming, I highly highly highly recommend that you write
your own tests first. For example, for `ft_split` try to write a main that tests that your code
works in most cases. It is also useful to think about corner cases, like what should it return
if the string is `""` or `"   "` or `"word"`. Don't rely just on `francinette` or other tests.

### :warning: Write your own tests, It's a very essential part of programming. :warning:

## Table of Contents
1. [Purpose](#purpose)
2. [Install](#install)
3. [Update](#update)
4. [Running](#Running)
5. [Uninstall](#uninstall)
6. [FAQ](#faq)
7. [Acknowledgments](#acknowledgments)


## Purpose:

This is designed to function as a kind of `moulinette` that you can execute in local.

That means that by executing `francinette` it will check `norminette`, compile the
code and execute the tests.

You can use it as a local test battery, to test your code.

#### Example execution:

![Example Image](doc/example.png)


## Install:
Francinette has an automatic installer.

Copy the line bellow to your console and execute it. It will automatically download the repo,
create the necessary folders and alias, and install a python virtual environment dedicated to
running this tool.

~~In linux it will also download and install the necessary packages for it to run. It needs
admin permission to do that.~~

no root permissions are required. (note that, even with the upstream installation script, merely cancelling with `Control C` the right amount of times would continue on to install the francinette successfully, assuming no package upgrades were required.)

```
bash -c "$(curl -fsSL https://raw.github.com/jaynemaxwell/rancinette/master/bin/install.sh)"
```

~~The francinette folder will be under your `$HOME` directory (`/Users/<your_username>/`)~~

the default installation directory is under `~/.local/opt/`.

the entry point will, by default, live in `~/.local/bin/`.

note that eventually the installer may prompt for custom locations for either of these.


## Update:
Normally francinette will prompt you when there is a new version, and you can then update it.

> [!Warning]
> note that updating is likely broken as i am yet to refactor it.
> consider pulling from the repository instead, by going to the installation directory (`~/.local/opt/` by default) and calling `git pull`.

You can also force it from francinette itself:

```
~ $> francinette -u              # Forces francinette to update
```

If the above does not work you can also execute the command bellow:

```
bash -c "$(curl -fsSL https://raw.github.com/jaynemaxwell/rancinette/master/bin/update.sh)"
```


## Running:

If you are on a root of a project, `francinette` should be able to tell which project
it is and execute the corresponding tests.

You can also use the shorter version of the command: `paco`

To see all the available options execute `paco -h`

```
/C00 $> francinette                  # Execute the tests for C00

/C00/ex00 $> francinette             # Execute only the tests for ex00 in C00

/libft $> francinette                # Execute the tests for libft

~ $> francinette -h                  # Shows the help message

libft $> paco memset isalpha memcpy  # Executes only the specified tests
```

The name of the folder is not important. What is important is that you have a `Makefile`
that contains the name of the project (for example `libft`), or the expected delivery files. 
If there is no `Makefile` or delivery files are not present `francinette` will not know 
what project to execute.

```
~ $> francinette git@repo42.com/intra-uuid-234
```

This command clones the git repository present in `git@repo42.com/intra-uuid-234` into the
current folder and executes the corresponding tests

> [!Warning]
> this is subject to change in order not to polute the user's home.

All the files are copied to the folder `~/francinette/temp/<project>`. In here is where the
norminette is checked, the code compiled and the tests executed. Normally you do not need to
access this directory for anything. But if you run into unexpected problems, this is where
the magic happens.

Log files can be found in: `~/francinette/logs`


## Uninstall

assuming default installation path, the following will effectively uninstall francinette.
```sh
cd $HOME/.local/
[ -e bin ] && rm -rf ./bin/francinette
[ -e opt ] && rm -rf ./opt/francinette
```

depending on whether you decided to grant the installation script this privilege or not,
it is possible for your .*rc to have had a PATH export appended to it.
contrary to upstream, no aliases are created, as entry points in `~/.local/bin/` are preferred ;
namely, `francinette`, and potentially, `paco`.


## FAQ

If you have any questions you can create an issue or reach me on slack under `fsoares-`

consider bothering me for issues related to this fork (login : `jmaxwell`)

#### I'm more advanced than the tests you have available. When are you adding more tests?

When I reach that exercise or project. You can also add them. For that you need to create a
`ProjectTester.py` file. and change the function `guess_project` in `main.py` to recognize
the project.

#### This test that you put up is incorrect!

Please create a new github issue, indicating for what exercise which test fails, and a
description of what you think is wrong. You can also try to fix it and create a pull request
for that change!

#### What is NULL_CHECK in strict?

This is a way to test if you are protecting your `malloc` calls. This means that it will make
every call to `malloc` fail and return `NULL` instead of a newly allocated pointer. You need
to take this into account when programming so that you don't get segmentation faults.

#### The tester for get_next_line is giving me Timeout errors

This is something that is very common. My tester will get slower for every malloc that you do, so if
you do a lot of mallocs it will probably timeout.

If it timeouts while in the strict mode, don't worry, this one is very very inefficient. I have
plans to change some things to not make it so horrible, but for the time being, don't worry if
it gives a Timeout.

## Troubleshooting

#### I've installed francinette, but when I try to execute it I get the message: `command not found: francinette`

it is likely that the entry points directory may not be present in your PATH variable.
consider the following options :

##### running the installer again
copy the bootstrapper link at [Install](#install) and input 'Y' when prompted for whether to add `~/.local/bin/` to the path (which will essentially run the line below, appending a PATH redefinition to your *.rc)

##### adding it manually
```sh
echo 'export PATH=$PATH:'"$HOME"'/.local/bin/' >> $HOME/.${SHELL##/bin/}rc
```

## Acknowledgments

* To 42 for providing me this opportunity (ditto)
* to [Xicodomingues](https://github.com/xicodomingues) for [Francinette](https://github.com/xicodomingues/francinette)
* To [Tripouille](https://github.com/Tripouille) for [libftTester](https://github.com/Tripouille/libftTester)[gnlTester](https://github.com/Tripouille/gnlTester) and [printfTester](https://github.com/Tripouille/printfTester)
* To [jtoty](https://github.com/jtoty) and [y3ll0w42](https://github.com/y3ll0w42) for [libft-war-machine](https://github.com/y3ll0w42/libft-war-machine)
* To [alelievr](https://github.com/alelievr) for [libft-unit-test](https://github.com/alelievr/libft-unit-test) and [printf-unit-test](https://github.com/alelievr/printf-unit-test)
* To [cacharle](https://github.com/cacharle) for [ft_printf_test](https://github.com/cacharle/ft_printf_test)
* To [ombhd](https://github.com/ombhd) for [Cleaner_42](https://github.com/ombhd/Cleaner_42)
* To [arsalas](https://github.com/arsalas) for the help in the minitalk tester
* To [vfurmane](https://github.com/vfurmane) for [pipex-tester](https://github.com/vfurmane/pipex-tester)
* To [gmarcha](https://github.com/gmarcha) for [pipexMedic](https://github.com/gmarcha/pipexMedic)
