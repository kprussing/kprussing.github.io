:author: Keith F. Prussing, Ph.D.
:date: 2020-03-10
:template: post.html

.. meta::
   :keywords: Pandoc, Markdown, LaTeX, reStructuredText

Reformatting my Website
=======================

.. container:: abstract

  I recently decided I wanted to update my website with a new post.  But
  the post I wanted to write was too complicated to keep in a single
  post.  That's when I discovered that Jekyll isn't quite up to the task
  of managing my website as it grows.  This is a post about how I
  migrated to a new static site generation process.

Introduction
------------

As you may have noticed, I recently decided that Jeykll was not quite up
to the task of generating my website based on the content I wanted to
write.  The main problem was I was exploring `Bison and flex`_ for
parsing an input file at work.  So, I decided I would write a post.  In
the process of writing, I decided to write code snippets.  But, I wanted
to make sure the snippets actually compiled and didn't want to copy the
code between files.

This is my problem.  I come from the world of LaTeX where I can easily
write stand alone code and just use listings_ to include the file in the
code.  Searching the internet turned up no simple way to do this with
Jekyll.  All of the methods I could find required forcing Jekyll to do
something is wasn't designed to do.  After all, one of its goals is to
make simple blogs simple to write.  The post I wanted to write was just
too complicated.

Thus, I decided to explore other options for generating my website.
Obviously, the primary goal was to allow me to write in a way that feels
more natural.  But, I could also address a few items that I wasn't
really wild about with how I had been using Jekyll before like the date
being only in the file name, the arbitrary way I had been creating the
posts landing page by looking for a comment, the fact that I had
unfinished posts under the ``_posts`` directory, and Jekyll has no clear
way to add additional build steps like image generation.  This note
reviews my findings on converting to the new system of using Pandoc_ and
SCons_ to generate my website.

First Attempt: Using LaTeX
--------------------------

As you may have expected, my first attempt was to just write in LaTeX.
This had the advantage that I am already very comfortable writing in
LaTeX.  Additionally, I have developed an hobbyist interest in
typesetting and teaching LaTeX how to do interesting things with a
document's content.  A major plus for me was I could use my favorite
build tool SCons to manage building not only the document, but the
code samples that were the impetus for this change.  I could have used
``latexmk``, but I find it does not do as good of a job deducing an
included file has changed compared to SCons.

So, I wrote the article.  I gained a better understanding of Bison and
flex and how to use them and the parser wasn't half bad.  But then I
thought more about the problem and decided the file really needed
something more like YAML to store the data, and I wasn't about to write
that kind of parser.  In the end, I committed my writing, looked at the
nicely typeset PDF, and started trying to figure out how to translate
that into an HTML version to post.

My preliminary search turned up a few contenders: make4ht_, lwarp_,
Hakyll_, and Pandoc.  Make4ht and lwarp both have the advantage of being
part of TeXLive so they had nothing additional to install.  However, I
couldn't really get either to work.  Make4ht needs to transfer through
``latex`` which caused problems with building the PDF version of the
output, and lwarp was not able to properly handle ``lstinputfile`` to
add my code snippets.  I came across Hakyll, but noticed it uses Pandoc
to parse the LaTeX.  I happen to know from experience that Pandoc is not
a good front end for moderately complex LaTeX documents.  It has a bad
habit of dropping significant blocks.

Second Attempt: Move to Sphinx and reStructuredText
---------------------------------------------------

With LaTeX being too much to convert to HTML, it was back to the
internet for me.  I started toying with the idea of Asciidoctor_, but I
wasn't convinced about its build system.  The syntax is reasonable, but
I wanted more.  This lead me back to reStructuredText and Sphinx_.  I
use reStructuredText frequently in my Python docstrings and side
projects.  I would use it more at work, but it turns out Atlassian's
enterprise version of Bitbucket (i.e. the one you pay lots of money for)
does not support reStructuredText rendering README which is annoying.

I really like reStructuredText.  It's the markup used in may Python
packages.  It is very minimal in running text and the blocks are clearly
delimited.  I want to use it for a project or task, but the build tools
just make it too complicated.  Sphinx is arguably the defacto
reStructuredText processing engine.  It is Python (yay!) and very
customizable, but I find the templates to rigid.  They are focused on
documentation which is great, but I don't want a search bar or index.  I
started working on a theme, but trying to get the layout I wanted was
just too complicated.  Couple that with make being the default build
tool and I decided to backup and take another search around.

.. note:: Update 2021-03-28: And it turns out I just wasn't trying hard
   enough.  I managed to create a template_ of my own so I could use it
   for my side projects.  That led me to reformat my website again.

Third Attempt: Just use Pandoc and SCons
----------------------------------------

Ultimately, I decided to just stick with Markdown and just use Pandoc to
actually generate the website.  Coupling it with SCons (using my handy
`Pandoc tool <tool>`_) means I can easily drop additional steps in the
build chain to auto generate pages or images.  Additionally, the filter
system allows me to easily insert content based on the metadata using
the full power of Python (or Hakell or Lua).  Further, I find the Pandoc
templates are quite a bit cleaner than the Jinja templates of Sphinx.

I did discover that one of my problems with Sphinx was my limited
knowledge of CSS.  Some of the formatting details I was struggling with
were still there using Pandoc.  It turns out the Jekyll template I was
using relied heavily on SASS which I didn't know about.  A little more
study will allow me to unravel that dependency and give me a chance to
customize the output more.

The final challenge we getting GitHub to properly display the pages.  I
attempted to use the ``.nojekyll`` trick that's listed on the web do
disable Jekyll, then the pages wouldn't host from my main folder.  The
second attempt was to build into Jekyll's ``_site`` directory, but that
didn't work either.  It turns out that GitHub's *personal* pages must be
processed by Jekyll.  (Apparently, I closed the website where I found
that nugget of information, but `this answer`_ has some information.
You can also see it when you compare enabling Jekyll on a personal page
verses a project page).  My solution was to just move my website to a
new repository and host it like a project.  I already did this with my
resume and it works like a charm.

Conclusions
-----------

So here we are.  I have migrated to using Pandoc and SCons to generate
the website.  Pandoc allows me to embed additional metadata into the
posts and potentially look into generating PDF versions from a common
source while SCons allows me to add additional build logic to keep my
sources clean.  All of the changes I attempted are archived in the
`original git repository`_ for the website under branches.  They may
have some useful tips for those interested, but they are more likely to
keep me from redoing the initial setup in the future.  The only other
steps are to add a hook to build the website locally when pushing and
then get back to writing.

.. note:: Update 2021-03-28: I also went back to using the original
   repository so I can easily link to my resume and side projects.

.. _Bison and flex: link to the post
.. _listings: https://ctan.org/pkg/listings?lang=en
.. _Pandoc: https://pandoc.org
.. _SCons: https://scons.org
.. _make4ht: https://ctan.org/pkg/make4ht?lang=en
.. _lwarp: https://ctan.org/pkg/lwarp?lang=en
.. _Hakyll: https://jaspervdj.be/hakyll/
.. _Asciidoctor: http://asciidoctor.org/
.. _Sphinx: https://sphinx-doc.org
.. _tool: https://github.com/kprussing/scons-pandoc
.. _original git repository: http://github.com/kprussing/kprussing.github.io
.. _this answer: https://stackoverflow.com/a/27666206/4249913
.. _template: https://kprussing.github.io/kpruss
