원본 링크: https://subscription.packtpub.com/book/virtualization-and-cloud/9781789538830/2
Path:
packtpub/bashQuickStartGuide/103
Title:
103 Bash Command Structure
Short Description:
Bash Command Structure 명령어 구조

마크다운 입력시 vi 커맨드 ; ^{=Ctrl+[ ; ^M=Ctrl+M
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 ` 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
인용구 작성시, 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------


# Bash Command Structure

In this chapter, we'll learn the structure of a simple Bash command line, and the basics of quoting. You should read this chapter all the way through, paying careful attention especially to the material on quoting, even if you feel you already know how Bash commands work.

In this chapter, you will learn the following:

- How to use Bash interactively
- The structure of simple commands
- How to quote data safely
- How to run several commands with one command line
- How to make a command line stop if a command fails
- How to run a command in the background

# Using Bash interactively

If Bash is your login shell, and you log in to the system from a terminal or terminal emulator, then it will start in interactive mode. In this mode, Bash will present a prompt when it's ready to accept a command from your terminal. This differs from non-interactive or batch mode, where commands are read from some other source, such as a script file. We will use interactive mode in this chapter to experiment with the basics of shell script command line grammar.

Nearly all of the features available to Bash in scripts are also available on the interactive command line, and they behave essentially the same way as if you ran them from a script. This allows you to treat the interactive command line as a live scripting environment: you can assign variables, create functions, and manage control flow and processes.

# Interactive key bindings

In this book, we won't focus too much on the interactive keyboard shortcuts in Bash. This is because it's more useful to know the syntax of the shell scripting language than it is to know key bindings.

To read more about Bash key bindings, after you have finished this book, consult the Bash manual under the READLINE section, and the GNU Readline manual:

```
$ man bash
$ man 3 readline
```

# Simple commands

At an interactive Bash prompt, you can enter a command line for Bash to execute. Most often while in interactive mode, you would issue only one simple command at a time, ending each command with `Enter` . You would then wait for each command to finish before entering the next one, examining any output or errors that it passes to your terminal after each command.

A simple command consists of at least a command name, possibly with one or more arguments, each separated by at least one space. The full definition can also include environment variable assignments and redirection operators, which we'll explore in later chapters.

Let's consider the following command:

```
$ mkdir -p New/bash
```

This simple command consists of three shell words:

- `mkdir` : The command name, referring to the mkdir program that creates a directory
- `-p` : An option string for `mkdir` that specifies that the full directory path can be created, whether or not any of the directories in the path already exist
- `New/bash` : The relative path for the directory to create

Note that `-p` is not a special word or syntax to Bash; it's special to `mkdir` . Bash simply passes it to `mkdir` as an argument. The meaning of command options is a property of the commands themselves, not the shell from which they're called.

# Shell metacharacters

So far, all of our examples of commands and arguments have been single unquoted shell words. However, there is a set of **metacharacters** that have a different meaning to Bash, and trying to use them as part of a word causes problems.

For example, suppose you want to create ( `touch` ) a new file named `important file` . Note that there's a space in the name. If you try to create it as follows, you get unexpected results:

```
$ touch important file
```

If we list the files in the directory after running this, using `ls -1` to put all the names on separate lines, we can see we've actually created two files; one named `important` , and one named `file` :

```
$ ls -1
file
important
```

This happened because the space between the two words separated them into two separate arguments. Space, tab, and newline are all metacharacters. So are `|` (pipe), `&` (ampersand), `;` (semicolon), `(` and `)` (parentheses), and `<` and `>` (angle brackets).

> There are many other characters interpreted specially by Bash in some contexts, including {, [, *, and $, but these are not considered metacharacters according to the manual page's definition.
{.is-success}

Even the error messages can be confusing if you try to use a word with one of these characters in it:

```
$ touch Testfile<Tom>.doc
bash: Tom: No such file or directory

$ touch Review;Final.doc
bash: Final.doc: command not found
```

In some cases, you may not get an error message at all, and something very unexpected will happen instead; for example:

```
$ touch $$$Money.doc
$ ls
31649.doc
```

A lot of the time we can simply work with files and words that don't use these characters. However, we can't always do that, and we can't just hope others behave the same way—we will eventually have to work with their files and data. How can we include special characters in our words safely?

# Quoting

The way you can reliably include characters that are special to Bash literally in a command line is to quote them. Quoting special characters makes Bash ignore any special meaning they may otherwise have to the shell, and instead use them as plain characters, like a-z or 0-9. This works for almost any special character.

> We say "almost", because there's one exception: there's no way to escape the null character (ASCII NUL, `0x00` ) in a shell word.
{.is-info}

Quoting is the most important thing that even experienced people who write shell script sometimes get wrong. Even a lot of very popular documentation online fails to quote correctly in example scripts! If you learn to quote correctly, you will save yourself a lot of trouble down the line. The way quoting in shell script works very often surprises people coming from other programming languages.

We will look at three kinds of quoting: escaping, single-quoting, and double-quoting.

# Escaping

Using escaping with backslashes, the examples from the previous section can be correctly written like this:

```
$ touch important\ files
$ touch Testfile\<Tom\>.doc
$ touch Review\;Final.doc
$ touch \$\$\$Money.doc
```

A backslash can escape another backslash, too:

```
$ echo \\backslash\\
\backslash\
```

However, it can't escape a newline within a word:

```
$ echo backslash\
> foo\
> bar
backslashfoobar
```

# Single quotes

Using single quotes, we could write the commands like this, which is perhaps more readable than the backslashes version, and creates files with identical names:

```
$ touch 'important files'
$ touch 'Testfile<Tom>.doc'
$ touch 'Review;Final.doc'
$ touch '$$$Money.doc'
```

Unlike backslashes, single quotes can escape a newline in a word:

```
$ echo 'quotes
> foo
> bar'
quotes
foo
bar
```

How do we use a single quote (') as a literal character between two single quotes? If you are coming to Bash from a language such as Perl or PHP, you might try it like this, with a backslash, but that doesn't work:

```
$ echo 'It\'s today'
>
```

This is because backslash is not treated specially within single quotes. Doubling the single quote doesn't work, either:

```
$ echo 'It''s today'
Its today
```

In this case, Bash just sees two single-quoted strings, It and s today, and pushes them together as one word. The way to do it is to use a backslash outside of the single quotes:

```
$ echo 'It'\''s today'
It's today
```

# Double quotes

Double quotes behave similarly to single quotes, but they perform certain kinds of expansion within them, for shell variables and substitutions. This can be used to include the value of a variable as part of a literal string:

```
$ echo "This is my login shell: $SHELL"
This is my login shell: /bin/bash
```

Compare this to the literal output of single quotes:

```
$ echo 'This is my login shell: $SHELL'
This is my login shell: $SHELL
```

Other kinds of parameter expansion within double quotes are possible, which we will examine in later chapters.

You can include a literal dollar sign or backslash in a string by escaping it:

```
$ echo "Not a variable: \$total"
Not a variable: $total
$ echo "Back\\to\\back\\slashes"
Back\to\back\slashes
```

Exclamation marks are a special case, due to `history expansion`; you will generally need to quote them with a backslash or single quotes instead of double quotes:

```
$ echo "Hello $USER"'!!'
Hello bashuser!!
```

For historical reasons, you will also need to escape backtick characters (` \` `):

```
$ echo "Backticks: \`\`\`"
Backticks: ```
```

# Quote concatenation

You may have noticed from the examples in the previous section that you can put different types of quoting together in the same word, as long as they can never separated by an unquoted space:

```
$ echo Hello,\ "$USER"'! Welcome to '"$HOSTNAME"'!'
Hello, bashuser! Welcome to bashdemo!
```

In Bash, there's no concatenation operator like Perl or PHP's dot (' . '); to concatenate strings, you just put them next to each other. This can be a good idea if you have a mix of literal strings and variables in a single shell word, as it can help you avoid getting caught out by a stray dollar sign, backtick, exclamation mark, or backslash within double-quote pairs.

Running commands in sequence
You can send an interactive command line with more than one simple command in it, separating them with a semicolon, one of several possible `control operators`. Bash will then execute the commands in sequence, waiting for each simple command to finish before it starts the next one. For example, we could write the following command line and issue it in an interactive Bash session:

```
$ cd ; ls -a ; mkdir New
```

> Running `cd` on its own like this, with no directory target argument, is a shortcut to take you to your home directory. It's the same as typing `cd ~` or `cd -- "$HOME"`.
{.is_info}

For this command line, note that even if one of the commands fails, Bash will still keep running the next command. To demonstrate this, we can write a command line to include a command that we expect to fail, such as the `rmdir` call here:

```
$ cd ; rmdir ~/nonexistent ; echo 'Hello'
rmdir: failed to remove '/home/bashuser/nonexistent': No such file or directory
Hello
```

Note that the `echo` command still runs, even though the `rmdir` command before it did not succeed. If you want your set of commands to stop if one of them fails, separating them with semicolons is the wrong choice.

# Exit values

We can tell it was the `rmdir` command in the previous section that failed, because `rmdir` is the first word of the error message output. We can test the command in isolation, and look at the value of the special `$?` parameter with `echo` , to see its **exit status**:

```
$ rmdir ~/nonexistent
rmdir: failed to remove '/home/bashuser/nonexistent': No such file or directory
$ echo $?
1
```

The `rmdir` program returned an exit value of `1` , because it could not delete a directory that didn't exist. If we create a directory first, and then remove it, both commands succeed, and the value of `$?` for both steps is `0` :

```
$ mkdir ~/existent
$ echo $?
0
$ rmdir ~/existent
$ echo $?
0
```

Examining the exit values for the `true` and `false` built-in Bash commands is instructive; `true` always succeeds, and `false` always fails:

```
$ true ; echo $?
0
$ false ; echo $?
1
```

Bash will also raise an exit status of `127` for you if it can't find a way to run a command you request, such as `notacommand` :

```
$ notacommand ; echo $?
bash: notacommand: command not found
127
```

It's standard for programs to return 0 when they succeed, and something greater than 0 if they fail. Beyond that, programs vary in which exit values they choose for error conditions.

# Stopping a command list on error

Most of the time when programming in Bash, you will not actually want to test `$?` directly, but instead test it implicitly as success or failure, with language features in Bash itself.

If you wanted to issue a set of commands on one command line, but only to continue if every command worked, you would use the double-ampersand ( `&&` ) control operator, instead of the semicolon ( ' ; ' ):

```
$ cd && rmdir ~/nonexistent && ls
```

When we run this command line, we see that the final `ls` never runs, because the `rmdir` command before it failed:

```
rmdir: failed to remove '/home/user/nonexistent': No such file or directory
```

Similarly, if we changed the `cd` command at the start of the command line to change into a directory that didn't exist, the command line would stop even earlier:

```
bash$ cd ~/nonexistent && rmdir ~/nonexistent && ls
bash: cd: /home/bashuser/nonexistent: No such file or directory
```

In **Chapter 6**, Loops and Conditionals, we'll explore more fully Bash's options for control flow, including using the `||` command separator, and using the `if` command to execute blocks of code conditional on a test outcome.

# Running a command in the background

There are some situations in which you might want to continue running other commands as you wait for another one to complete, to run more than one job in parallel. You can arrange for a command to run in the background by ending it with a single ampersand (` & `) control operator.

You can try this out by issuing a `sleep` command in the background. The `sleep` built-in Bash command accepts a number of seconds to wait as an argument. If you enter such a command without the `&` , Bash won't accept further commands until the command exits:

```
$ sleep 10
# Ten seconds pass...
$
```

However, if you add the `&` terminator to start the job in the background, the behavior is different: you get a job control number and a process ID, and you are returned immediately to your prompt:

```
$ sleep 10 &
[1] 435
$
```

You can continue running other commands as normal while this job is running in the background. After the 10 seconds are up, the next time the prompt appears, it will also print output telling you the job has completed:

```
[1]+  Done                    sleep 10
$
```

# Summary

Even if you feel that you already know the basic structure of a Bash command well, carefully looking at the structure of a typical command line and knowing the rules of string quoting can make it much clearer what's wrong when something doesn't behave as expected. We use single quotes to keep characters literal, and double quotes to safely perform expansion for variables and substitutions. Developing disciplined habits with quoting and understanding how Bash runs commands in sequence is helpful not just for scripting, but for interactive command line work as well.

Having learned the structure of a Bash command line, in the next chapter we'll apply it to learning some essential commands that will form the basis of many shell scripts.

