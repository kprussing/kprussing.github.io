# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

import os

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
# import os
# import sys
# sys.path.insert(0, os.path.abspath('.'))


# -- Project information -----------------------------------------------------

project = 'The Keith Page'
copyright = '2020, Keith F Prussing'
author = 'Keith F Prussing, Ph.D.'


# -- General configuration ---------------------------------------------------

# Disable the default Python domain as this is just reStructuredText
primary_domain = None

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = [
]

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

# Automatically number labels figures and equations.
numfig = True

# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = "my-theme"
html_theme_path = [os.curdir]

html_style = "my-theme.css"

html_theme_options = {
        "github" : "kprussing",
        "email" : "kprussing74@gmail.com",
        "linkedin" : "kprussing",
        "stackoverflow" : "4249913",
        "footer_bg_color" : "#eee",
        "bg_color" : "#fff",
        "fg_color" : "#333",
        "fonts" : ["Source Sans Pro",
                   "Helvetica",
                   "Georgia",
                  ],
    }

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# Math as images configuration.  (Mainly because it will use LaTeX to do
# the rendering).
# .. todo:: PNG rendering is grainy (shocker) but the SVG isn't workin
#           right.  I need to revisit this once the main migration is
#           done.  It appears like SVG math *needs*
#           ``imgmath_use_preview``, but I can't get the necessary
#           Emacs utility installed.  The error message is unhelpful...
#           For now, just use MathJax.
# extensions.append("sphinx.ext.imgmath")
# html_math_renderer = "imgmath"
# imgmath_image_format = "svg"
# imgmath_use_preview = True
# imgmath_font_size = 10
