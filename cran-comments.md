* This is a new release.

## Test environments

* local Windows 11, R 4.3.2
* ubuntu 22.04 (on GitHub Actions), R 4.3.2
* win-builder (devel and release)
* R-hub (Windows, Ubuntu Linux, Fedora Linux, Debian Linux)
* devtools check_mac_release


## R CMD check results

Local Windows (1/28/24): 0 errors/warnings/notes

GitHub Actions (1/28/24): Status: OK

R-hub:
Ubuntu Linux (1/28/24): 2 NOTEs for tidy not being found and new submission
Windows Server (1/28/24): 3 NOTEs that aren't real issues
Fedora Linux (1/28/24): 2 NOTEs for tidy not being found and new submission

winbuilder devel (1/28/24): 1 NOTE, not an issue

check_mac_release (1/28/24): Status: OK

## Downstream dependencies

There are currently no downstream dependencies for this package.
