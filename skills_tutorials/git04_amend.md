# Git amend



## Fixing a minor issue in a commit

Here's something that happens to me about 5 times a day. Make a commit, push it to GitHub, read it on GitHub ... and ... notice a typo or two, or some other minor problem like forgetting to add a file, or a hyperlink that doesn't work, or you want to change the commit message. So I fix the typo. But I don't want to make a whole new commit just for this, otherwise my commits are going to be littered with commit messages like "Fix typo", "Fix another typo", "Fix yet another typo". What we can do instead is amend the previous commit. Stage your changed files as usual, then

```bash
git commit --amend
```

and if you had already pushed to GitHub before noticing the problem, you'll need to overwrite the push like this:

```
git push --force
```

You have to be careful using the `--force` option. If it's just you working in the GitHub repository, it's no problem. If you're collaborating with others it can be an issue because if somebody pulls your commit and then you over-ride it with an amended commit, the history for that commit is out of sync. Usually it's safe if you fix the error within a few minutes but if you're collaborating on a fast-paced project via GitHub, it's best to make all your amendments locally and be satisfied with the final commit before pushing.



## The repeated amend

Another way that `amend` is useful is as a temporary "track changes" or "work in progress" mechanism as you work toward a distinctive commit. This is a **commit often** strategy and allows you to wind back to a previous minor step if you mess something up. Read about this workflow strategy here:

* [Happy Git with R: Ch 26 The Repeated Amend](https://happygitwithr.com/repeated-amend.html#repeated-amend)



## Further reading
[Pro Git Chapter 2 Git Basics - Undoing Things](https://git-scm.com/book/en/v2/Git-Basics-Undoing-Things).



