# Git collaboration and teamwork

Using Git and GitHub is transformative for collaborating on a coding project.

### Basic workflow

I will incorporate my feedback on your code into your repository. You'll need at least to collaborate with me through GitHub to get feedback on the code in your project. If you are working with other people on a project, here's a good workflow for collaborative coding on a single branch (e.g. main):

#### 1. Get collaborator's changes from GitHub

* First commit any changes to your local repository (you don't necessarily need to commit your local changes but it can be the approach that involves the least hassle).
* Then `git pull`. This will fetch the version of your repository from GitHub and attempt to merge any differences in it with your local repository.
* This may reveal some differences that can be considered *conflicts* between the version on GitHub and your local version. Review the "Conflicts" tutorial at Software Carpentry (below) to see how to resolve these differences.

#### 2. Push your changes to GitHub

If someone else is contributing to your project's code on GitHub, when you try to push you may find that it isn't possible because the other person has updated the version of the repository on GitHub. Before you can push, you have to update your local version to take these updates into account. First, you need to do the three steps described above in "Getting changes from GitHub", then you'll be able to push.

### Tutorials at Software Carpentry

https://swcarpentry.github.io/git-novice/

* Conflicts

You might also find the following tutorials useful for background and more complicated details (but not necessary for now since the essential steps are described in "Basic workflow" above).

* Remotes in GitHub
* Collaborating

### Summary of Git commands:

`git remote -v` List your Git project's remotes. Your remote, which will be known as origin, will be on GitHub.\
`git fetch` Fetch work from the remote (GitHub) into the local copy.\
`git merge origin/main` Merge origin/main into your local branch (after first fetching it).\
`git pull` Combine `fetch` and `merge` above into one command.

### Try with GitHub

Try resolving a conflict with a test remote repo on GitHub (in your personal GitHub account, not in the class Organization area).

For example, practice resolving a conflict that arises from working with a collaborator. First simulate a collaboration and set up a conflict:

* On GitHub, initiate a repo named `testrepo`. Include a `README.md` file when you set it up.

* On your computer, set up two directories, named `collaborator1` and `collaborator2`.

* Navigate to the `collaborator1` directory on your computer and clone the GitHub repo here. You will now have a `testrepo` directory inside `collaborator1`. Do exactly the same in the `collaborator2` directory. Now you have two separate clones of the repository, simulating two different collaborators.

* Now, imagine you are collaborator 1. In `collaborator1/testrepo` add some text to `README.md`, e.g. "Hello! Collaborator 1 here!", then commit and push your changes to GitHub.

* Now, imagine you are collaborator 2. In `collaborator2/testrepo` add some different text to `README.md`, e.g. "Hello! Collaborator 2 here!", then commit the changes to collaborator 2's repository.

* Now, still imagining you are collaborator 2, try to push from `collaborator2/testrepo`. It will be rejected (fail) because there is a conflict. You'll need to pull first. You will also then need to **reconcile merge conflicts**. The automated merge will fail to complete because collaborator 1 has made changes that conflict with your (collaborator 2) changes. Use `git status` to see where the unmerged changes are. Here, it will tell you the unmerged changes are in `README.md`. `README.md` will now have mark up that indicates the changes that need to be resolved. This is what I found in `README.md` after I tried to `git pull` as collaborator 2 in my simulation:
  
  ```
    <<<<<<< HEAD
  Hello! Collaborator 2 here!
  =======
  Hello! Collaborator 1 here!
  
  > > > > > > > 55ed3840c39e3d282fa4ba92e037140404a1b9fa
  ```

* One way you could resolve this as collaborator 2 is to edit `README.md` so that it contains both new lines, removing the git markup, like so:
  
  ```
  Hello! Collaborator 1 here!
  Hello! Collaborator 2 here!
  ```

* Now, as collaborator 2, you can successfully commit this change and push it to GitHub.

## Further reading

[Pro Git Chapter 5 Distributed Git](https://git-scm.com/book/en/v2/Distributed-Git-Distributed-Workflows) is really good for the concepts and various ways to collaborate. You will probably most often use the "centralized workflow" to collaborate on projects.

Relevant topics at "Happy Git with R" are:

* [Dealing with push rejection](https://happygitwithr.com/push-rejected.html)
* [Pull, but you have local work](https://happygitwithr.com/pull-tricky.html)
