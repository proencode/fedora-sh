원본 링크: https://subscription.packtpub.com/book/virtualization-and-cloud/9781789538830/pref
Bash Quick Start Guide By Tom Ryder
Path:
packtpub/bashQuickStartGuide/100
Title:
100 Preface
Short Description:
Publication date: 9월 2018 Publisher Packt Pages 186 ISBN 9781789538830
Bash Quick Start Guide 머리말

마크다운 입력시 vi 커맨드 ; ^{=Ctrl+[ ; ^M=Ctrl+M
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 ` 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
인용구 작성시, 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------


# Preface

The GNU Bourne-Again Shell, or **Bash**, is the best-known Bourne-style shell in the world, and is installed or available for installation on a huge variety of Unix-like systems. Even professionals who don't do a lot of work with Unix or Linux will need to use the Bash shell occasionally.

Bash is a language of contradictions; while it's the best-known and most widely-deployed shell of its kind, it's perhaps also one of the least-understood tools, with a terse syntax that's relatively unique among modern programming languages and can seem bizarre even to experienced users. Bash is powerful in some ways, and very limited in others. It's clear, elegant, and expressive in some ways, and terse, clumsy, and bewildering in others.

Because it's so powerful and yet so complex, and because so many computer professionals can't avoid using it at least occasionally, Bash is often learned by way of a kind of "tradition;" demonstrations by experienced administrators, reading others' scripts, copying and pasting, and asking questions and reading answers on the internet. This leads to a lot of "cargo-cult programming," and a lot of bad practices that make things unnecessarily confusing at best, and downright dangerous at worst. The available documentation for Bash is often unhelpful in addressing this problem—it often teaches the same bad practices, and even when it's correct, as the official Bash manual page is, it's often too complicated and assumes too much knowledge for new users to understand it.

To avoid all that, we'll start learning good Bash from first principles, and focus almost exclusively on writing the language well, in both interactive and batch mode. By the end of this book, you'll have a firm grasp on how to write Bash shell script in a robust and understandable way, and be in a position to notice bad habits and dangerous "hot spots" in others' code. You'll have a great grasp on the problems for which shell script is a perfect solution, and writing it will be a lot more efficient, and maybe even fun.

# Who this book is for

This book is ideal for you if you have access to a computer with Bash installed or available, and you've maybe even used Bash or another Unix-like command shell before to enter at least a few basic commands, but you can't understand the official Bash manual page very well (or at all). You should not be ashamed of that; it's one of the most famously dense manual pages for software ever written! Some experience with basic programming structures such as variables, expressions, conditionals, and loops will help you understand the book—but Bash mostly has its own way of doing things that you need to learn from the ground up, so you don't need to be an expert in any given language.

Alternatively, you may be a more experienced systems administrator, or even an expert in another programming language, who has done a fair bit more than a beginner with shell script, but is still frustrated by the dark corners and difficulties in using it, and wants a course in "remedial shell script" to unlearn some bad habits. The book will clarify arcane and difficult syntax and patterns in shell programming. You'll become much more confident in using it in your work when the situation calls for it, and you'll be in a position to fix both your own and others' shell scripts, and even to train others on writing shell script effectively.

# What this book covers

`Chapter 1`, What is Bash?, opens the book by giving a clear definition of what the Bash shell actually is, where it fits in with other programs on a Unix system, and how to find and (if necessary) install it on your system.

`Chapter 2`, Bash Command Structure, looks at the anatomy of Bash command lines, starting with simple single commands and arguments, and moves on through running multiple commands, and good quoting practices for data.

`Chapter 3`, Essential Commands, examines a list of common commands useful in Bash command lines and scripts, explaining the situations in which each is useful and how to use them; listing, searching, sorting, and slicing data are all discussed.

`Chapter 4`, Input, Output, and Redirection, extends our new basic command structure knowledge to show how to specify where data for commands to read comes from, and where it goes to—including "piping" one command's output into another command, and filtering it in between.

`Chapter 5`, Variables and Patterns, explains and demonstrates how Bash's variable assignment and expansion works for both simple variables and arrays, how to transform strings conveniently with parameter expansion, and how to use patterns to match and specify lists of files.

`Chapter 6`, Loops and Conditionals, shows how to run the same set of commands on every item of a list of shell words or lines, and how to run commands only if a certain expression is true or false.

`Chapter 7`, Scripts, Functions, and Aliases, builds on our new knowledge of shell grammar and common commands to start writing your own commands, implemented in the Bash programming language and executable from anywhere on your computer.

`Chapter 8`, Best Practices, ends the book with some important hints, tips, and techniques for writing robust and readable shell script that will set you on the path to becoming a true shell scripting expert.

# To get the most out of this book

You should have access to a computer with Bash 4.0 or higher installed or available, and be able to type commands into it via a TTY, terminal emulator, Telnet, or SSH connection (for example, using PuTTY). This book does give some guidance in the first chapter on how to install Bash on your system if it's not already there, or if the installed version is too old (as may be the case on macOS X). You will need either administrative-level (root) access to the computer to install Bash yourself, or a cooperative systems administrator to help you.

If you are not sure which operating system to use, we recommend the Ubuntu distribution of GNU/Linux, available from https://www.ubuntu.com/. The LTS (Long Term Support) version will do fine. Ubuntu is open source, free to download, thoroughly documented, and relatively easy to install. You can run this operating system in a virtual machine using a program or hypervisor such as VMware or VirtualBox—it does not have to be installed directly on your computer's hardware.

At the time of writing, Windows 10 has a new Bash subsystem available and in active development, the Windows Subsystem for Linux. You may find that most of the material in this book is relevant and usable on such a system, but the book does not specifically support this, and we highly recommend installing a full GNU/Linux or BSD system for your learning and experiments instead.

# Download the example code files

You can download the example code files for this book from your account at www.packt.com. If you purchased this book elsewhere, you can visit www.packt.com/support and register to have the files emailed directly to you.

You can download the code files by following these steps:

1. Log in or register at www.packt.com.
1. Select the SUPPORT tab.
1. Click on Code Downloads & Errata.
1. Enter the name of the book in the Search box and follow the onscreen instructions.

Once the file is downloaded, please make sure that you unzip or extract the folder using the latest version of:

- WinRAR/7-Zip for Windows
- Zipeg/iZip/UnRarX for Mac
- 7-Zip/PeaZip for Linux

The code bundle for the book is also hosted on GitHub at https://github.com/PacktPublishing/Bash-Quick-Start-Guide. In case there's an update to the code, it will be updated on the existing GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Download the color images

We also provide a PDF file that has color images of the screenshots/diagrams used in this book. You can download it here: http://www.packtpub.com/sites/default/files/downloads/9781789538830_ColorImages.pdf.

# Conventions used

There are a number of text conventions used throughout this book.

`CodeInText` : Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: "Mount the downloaded `WebStorm-10*.dmg` disk image file as another disk in your system."

A block of code is set as follows:
```
#!/bin/bash
printf 'Starting script\n' >> log
printf 'Creating test directory\n' >> log
mkdir test || exit
printf 'Changing into test directory\n' >> log
cd test || exit
printf 'Writing current date\n' >> log
date > date || exit
```

Any command-line input or output is written as follows:
```
$ printf 'Hello, world\n' > myfile $ ls -l myfile -rw-r--r-- 1 bashuser bashuser 1 2018-07-29 20:53:23 myfile
```

*Bold*: Indicates a new term, an important word, or words that you see onscreen. For example, words in menus or dialog boxes appear in the text like this. Here is an example: "Select System info from the Administration panel."

> Warnings or important notes appear like this.
{.is_info}

> Tips and tricks appear like this.
{.is_success}

# Get in touch

Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, mention the book title in the subject of your message and email us at `customercare@packtpub.com`.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packt.com/submit-errata, selecting your book, clicking on the Errata Submission Form link, and entering the details.

**Piracy**: If you come across any illegal copies of our works in any form on the Internet, we would be grateful if you would provide us with the location address or website name. Please contact us at `copyright@packt.com` with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Reviews

Please leave a review. Once you have read and used this book, why not leave a review on the site that you purchased it from? Potential readers can then see and use your unbiased opinion to make purchase decisions, we at Packt can understand what you think about our products, and our authors can see your feedback on their book. Thank you!

For more information about Packt, please visit packt.com.
