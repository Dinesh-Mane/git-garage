# GIT — Version Control System
## What is Git?
Git is a distributed version control system (VCS) that helps track changes in source code during software development. It allows multiple developers to collaborate, manage history, create branches, and roll back changes efficiently.

| Feature                      | Centralized VCS (e.g., SVN)                        | Distributed VCS (e.g., Git)                              |
| ---------------------------- | -------------------------------------------------- | -------------------------------------------------------- |
| **Repository location**      | Only one central repository on a server            | Every developer has a full copy of the repository        |
| **Internet requirement**     | Required for most actions (commits, logs, updates) | Not required for local actions (commit, diff, log)       |
| **Speed**                    | Slower (depends on server communication)           | Faster (all operations are local)                        |
| **Backup & fault tolerance** | If server is down, no one can work                 | Developers can work independently even if server is down |
| **Commit behavior**          | Commits go directly to the central server          | Commits are local first, then pushed to remote           |
| **Access to history**        | Must fetch from central server                     | Full commit history is available locally                 |
| **Examples**                 | SVN, CVS, Perforce                                 | Git, Mercurial, Bazaar                                   |

> SVN = Apache Subversion  
> CVS = Concurrent Versions System

## Why Git?
1. Tracks every version of your code.
2. Allows multiple developers to work simultaneously.
3. Enables branching, merging, and rollbacks.
4. Works offline and is fast.

## Git Basic Commands
| Task                | Command                                      | Description                                 |
| ------------------- | -------------------------------------------- | ------------------------------------------- |
| Initialize a repo   | `git init`                                   | Starts a Git repo in a directory            |
| Check status        | `git status`                                 | Shows changes (staged, unstaged, untracked) |
| Add changes         | `git add <file>` or `git add .`              | Stages files for commit                     |
| Commit changes      | `git commit -m "message"`                    | Saves staged changes with a message         |
| View commit history | `git log`                                    | Shows the history of commits                |
| View short log      | `git log --oneline`                          | Short version of log                        |
| See diff            | `git diff`                                   | Shows changes not yet staged                |
| Create branch       | `git branch <name>`                          | Creates a new branch                        |
| Switch branch       | `git checkout <name>` or `git switch <name>` | Switches to another branch                  |
| Merge branch        | `git merge <branch>`                         | Merges given branch into current            |
| Delete branch       | `git branch -d <name>`                       | Deletes a branch                            |
---

# GitHub — Remote Hosting Platform
## What is GitHub?
GitHub is a remote code hosting platform for version control using Git.  
It allows collaboration, pull requests, and project management features.  

### GitHub Key Features:
1. Repositories (Public & Private)
2. Issues, Wiki, Actions (CI/CD)
3. Pull Requests (PRs)
4. Forking and Cloning
5. GitHub Pages (for hosting static websites)

### Common GitHub Terms
| Term           | Description                            |
| -------------- | -------------------------------------- |
| Repository     | Project folder in GitHub               |
| Clone          | Download repo to your local system     |
| Fork           | Copy of a repo under your account      |
| Pull Request   | Propose changes to someone else's repo |
| Issue          | Raise a bug, task, or enhancement      |
| GitHub Actions | Built-in CI/CD tool                    |
| Gist           | Share code snippets                    |

## Git + GitHub Workflow
```bash
# Step 1: Create repo on GitHub
# Step 2: On local machine

git clone <repo-url>            # Clones GitHub repo locally
cd <repo-name>                  # Enter directory
touch file.py                   # Create a file
git add file.py                 # Stage the file
git commit -m "added file"      # Commit the change
git push origin main            # Push to GitHub
```

## Git and GitHub Real-Life Usage in DevOps
| Use Case               | Tool                            | Explanation               |
| ---------------------- | ------------------------------- | ------------------------- |
| CI/CD Pipelines        | GitHub + Jenkins/GitHub Actions | Code triggers build       |
| Infrastructure as Code | Terraform stored in Git         | Track infra changes       |
| Collaboration          | GitHub Pull Requests            | Teams review code         |
| Backup                 | GitHub                          | Remote secure storage     |
| Rollback               | Git                             | Revert to stable versions |

---
# Q&A
### What is the difference between Git and GitHub?
1. Git is a local tool used to manage code versions.
2. GitHub is a remote cloud platform (based on Git) used for hosting repositories online, enabling collaboration, pull requests, issues, and CI/CD.

### What is the difference between `git fetch` and `git pull`?
| Command     | Description                                                                  |
| ----------- | ---------------------------------------------------------------------------- |
| `git fetch` | Downloads changes from remote, **but doesn't merge them**                    |
| `git pull`  | Downloads and **merges** the remote changes into your branch (fetch + merge) |

### What are Git branches?
Branches in Git allow you to work on features, bug fixes, or experiments in isolation.  
The default branch is usually `main` or `master`.  
```bash
git branch feature-x     # create branch
git checkout feature-x   # switch to branch
git merge feature-x      # merge into current branch
```
