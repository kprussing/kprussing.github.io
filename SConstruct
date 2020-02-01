#!/usr/bin/env python

import os

env = Environment(ENV=os.environ, PDFLATEX="lualatex")

pdfs = [p for t in ("kprussing.tex",
                    os.path.join("posts", "2020-01-18-writing-a-parser", "index.tex"),
                   )
          for p in env.PDF(t)]

if not GetOption("clean"):
    Default(pdfs[0])
