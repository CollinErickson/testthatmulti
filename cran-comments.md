I submitted this for a second time on 2/1/24 and received an email on 2/3/24
that I used the wrong kind of quotes in the DESCRIPTION file. I have fixed that
and am resubmitting with no other changes.

-- Previous submission notes --

I submitted this on 1/28/24 and received an email on 1/30/24 that I have to
fix a few things.

I fixed the description.

There are no references.

There was an example with a commented out line that I was told had to be fixed.
I improved the examples. I had commented out an example that gave an error,
I changed it to be enclosed within a try() statement.

## Test environments

* local Windows 11, R 4.3.2
* ubuntu 22.04 (on GitHub Actions), R 4.3.2
* win-builder (devel and release)
* R-hub (Windows, Ubuntu Linux, Fedora Linux, Debian Linux)
* devtools check_mac_release


## R CMD check results

Local Windows (2/3/24): 0 errors/warnings/notes

GitHub Actions (2/1/24): Status: OK

R-hub:
Ubuntu Linux (1/30/24): 2 NOTEs for tidy not being found and new submission
Windows Server (1/30/24): 3 NOTEs that aren't real issues
Fedora Linux (1/30/24): 2 NOTEs for tidy not being found and new submission

winbuilder devel (1/28/24): 1 NOTE, not an issue
winbuilder devel (1/30/24): 1 NOTE, not an issue

check_mac_release (1/28/24): Status: OK

## Downstream dependencies

There are currently no downstream dependencies for this package.
