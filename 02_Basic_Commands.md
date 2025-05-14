# 1. `git config`
**Purpose:** Set Git configuration options like username, email, aliases     
**Syntax:**  
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --list
```
**Example:**
```bash
git config --global user.name "Dinesh Mane"
git config --global user.email "dinesh@gmail.com"
```
> Git uses this info to label your commits


# 2. `git init`
**Purpose:** Initialize a new Git repository in your current folder.  
**Syntax:**  
```bash
git init
```
**Example:**
```bash
mkdir my-project
cd my-project
git init
```
> This creates a hidden `.git/` directory, turning your folder into a Git repository.

# 3. `git clone`
**Purpose:** Make a full copy of a remote repository to your local machine  
**Syntax:**  
```bash
git clone <repository-url>
```
**Example:**
```bash
git clone https://github.com/user/my-project.git
```
> It creates a local folder `my-project` with full Git tracking + history from GitHub.


# 4. `git status`
**Purpose:** Show which files have been modified, staged, or untracked     
**Syntax:**  
```bash
git status
```
**Example Output:**
```bash
On branch main
Changes not staged for commit:
  modified:   index.html

Untracked files:
  script.js
```
> Use this before committing to see the current state of your repo.

# 5. `git add`
**Purpose:** Move changes to the staging area, preparing for commit     
**Syntax:**  
```bash
git add <filename>     # single file
git add .              # all files in current directory
git add -A             # add all (including deletes)
```
**Example:**
```bash
git add index.html
git add .
```
> This stages the files, but doesn't save them in history yet


# 6. `git commit`
**Purpose:** Save staged changes to local history with a message     
**Syntax:**  
```bash
git commit -m "Your meaningful message"
```
**Example:**
```bash
git commit -m "Added contact form to footer"
```
> This creates a snapshot in Git history


# 7. `git pull`
**Purpose:** Fetch and merge latest changes from a remote branch     
**Syntax:**  
```bash
git pull origin main
```
**Example:**
```bash
git pull
```
> Gets the latest code from GitHub and merges it with your local repo


# 8. `git push`
**Purpose:** Upload your commits to the remote repository (like GitHub)  
**Syntax:**  
```bash
git push origin <branch-name>
```
**Example:**
```bash
git push origin main
```
> Others can now see and use your changes


# 9. `git branch`
**Purpose:** Manage branches in your project  
**Syntax:**  
```bash
git branch               # list branches
git branch <new-name>    # create new branch
git branch -d <name>     # delete branch
```
**Example:**
```bash
git branch feature/login
```
> Branches let you work on features independently.


# 10. `git checkout`
**Purpose:** Switch to a different branch or file version  
**Syntax:**  
```bash
git checkout <branch>
git checkout -b <new-branch>     # create + switch
```
**Example:**
```bash
git checkout -b feature/header
```
> You are now working in a new branch for a separate task


# 11. `git merge`
**Purpose:** Merge another branch into your current branch  
**Syntax:**  
```bash
git merge <branch>
```
**Example:**
```bash
git merge feature/header
```
> Combines changes from `feature/header` into your current branch (e.g., `main`).


# 12. `git log`
**Purpose:** Show the commit history of the repo.  
**Syntax:**  
```bash
git log
git log --oneline
git log --graph --all --decorate
```
**Example:**
```bash
git log --oneline --graph
```
> Helpful to see past work, author, commit ID, and branching


# 13. `git reset`
**Purpose:** Unstage changes or undo commits  
**Syntax:**  
```bash
git reset <file>               # unstage
git reset --soft HEAD~1        # keep changes, undo commit
git reset --hard HEAD~1        # delete commit + changes
```
**Example:**
```bash
git reset --soft HEAD~1
```
> Dangerous but useful for undoing mistakes.

# 14. `git clean`
**Purpose:** Remove untracked files from the working directory  
**Syntax:**  
```bash
git clean -n   # preview
git clean -f   # force delete
```
**Example:**
```bash
git clean -f
```
> Cleans up temporary or ignored files


# 15. `git remote`
**Purpose:** Manage connections to remote repositories  
**Syntax:**  
```bash
git remote -v               # show remotes
git remote add origin URL   # add new remote
```
**Example:**
```bash
git remote add origin https://github.com/user/my-repo.git
```
> Needed to push/pull code to/from GitHub


# 16. `git stash`
**Purpose:** Temporarily save changes without committing  
**Syntax:**  
```bash
git stash
git stash pop
```
**Example:**
```bash
git stash          # hide changes
git pull origin main
git stash pop      # bring them back
```
> Great for switching branches without losing work

