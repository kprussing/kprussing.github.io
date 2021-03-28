:author: Keith F. Prussing
:date: 2014-09-27
:template: post.html

Least Squares Fitting
=====================

.. container:: abstract

    This note is more for myself than for anyone else.  I have derived
    the expression for the least squares fitting so many times it's not
    funny.  The problem is, once I cobble together the routine to
    perform the fitting, I completely forget how to do it again.  I
    hope, this will prevent me from having to do it ever again if only
    because it is on my website.

.. note::

    This post was originally focused on using Jekyll to generate this
    website.  I have since moved to using Pandoc_ which does not require
    explicitly embedding the JavaScript code, but you must include one of
    the command line options to `render the math <https://pandoc.org/MANUAL.html#math-rendering-in-html>`_.
    The syntax of the raw text has been updated but not the content.

This post also gives me a chance to try out MathJax_.  After a Google
search, I came across these_ instructions.  Apparently, we simply need
to add::

    <script type="text/javascript"
        src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
    </script>

to the layout.  However, I don't really want it in every page.  So, I
just put it at the top of this source.  Oh while I'm at it, make sure
you spell ``javascript`` right.  If you don't you could spend a few
hours wondering what went wrong like I did when I spelled it
``javascrpit``.

We begin with a set of function of the independent variable
:math:`\{x_i\}` and dependent variables :math:`\{y_i\}`.  We then select
a collection of functions to relate the two

.. math::

    y_i = a_0 +a_1 x_i +a_2 x_i^2 +\ldots +a_j \sin(x_i) =\sum_j
    a_j\,f_j(x_i).

Now, we minimize the squared error

.. math::

    \frac{\partial}{\partial a_k} \frac{1}{N}\sum_i [y_i -\sum_j
    a_j\,f_j(x_i)]^2 = -\frac{2}{N} \sum_i [y_i -\sum_j a_j\,f_j(x_i)]
    f_k(x_i) = 0

or in matrix form

.. math::

    \mathbf{a} \mathbf{F} \mathbf{F}^T = \mathbf{y} \mathbf{F}^T 

which can be readily solved for the coefficients :math:`\{a_j\}`.

See, I told you that this was simple.  Now to put this online and see
how the math looks.

A few pointers:

*   You must escape the backslashes in entering the math mode ``\\( …
    \\)`` and ``\\[ … \\]``.
*   The dollar sign version ``$$ … $$`` appears to work as inline math
    with ``kramdown``.
*   The ``\sum_j`` construct with no limits on the sum does *not* like
    with the index is inside ``{}`` unless you escape with a backslash
    (maybe.  I didn't actually test that).

.. _Pandoc: https://pandoc.org
.. _MathJax: http://www.mathjax.org
.. _these: http://gastonsanchez.com/blog/opinion/2014/02/16/Mathjax-with-jekyll.html
