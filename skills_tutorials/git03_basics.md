# Git basics



## Initial reading

[Pro Git Chapter 1 Getting Started](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control)\
    1.1 About Version Control\
    1.2 A Short History of Git\
    1.3 What is Git?\
    1.4 The Command Line\
    1.7 Getting Help



## More setup

Before we go further we're going to change some default settings in Git. Open a terminal (Mac: open the terminal app; Windows: from the desktop or file explorer right click some open space > Git Bash here).

By default, Git starts a new repository with a branch named "master". To check how it's set, in the terminal type

```bash
git config --list
```

After some output has printed, if you see a blinking cursor by the symbol `:` you may need to press the spacebar to see the rest of the output and if you see the characters `(END)`, hit `q` to return to the command line. If you see `init.defaultbranch=main` in the printout, then you're good. If not, you can [change the default to the more inclusive](https://sfconservancy.org/news/2020/jun/23/gitbranchname/) name "main" following the convention adopted by GitHub in 2020. 

```bash
git config --global init.defaultBranch main
```

We'll also set the way that line endings are encoded. On Windows:

```bash
git config --global core.autocrlf true
```

or on MacOS and Linux:

```bash
git config --global core.autocrlf input
```

You can check the settings by running `git config --list` again.



## Tutorials at Software Carpentry

Do the first five tutorials at https://swcarpentry.github.io/git-novice/

1. Automated version control
2. Setting up Git (you can skip or skim this since we already set up Git)
3. Creating a repository
4. Tracking changes
5. Exploring history

Summary of the git commands covered:

Basic Git workflow:\
`git init` Creates a new Git repository.\
`git status` Inspects the contents of the working directory and staging area.\
`git add` Adds files from the working directory to the staging area.\
`git diff` Shows the difference between the working directory and the staging area.\
`git commit` Permanently stores file changes from the staging area in the repository.\
`git log` Shows a list of all previous commits.

How to Backtrack:\
`git checkout HEAD filename` Discards changes to a file in the working directory.\



## Post tutorial reading

[Pro Git Chapter 2 Git Basics](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)\
  2.1 Getting a Git Repository\
  2.2 Recording Changes to the Repository\
  2.3 Viewing the Commit History\
  2.4 Undoing Things



## If something goes terribly wrong

http://happygitwithr.com/burn.html
