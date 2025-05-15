# 1. `git rebase`
**Purpose:** Apply commits from one branch onto another to create a cleaner linear history (without merge commits).  
**Syntax:**  
```bash
git checkout feature-branch
git rebase main
```
**Example:**
```bash
# Assume you're on `feature-1`
git rebase main
```
> This reapplies your `feature-1` commits on top of the latest `main`  
> Use case: Avoid merge commits in a cleaner project history

# 2. `git cherry-pick`
**Purpose:** Apply a single specific commit from one branch to another    
**Syntax:**  
```bash
git cherry-pick <commit-hash>
```
**Example:**
```bash
git checkout main
git cherry-pick 3fce19a
```
Output:
```yaml
[main abc1234] Fix: resolve login bug
 Author: You <you@example.com>
 Date: Tue May 14 13:00 2025 +0530
```
> This applies that one commit into your current branch. Great for hotfixes or selective merges.

**Scenario:**
You’re on `main`, and you want to copy one commit from `bugfix`
```less
bugfix:        X---Y---Z
main:          A---B---C
```
You run:
```bash
git checkout main
git cherry-pick Y
```
**Internally:**  
1. Git finds the "patch" created by commit `Y`  ---> **patch means difference**
2. It applies the same patch on top of `C`
3. It creates a new commit Y' on `main`

**New state:**
```vbnet
main: A---B---C---Y'
```
> Safe way to reuse just one commit, without rebasing or merging branches.


# 3. `git tag`
**Purpose:** Mark specific points in your repo history (usually for releases)       
**Syntax:**  
```bash
git tag <tag-name>          # lightweight
git tag -a <tag-name> -m "message"  # annotated
```
- Tags are just pointers to a specific commit, like a bookmark.
- If it's an annotated tag, Git stores metadata (message, tagger, timestamp)

**Example:**
```bash
git tag -a v1.0.0 -m "First stable release"  #This tags the latest commit (HEAD) with an annotated tag v1.0.0.
git push origin v1.0.0
```
Git Internals:
- Git creates a `v1.0.0` file under `.git/refs/tags/`
- That file contains the commit hash of C. (assuming we are tagging to commit C)

> Tags help when you want to go back to a specific version.

### Bonus: Tagging a previous commit
If you want to tag a specific commit afterwards (not just the latest), find the commit hash: `git log --oneline`  
Then:
```bash
git tag -a v1.0.0 <commit_hash> -m "Tagging a past release"
```
after that u will have to push that tag to remote:(just like we push our changes to remote(github repo))
```bash
git push origin v1.0.0           # Push single tag
git push origin --tags           # Push all tags
```

# 4. `git bisect`
**Purpose:** Find the exact commit where a bug was introduced — binary search of commits.   
**Internals:**  
1. It does a binary search of your commit history.
2. Git picks the middle commit in your range.
3. You manually test and mark it good/bad.
4. Repeats until one commit remains.

**Syntax:**  
```bash
git bisect start
git bisect bad          # current version has bug
git bisect good <hash>  # old working commit
```
**Git checks out each middle commit — you test, then mark it:**
```bash
git bisect good  
git bisect bad   
```
> After a few steps, it tells you exactly which commit introduced the bug

#### Scenario: You know commit `a1b2c3d` was working fine. Now on main, the bug exists. Let Git find where it started.
Commands:
```bash
git bisect start
git bisect bad            # current commit is bad
git bisect good a1b2c3d   # known good commit (magcha asa commit je tumhala mahiti ahe ki tyat ekhi bug navta) 
```
Git will checkout a middle commit:
```bash
Bisecting: 3 revisions left to test after this (roughly 2 steps)
```
You test that commit:
- If it works → `git bisect good`
- If it's buggy → `git bisect bad`

Keep repeating until you see:
```sql
a2d3e6f is the first bad commit
```
Finish:
```bash
git bisect reset
```


# 5. `git blame`
**Purpose:** Find who last edited each line of a file.      
**Syntax:**  
```bash
git blame <file-name>
```
**Example:**
```bash
git blame app.py
```
> Helpful for debugging or reviewing history in large teams

#### Scenario: You’re debugging `app.py` and want to see who wrote a buggy line.
Command:
```bash
git blame app.py
```
Output:
```scss
3fce19a (Alice   2025-05-01 15:42:10 +0530) def login():
bfac123 (Bob     2025-05-03 12:21:30 +0530)     raise Exception("Bug here")
```
Now you can talk to Bob 😄


# 6. `git revert`
**Purpose:** Undo a commit by creating a new commit that reverses its changes       
**Syntax:**  
```bash
git revert <commit-hash>
```
**Example:**
```bash
git revert b7ab35e
```
> Safer than `reset` — it doesn’t rewrite history and is great for shared repos


# 7. `git reflog`
**Purpose:** Show a log of all Git actions, including commits that were deleted or orphaned   
**Syntax:**  
```bash
git reflog
```
**Example Output:**
```bash
a4b21a3 HEAD@{0}: commit: fixed navbar
27cf3e0 HEAD@{1}: reset: moving to HEAD~1
8cdef12 HEAD@{2}: commit: removed footer
```
Now you can:
```bash
git checkout 8cdef12
```
Boom! You recovered your "lost" commit.
> Extremely useful if you accidentally lose commits and want to recover them


# 8. `git archive`
**Purpose:** Create a `.zip` or `.tar` archive of the source code (not including `.git` history).      
**Syntax:**  
```bash
git archive --format zip --output=release.zip main
```
> Used to package source code for deployment or distribution.

**Example Scenario:** Let’s say your repo looks like this:
```perl
my-project/
├── index.html
├── style.css
├── app.js
└── .git/
```
You want to create a `.zip` file of the code inside the main branch without `.git` history.
**Command:**  
```bash
git archive --format=zip --output=release-v1.0.zip main
```
**Output:** This creates a file release-v1.0.zip containing:
```bash
index.html
style.css
app.js
```
> No `.git` folder inside the archive  
> Use Case:
> 1. Share source code with non-Git users.
> 2. Package a build for release without exposing Git history.
> 3. Submit assignments/code to vendors in zipped form.


# 9. `git credential`  – Store or cache credentials securely
**Purpose:** Manage credentials for accessing remotes securely.   
> Avoid entering username/password or PAT (Personal Access Token) every time you push/pull from a remote.
**Syntax:**  
```bash
git config --global credential.helper cache
git config --global credential.helper store
```
> Avoid entering username/password or PAT (Personal Access Token) every time you push/pull from a remote.
**Example 1: Cache credentials temporarily**  
```bash
git config --global credential.helper cache
```
> This stores your credentials in memory for 15 minutes by default

**Optional timeout:**
```bash
git config --global credential.helper 'cache --timeout=3600'
```
> This will remember credentials for 1 hour (3600 seconds).

**Example 2: Store credentials permanently (less secure)**  
```bash
git config --global credential.helper store
```
After you push once and enter your credentials, Git will store them in:
```bash
~/.git-credentials
```
> **Be cautious:** this stores your credentials in plain text

**Best Practice:**
> Use cache for CLI convenience during active sessions.  
> Use store only in private/local environments (not in team or production machines).  
> On GitHub, it’s better to use Personal Access Tokens (PATs).  



# 10. `git gc` – Garbage collection and repository cleanup
**Purpose:** Cleans up unnecessary files and optimizes the local repository.
**Syntax:**  
```bash
git gc
```
> Useful when your local repo is growing in size unnecessarily.


**Example:**  
You notice your `.git/` folder is huge due to:
1. Frequent rebasing
2. Lots of deleted branches
3. Big binary files added and removed

Run:
```bash
git gc
```
Git will:
- Compress objects
- Remove old data
- Repack the repo efficiently

Force full cleanup:
```bash
git gc --aggressive
```
> Use this when you've removed a lot of big files, and `.git/` is still bloated.
> Tip: Run git gc occasionally in large or old repos to improve performance and reduce size.

# BONUS: Combine Commands Smartly  
```bash
git checkout -b feature-xyz && git push -u origin feature-xyz
```
> Creates a branch and pushes it — handy in real projects.

## Summary:
| Command       | Purpose                                               |
| ------------- | ----------------------------------------------------- |
| `rebase`      | Clean history, apply commits on top of another branch |
| `cherry-pick` | Pick specific commit from anywhere                    |
| `tag`         | Label a specific commit (like a release)              |
| `bisect`      | Binary search to find bug-introducing commit          |
| `blame`       | See line-wise commit responsibility                   |
| `revert`      | Undo a commit safely in public history                |
| `reflog`      | Recover deleted commits                               |
| `archive`     | Export codebase as `.zip`                             |
| `credential`  | Store GitHub login credentials                        |
| `gc`          | Optimize your Git repo                                |

