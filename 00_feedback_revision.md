# How to view feedback and make code revisions

We'll use Git and GitHub to collaborate on revising your code. To comment on your code, I first cloned your repository to my computer so I have a local version of the repository. I then made a branch in which to make comments and suggested revisions. For code from weeks 2-4, I named this branch `feedback_wk2_4`. When I was done making comments and revisions in this branch, I pushed the branch back up to GitHub. See the tutorial on [git07_branching.md](skills_tutorials/git07_branching.md).

On the GitHub website you might now see an invitation to submit a pull request (**do not accept this; don't submit a pull request on GitHub**). From the local repository on your computer, git won't be aware of this new branch yet. You can see it with

```bash
git remote show origin
```

which will show the new branch under "Remote branches" with the message "next fetch will store in remotes/origin".

To get this branch and set it up for work on your local computer you first need to fetch it

```bash
git fetch
```

which will bring the contents down to your local repository where it will be stored with the reference 'origin/feedback_wk2_4'.

Before you do anything with this branch, you'll first want to wrap up what you are doing in the main branch and commit your work on main.

```bash
git commit
```

Next, to see my comments and revisions in the new branch you need to create a branch in your local repository and switch to it, all of which is done in the single command:

```bash
git checkout feedback_wk2_4
```

In response, you'll see the message

```
Switched to a new branch 'feedback_wk2_4'
branch 'testbranch_me' set up to track 'origin/feedback_wk2_4e'.
```

Now the files in your repository's directory are those in the `feedback_wk2_4` branch. 

An important new file you'll see in this directory is: 

`00_portfolio_checklist_to_week4.md`. 

This file shows what work is considered complete and what work needs revision. Completed work has a checkmark in the box, like this: `[x]` (in a markdown viewer, or on GitHub, it will show as a ticked box). If you completed either of the problem sets, you'll also find `.R` files with my solutions to those.

I might have made all sorts of changes to your repository, like modifying the text of files, adding new files, deleting files, or renaming files. To list all the changes I've made, you can do

```bash
git diff main feedback_wk2_4
```

This will tell you about new files, deleted files, and modifications I made to your code. I indicated my comments with the prefix "BAM", so you can search for those.

To make your revisions you should work **only** in the `feedback_wk2_4` branch (don't merge any changes into `main`; don't initiate a pull request on the GitHub website). Commit your changes to the `feedback_wk2_4` branch then push them to GitHub. This branch remains separate from your main branch for now.

Meanwhile, to continue working with your main branch (for new assignments etc), you need to switch back to it. First commit your changes to `feedback_wk2_4` then checkout `main`:

```bash
git commit -m "My revisions to weeks 2-4 draft 2"
git checkout main
```

When you are done with revisions on `feedback_wk2_4`, or want more feedback from me, send me an email. I will then pull your changes to my computer, look at your revisions, make any comments etc, and push it back to GitHub. Once we are happy with the revisions, then you can merge them into the main branch.
