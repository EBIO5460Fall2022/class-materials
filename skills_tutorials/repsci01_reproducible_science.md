# Reproducible workflows
Once you have finished an analysis, especially if it is one associated with a publication, you (probably) or someone else should be able to reproduce it and understand what you did, ideally many years or decades later. Equally, if you are returning to an unfinished analysis you'll need to reproduce what you've done so far. Many journals demand reproducibility of analyses through deposition of code along with data and this is likely to become more widespread in the future. Getting to an exactly reproducible analysis can be a challenge because technology and software changes over time, many modern computational approaches are stochastic, or complex computing infrastructure might be needed for your analysis. But there are seven simple principles that get us most of the way there.

1. Document everything.
2. Do everything using code.
3. Use open source software and file formats.
4. Organize files in one location.
5. Track changes to files.
6. Archive final working versions.
7. Backup all files.



## 1. Document everything
The role of documentation is obvious but it is perhaps the hardest to stay on top of. Documentation takes time and effort and is easy to neglect. Furthermore, it is easy to overlook the need for documentation when we're "in the zone" of a project because then it might seem obvious what we are doing and why we are doing it that way. Inevitably, what seemed obvious at the time is not obvious later. A good rule of thumb is thus to document the obvious. The main goal is to include enough documentation in our code and descriptive files that what we did and what we were thinking is clear.

Documentation includes metadata. A `readme.txt` or `about.txt` file (plain text `.txt` or markdown `.md` are good choices for file format) is typically the master metadata file and contains a guide to the project, file structure, and other metadata file locations. The main job of metadata is to document the provenance of data and especially to describe in detail each column or attribute of a data file, such as collection methods, definitions, units, precision, and taxonomic information. For data publication you can and should take this to another level of sophistication by creating standardized metadata. There are several templates for standardized metadata. The one that ecological data has coalesced around is Ecological Markup Language (EML). EML is based on and compatible with the Dublin Core metadata specification ([dublincore.org](dublincore.org)), which is a global standard for metadata of all kinds. The [Environmental Data Initiative](https://edirepository.org/) is a good source of information for [how to create metadata in EML format](https://edirepository.org/resources/creating-metadata-for-publication), including R and Python packages.



## 2. Do everything using code
Already, simply by writing code for the analysis, we are most of the way to a reproducible analysis. Code automatically documents the steps in data manipulation and analysis. It doesn't matter what language the code is or whether we use several languages in the same project. The key is to avoid doing things "by hand" as much as possible. Avoid menu-driven operations. Avoid cut and paste. Avoid intermediate steps that require hand-editing files. However, be sensible and practical. If something needs to be done by hand, document the steps in enough detail to reproduce them exactly.

### Acquiring data
A reproducible workflow starts with data entry and preparation. A strict approach would be to first record data in a master file or database, then keep the file unedited (perhaps set file permissions to read only) so that any changes, such as corrections and reorganization, result in derived data files via code. This is a good idea for automated data generation, like remote sensing, or electronic dataloggers, and online data repositories. However, in practice, large datasets collected by humans (such as paper datasheets from the field or lab) require editing to fix errors in individual entries (such as digital data entry errors, decimal points in the wrong place, transposition errors, species misidentifications, mislabelling etc) that become apparent through data validation and analysis. If there are more than a few errors (there are 1-5% errors in a typical dataset), fixing errors using code can be **more** error prone than directly editing the digital data. Coding errors can easily compound data entry errors. Furthermore, not fixing errors in data files can lead to future or parallel analyses using the uncorrected data and proliferation of different versions of "correction scripts" for different investigations, and depositing data in permanent repositories requires both the original **bad** data file, the cleaning script, and the **good** data file. An alternative approach is to place master data files under version control and keep a separate metadata document to record changes and their rationale if necessary. Once data are entered digitally, scan paper records for archiving.

If you use a spreadsheet program for data entry, such as MS Excel, avoid data manipulation within the spreadsheet such as calculations or sorting, which can be done in code instead. Sorting data in a spreadsheet is a common way to corrupt a dataset -- be extremely careful if you do this (better to do it in code without altering the master file). For datasets that can be contained in a single flat text file (as opposed to a relational database), consider a "tidy" data format early on as this will make later data manipulation and analysis easier. However, don't be a slave to the "tidy" format either. Sometimes it is easier and less error prone to enter data in a convenient non-tidy format and convert it later. Use your judgment.

### Preparing data
Once a master data file or database is established and validated against paper records, don't modify it directly. Treat it as "read only". Use code to make derivative versions (such as subsetting, reordering rows or columns, renaming variables, creating new variables, transforming to tidy format etc). For example, code could include R or Python scripts or SQL queries. Analysis workflows that require intermediate data steps are sometimes called pipelines. Construct pipelines with code. Avoid doing any of these steps by hand (e.g. many common manipulations possible in Microsoft Excel).

### Producing reports
It is possible to do everything in code, including writing papers (say in LaTeX or Rmarkdown) so that the analysis is incorporated directly into the written manuscript. We will learn how this can be done through R scripts or Rmarkdown. While this literate programming approach is commendable **in concept**, and recommended for technical papers with lots of equations, simple analysis reports, or coding tutorials, there are some important tradeoffs to consider for more complex tasks like writing papers. These include:

1. You need to write and debug document code in addition to debugging data, models, and analysis code. As document code becomes more complex, the analysis code is buried deeper.
2. Integrated development environments for writing code are sub-optimal for writing prose. RStudio especially is a poor writing tool. For example, you cannot view multiple pages at a time, and especially not across multiple monitors (using multiple monitors is a huge boost in creativity, organization, productivity, and simply good writing).
3. You need to `knit` the document constantly during writing and editing to see what the final document looks like. Writing is a creative and iterative process. Constant knitting is a distraction, deflects writing creativity toward solving technical issues with the document, and wastes time (knitting is slow!).
4. Facilities for co-writing are limited. Collaborative writing in LaTeX or Rmarkdown is a dreadful experience, even if all coauthors are experts at coding the markup. Commenting and marking up proposed changes (aka "track changes") are essential for creative development of ideas and quality feedback from co-authors or PhD advisors. These facilities are inferior in current text-based environments. It is possible to use text diff operations (e.g. `git diff`) and you can comment in text if you include special markup. Accepting and rejecting changes is a seamless process in regular word processors but becomes a rather painful business of merging conflicts in text-based environments. Overall, collaborative writing is a poor experience compared to a fully integrated authoring environment (i.e. most regular word processors). Most coauthors will not be willing to deal with such impediments, especially if they are not data scientists, and you should not expect them to. Also, it is not possible to comment and track changes in real time among coauthors. For LaTeX and knitr, the online service Overleaf has a work-in-progress app with better track changes and commenting, including real time, but they do not yet approach the experience available with a regular word processor or Googledocs. It also requires a paid subscription and is not open source.
5. Are your coauthors up to the task? If your coauthors are not LaTeX or Rmarkdown experts, their feedback will be especially shallow and your manuscript will suffer from the lack of quality collaboration.

Hopefully these downsides to text-based workflows will be overcome with better software in the future. Even so, it doesn't seem necessary for reproducible science to make creation of manuscript prose and layout "reproducible" in code. Such a step seems overly pedantic as a reproducible paradigm. A published document is about as permanently reproducible as any means of communication can be regardless of how it was produced (i.e. just print or download the published pdf). In my opinion, it is better to focus your efforts on making data preparation and analyses reproducible, while optimizing your paper-writing experience to reflect the creative process that is writing, and considering your coauthors.

### Portability and reproducibility of code
It is worth thinking about the portability and universality of our code. Is our code easily ported to another programming language? This is an aspect of reproducibility. Will a scientist 20 years in the future be able to understand our code? Consider that the code language we use now will likely not be popular in future. Yes, R will probably be dead! Will a scientist in another discipline be readily able to understand our code? Consider that the coding languages common in our discipline may not be common in others. Will someone who codes in another language be able to understand our code? For example, can we give our R code to a scientist who uses Python, Julia, C, or Matlab so that they can readily understand or implement our algorithms in their language?

Such a notion of **scientific portability and reproducibility** leads to decisions about appropriate coding style for different situations. Software developers have strong opinions about coding style as applied to developing software. Considerations for scientists might be different. What are our priorities as scientists? For example, in R we can choose among at least three major [programming paradigms](https://en.wikipedia.org/wiki/Programming_paradigm): functional programming generally (and the tidyverse dialect in particular), procedural programming, or object-oriented programming. Each may be more appropriate in different situations. For example, a procedural programming style (e.g. `for`, `while`, `if`, `if/else`) is readily ported to all popular languages in science, so is a good candidate for universal communication of ideas and algorithms among scientists. Procedural programs automatically describe how a model operates, so this style can be a good choice for representing many types of natural process models. R is designed as a functional programming language and as such involves idioms and functions specific to R (e.g. `apply()`, `%>%`). In this way, it is less scientifically portable. On the other hand, this functional approach is incredibly useful and time saving in many data visualization (e.g. `ggplot()` for graphics) and analysis (e.g. `lm()` for linear models) tasks because, by design, a functional style focuses on what is to be accomplished (e.g. produce a plot) rather than how it is done. Fortunately, we can mix paradigms to most clearly communicate the science. A good principle for reproducible scientific code is that any scientist that does not code in our language can easily reproduce the science in another language with minimal code translation. This is the same principle as being able to reproduce a result in a different lab: the method should be clear and not obscured in lab-specific jargon.

<!-- Rmarkdown pros and cons -->



## 3. Use open source software and file formats
Data and analyses should, to the greatest extent possible, use open source, cross-platform, file formats and software. Open source software has a better chance of being able to be used by anyone now and in the future. Open source software is transparent. Free and open source software (FOSS) like R and Python belongs to the community. Open source file formats, and text files in particular, ensure that files can always be opened in the future and across any operating system. Small datasets are best in standard text formats such as `.csv`, `.xml`, `.json` etc. Code of course is already text. Large and/or long term datasets are often more sensibly and conveniently managed in database systems; open source options include MySQL, MariaDB, sqlite, postgresql. For geographic data, qgis is open source.

Does this mean you shouldn't use Microsoft Excel? Excel is very good for data **entry** -- spreadsheet programs definitely have their uses in a data workflow. However, once data are entered, the standard Excel file format is not optimal because it is not plain text. Standard practice is to export Excel files to `.csv`. On the other hand, if you need a spreadsheet with some calculations, modern Excel files are actually an open-source format *not* a proprietary binary format (a common misconception). The Excel `.xlsx` format is merely an xml format in a zipped archive (change the file extension to `.zip`, unzip the file, and you have plain text xml plus any images; the xml schema are openly published). This is also true of Microsoft Word `.docx` files.



## 4. Organize files in one location
For small data-analysis projects, such as are typically associated with a single published paper, a single project directory can be sufficient. One directory per paper is a logical organization because the project archive can be self-contained along with the paper. It can then also be one Git repository. If using RStudio, the directory can also be an RStudio project.

### Organization structure and naming
It is hard to give rigid advice on the organization of files within this directory. Much depends on the project. For many projects, one directory containing individual files of data, analysis scripts, and results can be all that is needed. For more complex projects it can make sense to have a sub-directory structure. Here is one possibility among many:
* analysis scripts in the top-level directory with the following sub-directories
* source - for functions and other helper code that is sourced by scripts
* data_raw - for all raw data files
* data_derived - for any datasets derived (using code) from the raw data
* output - for output like tables and figures

Don't include spaces in directory names or file names. Use an underscore instead, such as `my_file.R`. Use a numbering scheme to indicate file order, such as:
* `01_my_first_script.R`
* `02_my_second_script.R`
* ...

If temporal sequence is important, use a `yyyy-mm-dd` format like this:
* `2020-09-24_data.csv`
* `2020-10-19_data.csv`
* ...

### Relative paths
Organizing files in one location also makes it easy to refer to files in scripts using relative rather than absolute paths. Use relative paths so that code will work from any location on any computer. Don't use absolute paths in scripts such as
```
C:/user/jane/janescoolstuff/experiment2/data_raw/experiment2_data.csv
```
This will break the script on a different user's computer. Instead, use relative paths, such as
```
data_raw/experiment2_data.csv
```
Anyone can then run the code without needing to modify the file paths. This is especially important when collaborating via a repository.

### R specific considerations
Two other R specific considerations for project organization:
1. Don't use `setwd()` in scripts. This is not portable and will break the script on another person's computer. If set up as an RStudio project, RStudio will be in the correct working directory when the project is opened.
2. Don't save the R workspace. Start clean each time. In Tools > Global options > General, set "save workspace" to "Never" and uncheck everything except "Automatically notify me of updates to RStudio". This ensures that all your work derives from code and provides a test of the code each time you work on the script.

Read Hadley Wickham's [chapter on project workflows in RStudio](http://r4ds.had.co.nz/workflow-projects.html) in *R for Data Science* for more R specific advice. His chapter concurs with the advice given above.



## 5. Track changes to files
Version control is like "track changes" for code and plain text documents. It is a way to record the history of a project, particularly changes made to data and code. If necessary, code or data can be reverted back to previous time points. Git is the dominant version control tool, and is free and open source. A basic but adequate workflow uses a local Git repository (**repo** for short). This might be suitable if you are working alone. To be reproducible and track your changes, go about your usual business of creating and editing files (data, R scripts, notes etc) in the local folder, taking care to document your process and making frequent Git commits. Add a descriptive comment to each commit, and tag important commits (e.g. v0.1). Together with GitHub, Git facilitates collaboration and open science. Adding GitHub as a remote repository will allow you to: 1) use project management features such as issue tracking, 2) collaborate with others on the analysis (private or public), 3) do the analysis in public (the open science approach), 4) share finished code and results.

See the [Git tutorials](../skills_tutorials).



## 6. Archive final working versions.
When you publish a paper you should (and likely will be required to) archive and/or publish the final working version of the data and analyses. You are quite likely to want to come back to it either in response to reader's comments or for follow up studies or meta-analysis. You will want to be able to exactly reproduce everything in the paper. By using Git, you'll be set to easily archive and/or publish final working versions of your analysis. You can simply tag a specific commit in your project history.

There are a few important archiving considerations.
* When stochastic analysis methods are used, such as bootstrapping, simulation, or MCMC, use the `set.seed()` function so that random number generation is repeatable.
* Record detailed version information for all software and packages. In R, this is especially easy to do using the function `sessionInfo()`. The R project via [CRAN](http://cran.stat.ucla.edu/) archives all versions of R and packages so that it is always possible to go back to old versions if that is needed to reproduce an analysis.
* If you use R packages from GitHub (rather than CRAN), these will not be archived by the R project. You'll need to include entire copies of these in the archive. Assume that any project on GitHub is ephemeral and could be removed or altered by the author at any time.

Nevertheless, the above still might not be sufficient. If we want to be paranoid, we could include a copy of R itself and/or a copy of all the packages we used. The R packages `packrat` or the newer `renv` aim to help with this. More advanced still, we could virtualize or containerize the entire analysis environment in a virtual machine or using [docker](https://arxiv.org/abs/1410.0846) or [lxd](https://linuxcontainers.org/). This could be especially effective if you want to share a complex analysis pipeline that ties many different scripts and software together. Some open source solutions directed at containerized reproducibility are emerging in this area, such as [singularity](https://www.sylabs.io/).



## 7. Backups
Version control is not a backup and neither is pushing to GitHub. While these certainly help protect us from losing files and are very reliable, they are not a guarantee. For example, if a local Git repository is accidentally corrupted and then pushed to GitHub (or vice versa), the situation could become unrecoverable. Git is complicated and things can go wrong. Everyone should have a proper backup solution as well, such as time machine for OSX, the built in backups (file history) for Windows, or the many excellent open source options in Linux (e.g. rsnapshot, borgmatic, restic). The 3-2-1 rule of backups is a good standard: 3 copies, 2 media, 1 offsite. In practice, this could be the original, a local backup to a separate hard drive or server, and a backup to the cloud. Note that a Dropbox or Google Drive mirror of your files is not a backup since any corrupted files will be mirrored to the cloud. Similarly, a RAID volume, while providing some nice redundancy, does not count for more than a single copy despite the duplicated information between disks in the RAID array. Backups should be made **automatically** and **frequently** (at least daily) to all locations. Backups should include the hidden files in Git repositories. Backups should also be tested to make sure files can be restored as expected. Our work is not reproducible if our files are irreversibly corrupted or lost altogether. Absence of backups is responsible for the loss of a huge amount of historical ecological data and the source of many sorrowful graduate school journeys. Make sure you have a backup system!
