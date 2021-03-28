import pathlib

import nox


@nox.session
def docs(session):
    """Build the HTML pages"""
    session.install("sphinx", "kpruss")
    root = pathlib.Path(__file__).parent
    session.run("sphinx-build",
                "-W",
                "-b", "html",
                "-d", str(root / ".doctrees"),
                str(root / "sources"),
                str(root)
                )
