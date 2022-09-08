# .gitignore
You might have noticed a file called `.gitignore` in my `class-materials` repository and in your personal `ds4b_yourname` repository. You might not see this file automatically on Mac or Linux because the preceding dot indicates that it is a hidden file. To see the file on Mac or Linux, use `ls -al` at the command line to list all files, including hidden files. You can also do this on Windows using the Git bash CLI. The `.gitignore` file specifies files or filetypes that you don't want to be under version control, i.e. not tracked by Git.
* Read the section in the Git Pro book on [Ignoring Files](https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository#_ignoring)
* Inspect [.gitignore](../.gitignore) in the class materials repository
* Inspect `.gitignore` in your `ds4b_yourname` repository



## Some questions
Should I track `.gitignore` itself?
* Yes, that's usually a good idea.

Should I ignore the RStudio project configuration file: `myprojectname.Rproj`?
* It depends. If the project is just for me, I will go ahead and track it. If it's a collaborative project I will add it to `.gitignore` because different people will likely want to set up their RStudio project in a way that suits them. I don't want to force my setup on others.
* Since I'm sharing the `class-materials` repository with you and I want you to be able to clone that repository to your computer and play with and modify it, I have added `class-materials.Rproj` to  the `.gitignore` file. Actually, I have added any file with a `.Rproj` extension by adding `*.Rproj`.

What files should I ignore?
* There are no rules - it's up to you.
* It's customary to ignore some types of derived files, such as intermediate results. For example, you'll see I am ignoring `*.Rdata`, which is a format I use to keep results from simulations that take longer than a minute or two to run.
* We often ignore datasets, especially large datasets. Best practice is not to edit datasets anyway, so there is no point in having them under version control. Nevertheless, for smaller datasets it is convenient to share them via GitHub.
* It's best to ignore large files in general (e.g. high res images, videos) since they will make pushing to and pulling from GitHub painfully slow.



## What if I don't yet have a .gitignore file?

You can copy another one to use as a template, or you can start a new blank file by opening the command line on Mac or Linux or the Git bash CLI on Windows and typing:

```bash
touch .gitignore
```

You can then edit it with any text editor.



## For you to do
Based on your reading and inspecting my `.gitignore` file, modify your `.gitignore` file to ignore files you don't want to have under version control. It's a plain text file so you can use your favorite text editor to edit it. **Push your changes to GitHub.**
