# Equations in LaTeX, markdown and GitHub
LaTeX (somewhat pretentiously pronounced lah-tek) is the standard for writing and typesetting mathematical equations in documents. It is used extensively in the mathematical and technical community. Equations are typed in plain text, like this:

```
$$
y_{i} = \beta_0 + \beta_1 x
$$
```

and they will be rendered like this (provided you are viewing them in an application that shows rendered markdown) :

$$
y_{i} = \beta_0 + \beta_1 x
$$

The `$$` symbols are used to indicate the beginning and end of the equation block. This is known as "display" style and produces a separate paragraph with centered, large symbols. You can also write inline math surrounded by single `$` symbols like this: `$\beta_0$`, which will render as $\beta_0$. Inline equations will be compact, with small symbols.

It's mostly straightforward to write an equation in LaTeX. You just have to know the symbol syntax. Here are some references:

* [Symbol cheatsheet](https://kapeli.com/cheat_sheets/LaTeX_Math_Symbols.docset/Contents/Resources/Documents/index)
* [Wikibook](https://en.wikibooks.org/wiki/LaTeX/Mathematics) but ignore the first section. The most relevant sections are from [symbols](https://en.wikibooks.org/wiki/LaTeX/Mathematics#Symbols) to [brackets](https://en.wikibooks.org/wiki/LaTeX/Mathematics#Brackets,_braces_and_delimiters).
* Find a symbol [by drawing it](http://detexify.kirelabs.org/classify.html)
* [WYSWIG equation editor](https://editor.codecogs.com/): outputs LaTeX syntax from a graphical menu of symbols. You can make your equations here, then copy and paste into your markdown. This is a great way to learn LaTeX too. **I highly recommend using this**.

You can enter equations using LaTeX in Microsoft Word and Google Docs, so this is a universal skill.



#### Equations in markdown and GitHub

You can write equations using LaTeX syntax that will render beautifully in many markdown applications and websites that are [MathJax](https://www.mathjax.org/) configured. As of 2022, this also true on GitHub, but it is a new feature and there might be some pain points. For example, a sentence like this:
```
To estimate the $\beta_0$s, we use the maximum likelihood algorithm, which also estimates the standard deviation ($\sigma$).
```
may not render the equation because of the trailing "s" and enclosing "()". Let's try:

To estimate the $\beta_0$s, we use the maximum likelihood algorithm, which also estimates the standard deviation ($\sigma$).

It might be necessary to write it like this instead:
```
To estimate the $\beta_0 \textrm{s}$, we use the maximum likelihood algorithm, which also estimates the standard deviation, $\sigma$.
```
That should work, although the "s" now has Roman font:

To estimate the $\beta_0 \textrm{s}$, we use the maximum likelihood algorithm, which also estimates the standard deviation, $\sigma$.



Out of the box, RStudio should be capable of displaying typeset equations from the LaTeX markup. Many markdown editors come ready to display equations. However, to display equations on your own computer within a different markdown editor, or to print to pdf, you may need to also install [pandoc](https://pandoc.org/installing.html) or a LaTeX engine (e.g. [miktex](https://miktex.org/)). Consult the documentation for your markdown editor.