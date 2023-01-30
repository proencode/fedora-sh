원본 링크: https://subscription.packtpub.com/book/virtualization-and-cloud/9781789538830/1
Path:
packtpub/bashQuickStartGuide/101
Title:
101 Preface
Short Description:
Bash Quick Start Guide 머리말

마크다운 입력시 vi 커맨드 ; ^{=Ctrl+[ ; ^M=Ctrl+M
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 ` 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
인용구 작성시, 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

![Figure6.13-solution is to use a BuildContext ](/flutter_cookbook_img/figure6.13-solution_is_to_use_a_buildcontext.webp)

---------- cut line ----------


# What is Bash?

Bash's full name is the GNU **Bourne Again Shell**. It is a programming language, specifically a shell scripting language, with an interpreter in a program named `bash`. It was created by Brian Fox of the Free Software Foundation, starting in 1989, and is now maintained by Chet Ramey. It is part of the GNU project for a free software operating system.

The `bash` program is used as a shell: either for entering commands as an interactive shell using a command line, batches of commands from a shell script, or a single command from an option.

In this book, we will refer to Bash as the software distribution and the programming language, and to `bash` as its interpreter program.

Bash is a Bourne-style shell, with some support for POSIX shell compatibility. It is not compatible with any kind of C-style shell, such as `tcsh`.

Bash has many general programming language facilities that make it usable for general programming tasks, but like most shell scripting languages, its fundamental design is to run other programs in a control structure, and to make them work together in ways suitable to the programmer, whether or not they were designed to do so. This is the main thing that makes shell scripting powerful and useful.

In this chapter, you will learn:

- What Bash is and is not
- How to install and switch to Bash
- How to check you are running a recent version of Bash
- How the POSIX standard applies to Bash
- The two major categories of Bash features
- Programming tasks for which Bash is and is not well-suited
- How to get help while using Bash

# What Bash is and is not

On reading the preceding definition, you may have noticed a few things you might have expected are missing. There is a lot of confusion out there about what Bash is and is not. Here are some common misconceptions:

- Bash is not (necessarily) part of Linux. They are separate pieces of software. GNU Bash existed for several years before the Linux kernel was created, and runs on other operating systems too.
- Bash is not the same thing as SSH. SSH is a service and network protocol for running commands on remote computers. `bash` can be one such command.
- Bash is also not your terminal or TTY. Your terminal is a device for sending information to, and receiving information from, a computer. Terminals used to be hardware devices with a monitor and keyboard. Nowadays, for most users, they are **terminal emulators**, or software devices. Bash is a program that runs using your terminal for its input and output.
- Similarly, Bash is not the same thing as PuTTY, iTerm, or xterm. These are terminal emulators, not shells. Your terminal emulator is a program that understands and interprets text-based programs. Bash is one such program.
- Bash is not the command line, in the strictest sense. Bash has an interactive mode, which is an example of a command line, but many other tools have command lines, and not just system shells. The `bc` calculator tool is an example of another tool with a command line.

Now that you know this, if someone ever asks you for a PuTTY account on your server, make sure to set them straight!

# Getting Bash

If you are running a GNU/Linux system, you almost certainly already have access to Bash. It is installed by default on almost every GNU/Linux computer system.

On such systems, it is very often the default login shell for users. This means that when a new user logs in for the first time, it's the first interactive program that runs, and it starts up to wait for command input from the user.

On some systems, such as Debian GNU/Linux, Bash will be the default login shell for non-system users, usually human beings rather than system processes, but a different shell, such as the POSIX shell or Bourne shell, will be used for system accounts.

Bash can be installed on other Unix-like systems as well, such as on FreeBSD, NetBSD, OpenBSD, or proprietary versions of Unix. Even though Bash has such a strong history with GNU/Linux systems, administrators of these other systems often end up installing it, because it is so popular and many users will expect to be able to use it as their shell. It usually has to be installed as a separate package, and is not part of the default installation.

You can also build Bash from source on most Unix-like systems with access to a **C compiler**. Doing this is outside the scope of this book, and you should use your system's packages or ports system if you can. The Bash source code is available at https://www.gnu.org/software/bash/.

# Checking Bash is running

If you're using a GNU/Linux system, and your system administrator hasn't changed your login shell, it's likely that Bash is starting up as soon as you log in with a TTY, in an `xterm`, or over SSH.

If you see a prompt that looks like one of these after you log in, it's a good sign you're in a `bash` session:

```
bash-4.4$
user@hostname:~$
```

If you want to check, you can enter this at the prompt:

```
bash$ declare -p BASH
```

If you get a response like this, with a path to your `bash` binary, you can be confident you are running `bash`:

```
declare -- BASH="/bin/bash"
```

If you get some other output, such as:

```
sh: declare: not found
```

Then you may be running some other kind of shell. You may be able to tell what it is by printing the value of the `SHELL` variable:

```
$ echo "$SHELL"
```

We'll use the `bash$` prefix before commands throughout this book as a way to show commands you should enter at the Bash command line. We'll use just a `$` prefix instead if the command should also work in other POSIX-compliant shells.

# Switching the login shell to Bash

Even if it's not the shell that starts up when you log in, Bash may still be installed on your system, and you may still be able to change your login shell to it.

You might be able to start it by just typing `bash`:

```
$ bash
```

If you get output like `command not found`, you will probably need to install a Bash package specific to your system, or get your system administrator to do it for you. Consult your operating system's documentation to learn how to do this.

If you get a new prompt that looks like the Bash prompts in the previous section, you can then find the location of the `bash` program:

```
bash$ declare -p BASH
BASH="/usr/local/bin/bash"
```

Depending on the system, you might then be able to change Bash to your login shell to that path with the `chsh` tool:

```
$ chsh -s /usr/local/bin/bash
```

This might prompt you for your system password to allow you to make the change.

You may get an error message like this:

```
chsh: /usr/local/bin/bash is an invalid shell
```

In this case, the `invalid shell` part likely means that the path given needs to be added to the `/etc/shells` file, which specifies the programs the system and its administrator have allowed as login shells. You can inspect this list with `cat`:

```
$ cat /etc/shells
```

If you add your full path to `bash` on your system to that file, the `chsh` call should then succeed.

# Identifying the Bash version number

Before we start writing commands and programming with Bash, it's a good idea to find out what version of Bash you have installed. This is because newer versions of Bash have useful new features that might be discussed in this book, but that might not be available in your version of Bash.

You can check the version of your current running shell by printing the value of the `BASH_VERSION` variable:

```
bash$ declare -p BASH_VERSION
declare -- BASH_VERSION="4.4.12(1)-release"
```

You can get the same information by invoking the `bash` program with its `--version` option, which provides some extra information about the program's version number and software license:

```
$ bash --version
GNU bash, version 4.4.12(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2016 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

The most recent stable minor version of GNU Bash at the time of writing is version 4.4, with version 4.4.0 released in September 2016.

In this book, we will focus on the features of Bash that were available in GNU Bash version 4.0, which was released in 2011, and is very widely available as a minimum version.

If the version of Bash installed on your computer is older than 4.0, some of the scripts and features discussed in this book may not work correctly. You or your system administrator should use your operating system to upgrade your Bash shell to a newer version.

# Upgrading Bash on macOS X

There is a special case of Bash versions for macOS X. If you are using Bash on OS X, you might notice that the version of Bash installed by default is much older than the minimum of 4.0 discussed in this book:

```
bash$ declare -p BASH_VERSION
declare -- BASH_VERSION="3.2.57(1)-release"
```

This is due to licensing changes in Bash 4.0 that were not acceptable to the operating system vendor, which leaves the version of Bash included on the system stuck at the last acceptable version. This means that, by default, your system may not have Bash 4.0 or newer, even if the system is brand new.

Fortunately, there are other ways to install Bash 4.0 or newer on a macOS X computer. One popular method is to use the Homebrew package-management system, available here: http://brew.sh/.

Follow the instructions on the Homebrew website to install it. You can then install a new version of Bash with:

```
$ brew install bash
```

You may have to include the newly-installed Bash path in the allowed list of login shells in `/etc/shells` before you can apply `chsh` to change your login shell. You may also have to adjust your terminal emulator (e.g. iTerm) to run the new version of Bash. Consult your operating system and terminal emulator documentation to learn how to do this.

# Understanding Bash features

Some of Bash's programming features are shared by all other Bourne-style, POSIX-compatible Shell scripting languages. These are specified by the POSIX standard, in section 2, Shell Command Language. Bash is designed to conform to this standard. You can read what it specifies at http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html.

Bash also has many other features that are not described in the POSIX shell script standard that make many common shell script programming tasks easier. In this book, we will examine both categories.

# POSIX shell script features

Features required for the POSIX shell script include:

- **Running commands** convenient syntax for **running commands**, including other programs, specifying arguments, environment variables, working directories, permissions masking, and other properties.
- **Variables** that can be set to any string value, including manipulating process environment variables, and that can be expanded on the command line.
- **Arithmetic expansion** for performing integer-based arithmetic on variables and numbers.
- **Control structures** for executing code depending on the outcome of another command (if), including a specially-designed test or [ command, and repeating code until a condition is true (while).
- **Aliases** as a way to abbreviate long command lines as a single word for convenience.
- **Functions** to allow defining blocks of code as new commands for the purposes of the running script or interactive session.
- **Input and output redirection** to specify input sources and output destinations for programs run in the shell.
- **Pipes** to direct the output of one command to become the input of another.
- **Argument list** through which code can iterate using a for loop.
- **Parameter expansion** a means of switching between or transforming string values in assignments or command arguments.
- **Pattern matching** in the form of classic Unix **globs**.
- **Process management** in running jobs in the background, and waiting for them to complete at the desired point.
- **Compound commands** to treat a group of commands as one, optionally running it in a **subshell environment** (subprocess).
- **Reading lines of input data** including breaking them down into fields with a defined separator character.
- **Formatted strings** such as the C `printf(3)` function in the `stdio` C programming language library.
- **Command substitution** to use the output of a command as a variable, as part of a test, or as an argument to another command.

These features are either part of the Shell scripting language itself, or available in the POSIX-specified programs that it calls. In a sense, your shell scripts are only limited by the programs you can run with them.

By calling the grep program, for example, you can select input lines using **regular expressions**, even if your Shell scripting language does not itself support regular expressions. We will cover some of these essential commands in this book, even though they are not technically part of the GNU Bash distribution.

All the these features mean you can get a lot done in your Bash program even if you just use POSIX features, and your script might then run on other shells, such as dash, without much modification. All of the features are discussed in this book.

# Bash-specific features

In addition to all the POSIX shell script features in the previous section, Bash adds many extensions that make programming more convenient, expressive, and sometimes less error-prone. These include:

- Named **array** variables. This is perhaps the most important advantage over the plain POSIX shell script. It makes many otherwise impractical things possible. If you need one single reason to use Bash, this is probably it!
- An easier syntax for performing conditional tests. This is also a very important feature.
- **Extended globs** for advanced pattern-matching.
- **Regular expression** support, for performing the most powerful kind of text-pattern-matching, when even globs won't do.
- **Local variables** for functions, a limited kind of variable scope.
- A **C-style** `for` **loop syntax**.
- Several kinds of **parameter expansion**, including case transformation, array slices, substrings, substitution, and quoting.
- Arithmetic expressions, for conveniently testing the outcome of arithmetic operations.
- Many more shell options to control shell script and interactive shell behavior, including extra debugging support.
- Better support for **irregular filenames** and **unusual line separators** in data.

All of these features are also discussed in this book. Where relevant, we will specify which features are POSIX-specific and which features are specific to Bash.

# Do I need Bash?

If you know you will have Bash available on the systems where your shell script will run, you should use it! Its features make programming in shell script easier and safer, and it is by far the most popular kind of shell script, with many people reading and writing it. Many people think that Bash is the only kind of shell script.

Even if your shell script is simple today, you might need to add more to it tomorrow, and a Bash feature might be exactly the thing you need at that time.

However, if your shell script might need to run on a system where Bash may not be installed and cannot be installed for your script, then you may need to limit yourself to the POSIX shell features. Check your system's documentation to determine what style of shell script you will have to write in order for your script to run.

# Choosing when to apply Bash

There are some tasks for which shell scripting in general, and Bash in particular, are especially well-suited:

-  **Prototyping**: Short Bash programs are quick and easy to write. It's quite common to "hack together" a simple script in Bash for later replacement by a script or program in a more advanced programming language that requires more effort to write and maintain.
-  **Interactive system administration**: A Bourne-style shell is assumed in very many contexts in Unix, and almost all of the system documentation you read will tell you to issue commands in a Bourne-style shell. This makes it a natural choice for a scripting language.
-  **Automation**: If you have a set of commands you often run together, making a script for them is as simple as writing them all into a text file, each on a new line, and making that file executable.
-  **Connecting programs together**: Like all Shell scripting languages, Bash specializes in moving data to and from files and between processes. Many programs are designed to work together in this way.
-  **Filtering and transforming text input**: Some programs, however, aren't designed to cooperate in this way, and they require some data **filtering and transformation** in the middle. Bash can be a very convenient language for doing this, and it's also a good language to call other tools such as `awk` or `sed` to do it for you.
-  **Navigating the Unix filesystem**: In Bash, it does not require much code to navigate and iterate through the filesystem, discovering, filtering, and processing files within it at runtime. Coupled with the `find` tool, especially a high-powered version such as GNU `find` , a lot can be done in a pattern over a filesystem with relatively little code.
-  **Basic pattern-matching on strings**: Bash has features that make it good for basic pattern-matching on strings, especially filenames and path names, with **parameter expansion**.
-  **Portability**: Bash works on and is packaged for a huge variety of Unix-like systems. POSIX shell script is even more widely supported. If you need to know your script and its runtime will remain portable to many Unix-like systems, Bash might be a good choice.

# Choosing when to avoid Bash

Bash's design and development effort is less focussed on some other areas. New users who are keen to use Bash often find tasks that require the following to be difficult or impossible in the Bash language itself:

-  **Programs requiring speed**: The end of the Bash manual page, under the "BUGS" section, reads: It's too big and too slow. This may seem like a joke, but while a compiled `bash` binary is unlikely to be more than a couple of megabytes in size, it is not optimized for speed. Depending on the task, reading a very large file line by line in Bash and processing data within it with string operations is likely to be significantly slower than using a tool such as `sed` or `awk`.
-  **Fixed or floating-point math**: Bash has no built-in support for fixed or floating-point mathematical operations. It can call programs such as `awk` or `bc` to do such things on its behalf, but if you need to do a lot of this, you might want to just write the whole program in AWK, or maybe in Perl instead.
-  **Long or complex programs**: The ideal Bash program is short and sweet – less than 100 lines of code is ideal. Bash programs much longer than this can rapidly become unmanageable. This is partly a consequence of the terse syntax, and partly because the complexity of a script increases faster when much of the work is invoking other programs, as shell scripts tend to do.
-  **Serialization**: Bash has no native support for serialized data formats such as JSON, XML, or YAML. Again, this is best delegated to third-party tools such as `jq` or `xmlstar` , which Bash can call from within scripts. Trying to do this in just Bash is an exercise in frustration for newer programmers.
-  **Network programming**: Bash does have some support for network programming on some systems, but it does not allow much fine-grained control. It mostly has to lean on external tools such as `netcat` or `curl` to do this.
-  **Object-oriented programming**: Object-oriented programming is not practical in Bash. It does not have any concept of a namespace or classes, a system of modules to separate code, nor any object system.
-  **Functional programming**: Bash's language design means it does not have any of the primitives that users of functional languages, such as Lisp, Scheme, or Haskell, might expect from a language. It has very limited support for lexical scope, read-only data, indirection (references), or data structures more complex than arrays. It has no support for closures or related features.
- **Concurrent programming**: Bash generally just runs commands in sequence. It's possible to run processes in parallel, and to simulate basic concurrency concepts such as locks, but a programming language built with concurrency in mind may be a better choice for tasks requiring multithreading or parallel processing.

# Getting help with Bash

Sometimes in technical books, people skip the Getting help heading. Don't skip this one! It's very important, and will save you a lot of time and confusion.

You can get help on using most of the commands in this book with a two-step process. When you're using Bash, to get help on a command named `printf` , use `help` first:

```
bash$ help printf
```

You'll get some help output, so you now know that `printf` is a Bash keyword or builtin. That's the version of the command you want help with, because that's the one that you'll be using when you call it from within Bash.

To see why this is confusing, try the `man` manual reader command, instead:

```
bash$ man printf
```

You'll get a completely different document, a full manual page! The features aren't even the same! What's going on?

In a shell script, the same command can have more than one implementation. In Bash, you can see a list of all of them using the `type` command with its `-a` (all) switch:

```
bash$ type -a printf
printf is a shell builtin
printf is /usr/bin/printf
```

Notice how there are two results for `printf` : the first is a shell builtin – a part of Bash itself – and the second is a program on your filesystem. They will behave differently and have different documentation. We'll see more of the `type` command in later chapters.

So remember: always try `help` first! Some people use Bash for many years before learning it exists, and wonder why the `man` pages are always wrong. You can see a full list of available `help` topics by typing it on its own, with no arguments:

```
bash$ help
```

# Summary

Effective Bash programming begins with a good understanding of what Bash actually is, and how it fits into your system. It's useful to know which features are in Bash because they implement the POSIX standard for shell scripting, and which features are specific to Bash, especially because it will help you decide on the portability of your shell script. It's also very relevant for deciding whether Bash is the right tool for any given job.
