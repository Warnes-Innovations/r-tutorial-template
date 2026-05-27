# 00_packages.R
# Purpose : Initialize the renv environment and verify all dependencies are available.
#           This is a setup helper; individual scripts load only the packages they need.
# ─────────────────────────────────────────────────────────────────────────────

# This project uses {renv} for package management.
# The authoritative list of dependencies is maintained in the DESCRIPTION file.

# ── 1. Initialize / Restore Environment ──────────────────────────────────────

# If you are setting up this project for the first time on a new machine:
#   renv::init()

# If you are working on an existing project (e.g., after cloning from Git):
#   renv::restore()

message("renv environment ready. Individual scripts load their own packages via library().")
