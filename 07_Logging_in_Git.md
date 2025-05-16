# What is `git log`?
`git log` is used to view the commit history in a Git repository. By default, it shows the most recent commits at the top in reverse chronological order.

# `git log` Usage
## 1. View Full Commit History
**Scenario:**  "I just cloned a repository and want to see everything that has happened so far—every commit, by every author, with full details."

**Operation:**
```bash
git log
```
**Explanation:** This shows complete commit history, in reverse chronological order (latest commit at top), with:
1. full SHA (commit hash),
2. author name & email,
3. commit date,
4. commit message.

**Example Output:**
```bash
commit 91b2ac4d1a9e2bca4785b6e1e8fcaca1d3eaa1b2
Author: Rahul Sharma <rahul@dev.com>
Date:   Fri May 16 10:00:00 2025

    Added monitoring script for EC2 disk usage

commit 7f8c9b12a1f97ef3ee444a31a9d45672857f61f7
Author: Priya <priya@dev.com>
Date:   Thu May 15 08:30:00 2025

    Updated Jenkinsfile to include sonar scan

commit 123abc456def789ghi000xyz
Author: Rahul Sharma <rahul@dev.com>
Date:   Wed May 14 20:00:00 2025

    Initial commit
```
**Use Case:** You’re auditing all work done so far on a DevOps pipeline, especially before a deployment.

---

## 2. View Limited Number of Commits
**Scenario:** "The history is too long. I only want to check what were the last 3 changes made before this deployment."

**Operation:**
```bash
git log -n 3
```
**Explanation:** The `-n` flag restricts the log to last `n` commits only.

**Example Output (assuming n = 3):**
```bash
commit 91b2ac4d1a9e2bca4785b6e1e8fcaca1d3eaa1b2
Author: Rahul Sharma
Date:   Fri May 16 10:00:00 2025

    Added monitoring script for EC2 disk usage

commit 7f8c9b12a1f97ef3ee444a31a9d45672857f61f7
Author: Priya
Date:   Thu May 15 08:30:00 2025

    Updated Jenkinsfile to include sonar scan

commit 123abc456def789ghi000xyz
Author: Rahul Sharma
Date:   Wed May 14 20:00:00 2025

    Initial commit
```
**Use Case:** Quick check before making a hotfix — to avoid repeating the same work.
> if we want to see last 3 commits with diff : `git log -p -2`

---

## 3. Compact One-Line Output
**Scenario:** "I want a compressed view of all commits for a quick scroll or branch decision-making."

**Operation:**
```bash
git log --oneline
```
**Explanation:** It compresses each commit to:
- Short SHA (first 7 characters),
- Commit message (single line).

**Example Output :**
```bash
91b2ac4 Added monitoring script for EC2 disk usage
7f8c9b1 Updated Jenkinsfile to include sonar scan
123abc4 Initial commit
```
**Use Case:** Before rebasing or merging, you want a fast overview of history.

---

## 4. Author-Based Filtering
**Scenario:** "Show me all commits made by Rahul. I want to check what changes he made in the CI/CD setup."

**Operation:**
```bash
git log --author="Rahul"
```
**Explanation:** Filters commit logs by author name or email, partial match allowed.

**Example Output :**
```bash
commit 91b2ac4d1a9e2bca4785b6e1e8fcaca1d3eaa1b2
Author: Rahul Sharma <rahul@dev.com>
Date:   Fri May 16 10:00:00 2025

    Added monitoring script for EC2 disk usage

commit 123abc456def789ghi000xyz
Author: Rahul Sharma <rahul@dev.com>
Date:   Wed May 14 20:00:00 2025

    Initial commit
```
**Use Case:** In team audits or code reviews, filter individual contributions.
> You can also use: `git log --author="rahul@dev.com"`

---

## 5. Message Search (Grep in Commit Messages)
**Scenario:** "I want to find all commits where the user registration feature was mentioned."

**Operation:**
```bash
git log --grep="register"
```
**Explanation:** Searches only the commit messages (not file contents or diffs).

**Example Output :**
```bash
commit 876cde1
Author: Priya <priya@dev.com>
Date:   Mon May 13 12:00:00 2025

    Refactored register user logic

commit 543fab3
Author: Rahul <rahul@dev.com>
Date:   Sat May 10 14:45:00 2025

    Added user register API in auth microservice
```
**Use Case:** Trace the evolution of a feature like user registration across commits.
> You can combine with `--author` or `--oneline` for tighter filters.

---

## 6. View with File Changes Summary
**Scenario:** "I want to quickly review what files changed in each commit, and how many lines were added or removed, without looking at full diffs."

**Operation:**
```bash
git log --stat
```
**Explanation:** This command shows a summary of changes per commit — specifically:
- Files modified
- How many lines added (`+`)
- How many lines removed (`-`)
- A total change summary at the end

**Example Output :**
```bash
commit 9ab123c
Author: Rahul
Date:   May 16 2025

    Refactored login function

 login.py     | 6 +++---
 utils/auth.py | 2 +-

 2 files changed, 4 insertions(+), 4 deletions(-)
```
**Use Case:** You’re reviewing if critical files like `Dockerfile`, `Jenkinsfile`, or `terraform.tf` were touched before a release.

---

## 7. View Actual Code Changes
**Scenario:** "I want to see exact line-by-line changes in each commit (like a full diff or patch view)."

**Operation:**
```bash
git log -p
```
**Explanation:** `-p` shows the diff patch for every commit — exactly what lines were added (`+`) or removed (`-`), along with context lines.

**Example Output :**
```bash
commit 9ab123c
Author: Rahul
Date:   May 16 2025

    Refactored login function

diff --git a/login.py b/login.py
index e69de29..4b825dc 100644
--- a/login.py
+++ b/login.py
@@ def login():
-   if username == "admin":
+   if user == "admin":
        return True
```
**Use Case:** While debugging a CI pipeline, you need to verify exactly what change broke it — line-by-line.
> if we want to see last 3 commits with diff : `git log -p -2`  
> Combine with --author or --since to limit scope.  

---

## 8. Filter by Date
**Scenario:** "I want to list all the commits made this year only."

**Operation:**
```bash
git log --since="2025-01-01" --until="2025-12-31"
```
**Explanation:** 
- `--since`: start date
- `--until`: end date
  Both filters apply to commit dates.

You can also use relative terms:
```bash
git log --since="2 weeks ago"
git log --since="yesterday"
```

**Example Output :**
```bash
commit 9ab123c
Author: Priya
Date:   Jan 14 2025

    Added caching to Redis layer

commit f3d4c29
Author: Rahul
Date:   Mar 22 2025

    Updated S3 bucket policy
```
**Use Case:** You’re generating a monthly/quarterly report for stakeholder review, or investigating recent hotfixes.

---

## 9. Filter by File
**Scenario:** "What changes were made to `app.py` over time?"

**Operation:**
```bash
git log app.py
```
**Explanation:** Only shows commits that modified the given file, ignoring others.

**Example Output :**
```bash
commit a4567de
Author: Rahul
Date:   May 12 2025

    Fixed null check in app.py

commit c7898fe
Author: Priya
Date:   May 6 2025

    Added REST endpoint in app.py
```
**Use Case:** You’re debugging a specific file’s behavior, or doing file-level blame.
> Combine with `--stat` or `-p`: `git log -p app.py`

---

## 10. Track File After Rename
**Scenario:** "This file was renamed from `user_api.py` to `auth_api.py`. I still want to see the full history."

**Operation:**
```bash
git log --follow old_name.py
```
**Explanation:** `--follow` lets Git trace the file across renames, giving the full commit history as if it were one file.

**Example Output :**
```bash
commit 234abc9
Author: Rahul
Date:   May 1 2025

    Renamed user_api.py to auth_api.py

commit 19fabc2
Author: Rahul
Date:   Apr 25 2025

    Added JWT support in user_api.py
```
**Use Case:** After refactoring or renaming files (common in large apps), you still want to maintain full history

---

## 11. Graphical Branch View
**Scenario:** "I want a visual representation of my branches to understand how they diverge and merge."

**Operation:**
```bash
git log --oneline --graph --all --decorate
```
**Explanation:** This command gives a graphical commit tree of all branches:
- `--oneline`: Compact SHA + message
- `--graph`: ASCII graph of commit history
- `--all`: Includes all branches (not just current)
- `--decorate`: Shows branch/tag names

**Example Output :**
```bash
* a1b2c3 (HEAD -> main) Add user auth
| * d3f4e5 (feature) Add tests
|/
* e5f6a7 Init repo
```
**Use Case:** Before merging, you want to:
- Visualize branch status
- Understand if a branch is already merged
- Spot diverging changes

> Useful during release management, rebasing, or cleanup.

---

## 12. Only Merges
**Scenario:** "Show me only the merge commits so I can track when branches were merged."

**Operation:**
```bash
git log --merges
```
**Explanation:** Filters the history to only commits that are merges, i.e., those that have multiple parents.

**Example Output :**
```bash
commit c123abc
Merge: a1b2c3 d3f4e5
Author: Rahul
Date:   May 15 2025

    Merge branch 'feature' into main
```
**Use Case:** You're conducting a sprint retrospective or doing a merge conflict audit, and need to track:
- When features were integrated
- Who did the merges
- Merge frequency

> Combine with `--oneline` for compact view: `git log --oneline --merges`

---

## 13. Exclude Merge Commits
**Scenario:** "Ignore merge commits, and show only actual individual changes."

**Operation:**
```bash
git log --no-merges
```
**Explanation:** Opposite of `--merges`. It skips all merge commits to focus purely on commits with real content/code changes.

**Example Output :**
```bash
commit d3f4e5
Author: Priya

    Added user registration API
```
**Use Case:** You’re doing a code contribution analysis and want to focus on:
- Actual feature work or bug fixes
- Avoiding noisy merge entries

> Combine with date filter: `git log --no-merges --since="2025-01-01"`

---

## 14. View Specific Commit
**Scenario:** "I want to inspect a particular commit — code changes, author, time, and message."

**Operation:**
```bash
git show <commit_hash>
```
**Explanation:** Displays full detail of a specific commit:
- Author & date
- Message
- Complete file diff

**Example :**
```bash
git show a1b2c3
```
**Output :**
```bash
commit a1b2c3
Author: Rahul
Date:   May 16 2025

    Add user authentication module

diff --git a/app.py b/app.py
+ def authenticate_user():
+     pass
```
**Use Case:** Someone reports a bug introduced in a commit — you use this to audit exactly what was done.

> Combine with `git log` to get hash:

```bash
git log --oneline
git show <sha>
```

---

## 15. Commits Between Two SHAs
**Scenario:** "What changed between two specific commits?"

**Operation:**
```bash
git log <start_sha>..<end_sha>
```
**Explanation:** Shows all commits that are:
- In `<end_sha>` but
- Not reachable from `<start_sha>`

**Example :**
```bash
git log abc123..def456
```
**Output :**
```bash
commit def456
Author: Rahul

    Added S3 sync script

commit dd3344
Author: Priya

    Fixed pipeline retry logic
```
**Use Case:** You want to review changes made in a feature branch before merging it: `git log main..feature_branch`

> Combine with `--oneline`, `--stat`, or `--patch`:
```bash
git log abc123..def456 --stat
git log abc123..def456 -p
```

---

## 16. Commits on a Branch
**Scenario:** "Show all commits that are part of the `dev` branch history."

**Operation:**
```bash
git log dev
```
**Explanation:** This command displays the commit history of a specific branch (`dev`), even if you're currently on another branch like `main`.  
You can also do: `git log origin/dev` To see the remote branch history.

**Example Output :**
```bash
commit 91c3b4d
Author: Priya
Date:   May 14 2025

    Refactored user module
```
**Use Case:** You're reviewing the dev branch before:
- Merging to main
- Deploying to staging
- Creating a pull request

---

## 17. Commits Unique to One Branch
**Scenario:** "I want to see which commits exist in feature but not in `main`."

**Operation:**
```bash
git log feature ^main
```
**Explanation:**  
- `feature`: Target branch to inspect
- `^main`: Excludes commits also in main

This helps you compare branches and view what's exclusive to one.

**Example Output :**
```bash
commit a3f2b1c
Author: Rahul
Date: May 15

    Added advanced search feature
```
**Use Case:** You are preparing a pull request for feature into main, and you want to:
- Review the delta (difference)
- Audit unmerged commits
- Validate CI/CD changes

Tip: You can use `git log feature --not main` too.

---

## 18. Custom Format Output
**Scenario:** "I need a readable, clean summary of the commit logs — maybe for reports or a dashboard."

**Operation:**
```bash
git log --pretty=format:"%h - %an, %ar : %s"
```
**Explanation:** The --pretty=format: option allows you to define exact output:
- `%h`: Short SHA
- `%an`: Author name
- `%ar`: Relative date (e.g., 2 days ago)
- `%s`: Commit message

**Example Output :**
```bash
f3d4c29 - Rahul, 2 days ago : Added feature X
a1b2c34 - Priya, 5 days ago : Refactored API calls
```
**Use Case:**  
- Creating a changelog
- Making CI/CD logs more readable
- Sending reports via script

Tip: You can redirect to a file: `git log --pretty=format:"%h - %s" > history.txt`

---

## 19. Search by Code Changes
**Scenario 1 (Exact String):** "I want to know when the string authToken was added, modified, or removed."

**Operation:**
```bash
git log -S"authToken"
```
**Explanation:**  
- `-S` searches commits whose diffs added or removed the given string.
- It’s a semantic search, not just in messages.

**Output :**
```bash
commit b123abc
Author: Rahul
Message: Added authToken check
```

**Scenario 2 (Pattern Match):** "Find all commits where a `login` function was defined using regex."  
**Operation**
```bash
git log -G'def .*login'
```
**Explanation:**  
- `-G` lets you regex match inside diffs
- Use it to find structural patterns like `def`, `class`, `try:`, etc.

**Output :**
```bash
commit d23fc44
Author: Priya
Message: Implemented def user_login(...)
```
**Use Case:**  
- Auditing security-sensitive code
- Finding when something was introduced or removed
- Searching by function or variable name

---

## 20. Blame for Line Author
**Scenario:** "Who wrote this line in the `login.py` file, and when?"

**Operation:**
```bash
git blame login.py
```
**Explanation:**  
- Shows line-by-line annotation of the file
- For each line: commit SHA, author, date, and code line


**Example Output :**
```bash
^a1b2c3 (Rahul 2025-05-14 12:00:00 +0530  12) def login_user(request):
```
**Use Case:**  
- Identifying who introduced a bug
- Tracing last update to a function
- Accountability in regulated environments (e.g., finance, healthcare)

> Combine with `-L` to limit to specific lines: `git blame -L 10,20 login.py`

---

## 21. Interactive View (TUI)
**Scenario:** "I want a GUI-like view in terminal to explore Git history, branches, diffs, and files."

**Operation:**
```bash
tig
```
**Explanation:**  
- `tig` is a Text User Interface (like `htop` for Git)
- You can scroll, filter, view branches, diffs, stages, and even blame

Optional install:
```bash
sudo apt install tig   # Debian/Ubuntu
brew install tig       # macOS
```
Features:
- View logs interactively
- Press Enter on a commit to see the diff
- Navigate between branches and commits

**Example Output :**
```bash
^a1b2c3 (Rahul 2025-05-14 12:00:00 +0530  12) def login_user(request):
```
**Use Case:**  
- Easier to navigate large repos
- Saves time for developers during code review
- Ideal for live debugging in terminal

---

# Summary Table

| #  | Command                     | What It Does          | Ideal Use Case               |
| -- | --------------------------- | --------------------- | ---------------------------- |
| 01 | `git log`                   | Full commit info      | Full history, audit trail    |
| 02 | `git log -n 3`              | Limit to 3 commits    | Recent history check         |
| 03 | `git log --oneline`         | Compact view          | Quick scroll through history |
| 04 | `git log --author="Rahul"`  | Filter by contributor | Track individual’s work      |
| 05 | `git log --grep="register"` | Search messages       | Find feature-related commits |
| 06 | `git log --stat`              | Summary of file changes    | See what files were impacted |
| 07 | `git log -p`                  | Full line-by-line diff     | Debug exact code changes     |
| 08 | `git log --since` / `--until` | Date-based filtering       | Reports, audits              |
| 09 | `git log <file>`              | File-specific history      | Debug or analyze one file    |
| 10 | `git log --follow <file>`     | Track renamed file history | Full trace after refactor    |
| 11 | `git log --oneline --graph --all --decorate` | Shows commit tree across branches  | Visualize branching and merging        |
| 12 | `git log --merges`                           | Only shows merge commits           | Identify when features were merged     |
| 13 | `git log --no-merges`                        | Excludes merge commits             | Focus on individual work               |
| 14 | `git show <SHA>`                             | View one commit's details and diff | Investigate a specific change          |
| 15 | `git log SHA1..SHA2`                         | List commits between two SHAs      | Review changes across commits/branches |
| 16 | `git log branch_name`           | Show commits of specific branch    | Review feature/dev branch before merging |
| 17 | `git log feature ^main`         | Show unique commits in `feature`   | Prepare pull requests or code reviews    |
| 18 | `git log --pretty=format:"..."` | Customize log output               | Create readable reports or changelogs    |
| 19 | `git log -S/-G`                 | Search in diffs by string or regex | Trace variable or function origin        |
| 20 | `git blame file.py`             | Show who changed each line         | Debugging or auditing line authors       |
| 21 | `tig`                           | Terminal GUI for Git               | Navigate history and diffs easily        |

