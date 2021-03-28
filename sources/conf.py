# Configuration file for the Sphinx documentation builder.
#
# This file only contains a selection of the most common options. For a full
# list see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Path setup --------------------------------------------------------------

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#
import glob
import os


# -- Project information -----------------------------------------------------

project = "Computational Physicist in Atlanta. GA"
author = "Keith F Prussing, Ph.D."
copyright = "2021, " + author


# -- General configuration ---------------------------------------------------

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named "sphinx.ext.*") or your custom
# ones.
extensions = [
    "sphinx.ext.todo",
]

# Add any paths that contain templates here, relative to this directory.
templates_path = ["_templates"]

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = [
    "_build",
    "Thumbs.db",
    ".DS_Store",
    "changelog.rst",
]


# -- Options for HTML output -------------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#
html_theme = "kpruss"
html_theme_options = {
    "author": author,
    "avatar": "https://avatars.githubusercontent.com/kprussing",
    "github": "kprussing",
    "email": "kprussing74@gmail.com",
    "linkedin": "kprussing",
    "stackoverflow": "4249913",
}
html_use_index = False

html_sidebars = {
    "**": ["localtoc.html", "relations.html", "sourcelink.html"],
}

html_additional_pages = {}
for root in (os.path.join("fun", "spell_lists"),
             os.path.join("fun", "dnd", "blank")
             ):
    for _ in glob.glob(os.path.join(root, "*.html")):
        html_additional_pages[os.path.splitext(_)[0]] = \
                os.path.join(os.pardir, _)

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = []
