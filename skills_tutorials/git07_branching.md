# Git branching and merging
Using branches to experiment with new ideas is a powerful feature of Git that is useful anytime. Branching is also an important technique for collaborative coding. The basic pattern is:

* make a new branch and switch to it
* make experimental changes in the new branch until satisfied
* merge changes back into the main branch (usually main)

Practice this workflow in the tutorial below.



## Caveats, advantages, disadvantages

Git and the branch/merge paradigm were invented for software engineering where the goal is one "released" version of the software with other in-progress, often experimental, versions of the software. This workflow doesn't coincide exactly with the scientific workflow so there are advantages and disadvantages.

The main advantage is that making new versions or experiments is easy and robust, especially when a version or experiment involves modifying the code in several files. All the needed files and changes are packaged in the branch. 

The main disadvantage is that the only branch visible in the operating system view of the repository (i.e. the folder or directory on your computer) is the branch that is checked out. The other branches are hidden. This is a disadvantage because in contrast to the single main branch objective of software engineering, the product and goal of scientific investigation often involves many branches that don't merge back into the main branch. They are essentially separate lines of enquiry. In the operating system view of your files, it's not obvious that you did any experimenting or have other lines of enquiry. To even see that these separate lines of enquiry exist, you need to view the branch history of the git repository. Since it's out of mind, it's easy to forget the hidden branch history and thus forget about things you tried.

A clear advantage is when you are making a tool for others to use. This **is** software engineering, so the use case matches the design of git. Similarly, we are usually working toward a definitive analysis that will be published. You could use the main branch to work toward this definitive "release" for the analysis and even publish it along with the branches that explored other things, that people can still optionally explore.



## Further reading

[Pro Git Chapter 2 Git Branching](https://git-scm.com/book/en/v2/Git-Branching-Branches-in-a-Nutshell) is really good for the concepts and various ways that branches can be useful.



## Software Carpentry tutorial remix

Summary of the git commands covered:\
`git branch` List all a Git project's branches.\
`git branch branch_name` Create a new branch.\
`git checkout branch_name` Switch from one branch to another.\
`git merge branch_name` Merge a branch into the current branch.\
`git branch -d branch_name` Delete a branch.



> Learning Objectives
> *   Explain what branches are and how you might use them in your research.
> *   Create an experimental branch and merge it back in to the main branch.

Often you may want to test out a new feature in some code. You may or may not decide you want to keep this feature and in the mean time you want to make sure you have a version of your script you know works. Branches are instances of a repository that can be edited and version controlled in parallel. You can think of it like making an entire copy of your repository folder that you can edit, without affecting the original versions of your scripts.  

To see what branches are available in your repository, you can type `git branch`. First let's make sure we are all in the planets directory in our home folder:

~~~ {bash}
$ cd ~/planets
$ git branch
~~~

~~~ {.output}
* main
~~~

The main branch is created with the repository is initialized. With an argument, the `branch` command creates a new branch with the given name. Let's make a new experimental branch:

~~~ {bash}
$ git branch experimental
~~~

~~~ {.output}
  experimental
* main
~~~

The star indicates we are currently in the main branch of our repository. To switch branches, we use the `git checkout` command to checkout a different branch. 

~~~ {bash}
$ git checkout experimental
$ git branch
~~~

~~~ {.output}
Switched to branch 'experimental'

* experimental
  main
~~~

We have some updated information on pluto, but we aren't sure that we will want to include in our final report. Let's make some updates to the `pluto.txt` file in this experimental branch:

~~~ {bash}
$ nano pluto.txt
$ cat pluto.txt
~~~

~~~ {.output}
It is so a planet!
A planet with a charming heart on its surface; What's not to love?
~~~

We've made this change on our experimental branch. Let's add and commit this change:

~~~ {bash}
$ git add pluto.txt
$ git commit -m "Breaking updates about Pluto"
~~~

~~~ {.output}
[experimental c5d6cba] Breaking updates about Pluto
 1 file changed, 1 insertion(+)
~~~

We've committed these changes locally, but we need to push these changes and our new branch to GitHub. To do so, we enter the following command:  

~~~ {bash}
$ git push origin experimental
~~~

~~~ {.output}
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 307 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
To https://github.com/erdavenport/planets.git
 * [new branch]      experimental -> experimental
~~~

Note that in the past we've types `git push origin main` when pushing to our remote.
This was because we were making changes on our `main` branch and pushing to the remote named `origin`. Here, we've been working on our `experimental` branch. To push those changes to GitHub, we therefore specify that we want to push the `experimental` branch to the remote named `origin`. 

Let's check our status:

~~~ {bash}
$ git status
~~~

~~~ {.output}
On branch experimental
nothing to commit, working directory clean
~~~

You can see from the git status output that we are on the experimental branch rather than the main branch. Let's examine the main branch to ensure the original version of our `pluto.txt` doesn't include this sentimental statement:

~~~ {bash}
$ git checkout main
~~~

~~~ {.output}
Switched to branch 'main'
~~~

~~~ {bash}
$ cat pluto.txt
~~~

~~~ {.output}
It is so a planet!
~~~

As you can see, the main branch does not include our updated notes about Pluto. 

If we look on GitHub, we can switch between the `main` and `experimental` branch and see the same difference between the two versions of `pluto.txt`. 

We are pretty confident that the heart in Pluto is charming, so let's fold in all of the changes that we've made on the experimental branch into our main branch. To merge two branches together, ensure you are located in the branch you want to fold changes into. In our case, we want to be in the main branch:

~~~ {bash}
$ git branch
~~~

~~~ {.output}
  experimental
* main
~~~

Excellent, we are in the right place. To fold the experimental branch into the main branch, we use the `merge` function of git followed by the name of the branch we want to fold in:

~~~ {bash}
$ git merge experimental
~~~

~~~ {.output}
Updating ee530d7..c5d6cba
Fast-forward
 pluto.txt | 1 +
 1 file changed, 1 insertion(+)
~~~

Now if we look at our `pluto.txt` file, we see our updates from the experimental branch:

~~~ {bash}
$ cat pluto.txt
~~~

~~~ {.output}
It is so a planet!
A planet with a charming heart on its surface; What's not to love?
~~~

Now let's push these changes up to github:

~~~ {bash}
$ git push origin main
~~~

~~~ {.output}
Total 0 (delta 0), reused 0 (delta 0)
To https://github.com/erdavenport/planets.git
   a822910..10ed071  main -> main
~~~

> **Pushing all branches to GitHub**
>
> If you've been working on multiple branches and want to push commits from all branches to GitHub, you can use the following syntax rather than pushing each branch individually:  
>
> `git push --all origin`

We no longer have a use for our experimental branch. To delete a branch you don't need, you can use the `-d` flag of `git branch`:

~~~ {bash}
$ git branch -d experimental
~~~

~~~ {.output}
Deleted branch experimental (was c5d6cba).
~~~

> **Deleting a remote branch**
>
> You've deleted your experimental branch locally, but if you look on your GitHub page, you'll see it still exists, even if you `git push --all origin`. 
> To delete the branch remotely, you should use the syntax:    
>
> `git push origin <local-branch>:<remote-branch>`  
>
> In our example this is: `git push origin experimental:experimental`.
> You can also use the shorthand version: `git push origin :experimental`. 
> Using this notation, Git assumes you are listing the remote branch and want to push the branch you are currently in on the local repo. 
> Essentially you are pushing "nothing" to the remote branch, which erases it.



Tutorial modified from Emily Davenport's remix from Software Carpentry: https://erdavenport.github.io/git-lessons/10-branching.html

