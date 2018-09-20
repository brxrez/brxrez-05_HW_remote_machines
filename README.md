# Working on remote servers homework assignment for BIOL422/423
## Due as a pull request on September 25, 2018 before 11:59 pm

The **goal of this assignment** is to get you to get more practice writing bash scripts on the command line, doing so in the context of a version-controlled workflow, this time entirely on a remote server, and submitting your work as a Pull Request on GitHub.

You will write one bash script and one `YYYY-MM-DD_fasta_QC_notes.md` text file for this assignment. The script will produce some summary information about a larger set of fasta files, and you will store the output of this script in a text file called `YYYY-MM-DD_fasta_QC_log.txt`. You will need to write this script to accept and parse command line arguments and summarize them using a for loop.

Please follow the instructions carefully and read them all before getting started.

This second assignment will be worth 20 points. The grading breakdown will be as follows:

* 10 points - Completes all required steps (as outlined below)
* 3 points - Both scripts are appropriately commented and well organized
* 3 points - Appropriate use of git to version control the steps, including adding and committing the appropriate files at the specific steps below, and writing informative and appropriately formatted commit messages
* 4 points - Passes Travis CI automated style checks

You must submit your work as a Pull Request to the class organization ('https://github.com/2018-usfca-biol-422-fall') on GitHub by 11:59 pm on Tuesday, September 25 for full credit. Late assignments will not be accepted, since we will be peer reviewing the code after it is submitted.

Steps:

1. Fork this repository to your own GitHub account.
2. Connect to tule.usfca.edu with `ssh yourusername@tule.usfca.edu -p 80XX` using the username, password, and port (that's the 80XX part of the command) that were emailed to you. You will need to connect to the VPN before you do this if you are off campus.
3. You'll need to set up your `git` preferences on this server, since this is the first time you are using it. You can do that with:

```
git config --global user.name "Your Full Name"
git config --global user.email "yourgithubaccount@email.com"
git config --global core.editor nano
git config --global color.ui auto
```

4. Start a new named `tmux` session on the server ([tmux cheat sheet here](https://gist.github.com/MohamedAlaa/2961058)). You'll notice that there is already a `/data` directory on the server, with some zipped fasta files in it.
5. Clone your fork of the assignment repository down to the server.
6. Go into the assignment directory from the command line.
7. Make a `data` directory in your project folder. Copy (using `cp`) the zipped fasta files from the existing data directory into the one you just created (e.g. `cp /data/* data`). Completing this step before you start working with the data files will allow you to get them back (copy them again) if you accidentally delete them or otherwise mess them up (it happens to all of us...). Also note that I added this data folder to the `.gitignore` file, so you shouldn't have to worry about git asking if you want to track it. *This data folder should never be committed or pushed to GitHub.*
8. Write a bash script, using nano, named `fasta_QC_checks.sh`. It should produce a set of summary information about each of the fasta files in your copies version of the data directory. You may want to split your tmux window vertically to have both nano and a bash prompt open at once while you work on this.
  * Each fasta file is zipped individually. You will need to decompress each of them before you can process them.
  * The first lines of output should say that this is a log file, and include today's date. The date should be generated dynamically (use the `date` command). For everything else in this preamble you can just use `echo`.
  * Then, you should loop over all of the fasta files, producing a set of summary output. The output you should produce about each of the fasta files include: its name, its size in human readable units (hint: I think `du` and `cut` will work for this -- check out the help or man page for both of those to figure out what options to use), the first three lines, the last three lines, the number of sequences in the file, and the sequence identifier lines in the file, sorted alphabetically.
  * You should also include a liberal use of echo to add blank lines and seperators to make the output coherant and readable.

```
## for example, when I run the script,
## the output should look like:
$ bash fasta_QC_checks.sh data/*.fasta

Output from preliminary quality control checks on selected fasta files
2018-09-23 21:34

Output for each fasta includes:
Filename, file size, first three lines, last three lines,
the number of sequences in the file, and the
sequence identifier lines sorted alphabetically.

######################################################################

Output for data/file1.fasta:

Size: 14K

First three lines:
------------------
> Homo sapiens
AGTGCGTGCTCGAGTAGCTAGATAAAGATCGC
AGTGCGTGCTCGAGTAGCTAGATAAAGATCGC

Last three lines:
------------------
AGTGCGTGCTCGAGTAGCTAGATAAAGATCGC
AGTGCGTGCTCGAGTAGCTAGATAAAGATCGC
AGTGCGTGCTCGAGTAGCTAGATAAAGATCGC

Number of sequences: 18

Sequence names (sorted):
> Cervus canadensis nannodes
> Homo sapiens
> Mus musculus

######################################################################

Output for data/file2.fasta:

etc etc

```

9. Commit the script as you work on it, whenever you make a good chunk of progress. Make sure you write
   an [appropriate commit message](https://chris.beams.io/posts/git-commit/).
10. After you have finished the script and it successfully runs at the command line, be sure to add a commit marking this milestone (and push back up to GitHub just to be safe!).
11. Then run the script but redirect the output to a text log file called `2018-09-23_fasta_QC_log.txt` (or whatever the date is when you run it).
12. Check that it worked as you expect, and if so, add and commit this log output.
13. Using `nano`, write a short markdown formatted file named `2018-09-23_fasta_QC_notes.md` (changing date as needed depending on when you write it) that contains your brief thoughts (one paragraph max) on the output you produced. Do you notice anything odd or concerning? Think of this as your lab notebook entry about these QA/QC (quality assurance and quality control) checks.
14. Add and commit this notes file as well, once you are done.
15. Your final project folder should look like this:

```
$ ls -aF
.git/
.gitignore
2018-09-23_fasta_QC_log.txt
2018-09-23_fasta_QC_notes.md
README.md # that's this file
fasta_QC_checks.sh
data/
```

16. Once that's all done, add, commit, and push everything back to your fork of the original repository on GitHub with `git push -u origin master`. Remember that you can only push what you have committed, so be sure all of your work is committed. Be sure to save your files often, and check `git status` frequently as you work.
17. Submit a Pull Request back to the organization repository to submit your assignment. Make sure the Pull Request (PR) has a useful description of the changes you made.
18. When you submit the pull request, a set of automated tests will run on it, to check that you have fixed all of the potential code style and syntax errors in your scripts. If you want to rigorously check for any syntax errors while you are working on the code, you can install the 'shellcheck' program. We talked about how to do this in class.

**Infrastructure for Automated Software Testing**

* .travis.yml: a configuration file for automatically running continuous integration checks when you submit your pull request, to verify reproducibility of all .sh script files in the repo. If all pass linting (or code style and syntax checks), then the "Build Status" badge above will be green (build success), otherwise it will be red (build failure). You can click on it and scroll to the bottom to see what went wrong and therefore what to fix.

**Pro Tip:** Save often, commit often, push often, and use `tmux`!
