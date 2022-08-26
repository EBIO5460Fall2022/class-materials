# Take control of your GitHub repo for this class

I have set up a GitHub repo for you that is within the private GitHub space for this class. This repo is not public (i.e. not open to the world). You and I both have write access to this repo. To take control of your repo, you will clone it to your computer using RStudio.

1. Go to the class GitHub organization. From your GitHub profile page, look to the left for organizations. The organization name is EBIO5460Fall2022. Or directly, the URL is https://github.com/EBIO5460Fall2022.
2. Find your repo. It is called ds4b_firstnamelastinitial.
3. From the green `Code` button in your repo, copy its URL to the clipboard.
4. Clone it to an RStudio project on your computer, as you did in the Git setup tutorial, following the directions at [Happy Git with R Chapter 12](http://happygitwithr.com/rstudio-git-github.html), section 12.3.

You are now ready to organize and develop your class materials in your repository, which is now also a directory (folder) on your computer, and an RStudio project. In the directory you just created, you will find three files.

1. A file with extension `.Rproj`. This file was created by RStudio. To open your project in RStudio, double click the file's icon. When RStudio opens, you will be in the working directory for the project. There is no need to use `setwd()` in case that is something you have got used to doing in the past. Don't use `setwd()` because that will break any code you share with someone else.
2. `README.md`. This file was created by GitHub. This is a plain text file with extension `.md`, indicating that it is a file in Markdown format. We will learn more about Markdown soon. The `README.md` file will be where you begin documenting your repository and will become a guide to files and further documentation. The contents of this file are displayed, nicely formatted, on the home page of your GitHub repo. You can edit this file using a text editor.
3. `.gitignore`. This file was created by RStudio but it is a file used by Git. This file tells Git which files or types of files to ignore in your repository (i.e. files that will not be under version control). By default, RStudio tells Git to ignore several files including `.Rhistory` and `.Rdata` because it usually doesn't make sense to track these temporary files. You can use a text editor to add other files to `.gitignore`.