# 1. Basic Git Setup
```bash
git config --global user.name "Your Name"       # Set global username
git config --global user.email "you@email.com"  # Set global email
git config --list                               # List all configs
```
# 2. Repository Commands
```bash
git init                    # Initialize a local repo
git clone <repo_url>        # Clone remote repo
git clone -b <branch> <url> # Clone specific branch
```
# 3. File Stage & Commit
```bash
git status                  # Check repo state
git add <file>              # Stage a file
git add .                   # Stage all changes
git commit -m "Message"     # Commit with message
git commit -am "Message"    # Add + commit tracked files
```
# 4. Branching
```bash
git branch                  # List branches
git branch <new-branch>     # Create new branch
git checkout <branch>       # Switch to branch
git checkout -b <branch>    # Create & switch
git branch -d <branch>      # Delete branch (safe)
git branch -D <branch>      # Force delete
```
# 5. Merge & Rebase
```bash
git merge <branch>          # Merge into current branch
git rebase <branch>         # Rebase onto branch
git rebase -i HEAD~3        # Interactive rebase last 3 commits
```
# 6. Remote Repositories
```bash
git remote add origin <url>       # Add remote repo
git remote -v                     # View remote URLs
git push origin <branch>          # Push to remote
git push -u origin <branch>       # Push and set upstream
git fetch                         # Fetch from remote
git pull                          # Pull latest changes
```
# 7. Undo, Reset & Clean
```bash
git restore <file>                # Discard changes (Git 2.23+)
git checkout -- <file>            # Restore file (older Git)
git reset                         # Unstage file
git reset --hard                  # Hard reset working tree
git reset --soft HEAD~1           # Undo commit, keep changes
git clean -f                      # Remove untracked files
git revert <commit>               # Create inverse commit
```
# 8. Logs & History
```bash
git log                           # Show commit log
git log --oneline                 # One-line summary
git log --graph --all             # Graph of history
git show <commit>                 # Show specific commit
```
# 9. Tagging
```bash
git tag                           # List tags
git tag v1.0                      # Create lightweight tag
git tag -a v1.0 -m "Release 1.0"  # Annotated tag
git push origin --tags            # Push tags to remote
```
# 10. Stashing
```bash
git stash                         # Save uncommitted changes
git stash list                    # List stashes
git stash apply                   # Apply latest stash
git stash pop                     # Apply + remove
git stash drop                    # Delete a stash
```
# 11. Diff & Compare
```bash
git diff                          # See unstaged changes
git diff --staged                 # See staged changes
git diff <branch1> <branch2>      # Compare branches
git diff <commit1> <commit2>      # Compare commits
```
# 12. SSH Authentication & Config
```bash
ssh-keygen                        # Create SSH key
cat ~/.ssh/id_rsa.pub             # Show public key
```
# Add the key to GitHub/GitLab SSH settings
# 13. Cherry-pick & Bisect
```bash
git cherry-pick <commit>          # Apply single commit
git bisect start                  # Begin binary search
git bisect good <commit>          # Mark good commit
git bisect bad <commit>           # Mark bad commit
```
# 14. Advanced & Safety
```bash
git reflog                        # View all HEAD changes
git fsck                          # Check repo integrity
git gc                            # Clean up unnecessary files
git blame <file>                  # Who wrote each line?
```
# 15. Syncing & Fork Handling
```bash
git remote add upstream <url>     # Add original repo
git fetch upstream                # Fetch from original
git merge upstream/main           # Merge upstream changes
```
# 16. Submodules
```bash
git submodule add <repo_url> path         # Add submodule
git submodule init                        # Init submodules
git submodule update                      # Pull submodules
```
# 17. Git Aliases (Time-saving)
```bash
git config --global alias.st status       # git st = git status
git config --global alias.cm 'commit -m'  # git cm = git commit -m
```



-----------------------------------------------------------



# 1. Git Configuration & Setup
```bash
git config --global user.name "Your Name"         # Set username
git config --global user.email "you@example.com"  # Set email
git config --list                                 # List all config
git config --global core.editor "vim"             # Set default editor
git config --global -e                            # Edit global config file
```
# 2. Git Initialization & Basic Workflow
```bash
git init                          # Initialize new local repo
git clone <url>                   # Clone remote repo
git status                        # Show current state
git add <file>                    # Stage a file
git add .                         # Stage all changes
git commit -m "message"           # Commit staged changes
git commit -am "msg"              # Add + commit tracked files
git push                          # Push changes
git pull                          # Pull from remote
git fetch                         # Download changes without merging
```
# 3. Branching & Merging
```bash
git branch                        # List branches
git branch <name>                 # Create new branch
git checkout <name>               # Switch to branch
git checkout -b <name>            # Create and switch
git merge <branch>                # Merge into current branch
git branch -d <name>              # Delete branch (safe)
git branch -D <name>              # Force delete branch
git switch <branch>               # Modern way to switch
git switch -c <branch>            # Create + switch
```
# 4. Viewing & Logging History
```bash
git log                           # Full commit history
git log --oneline                 # Compact view
git log --graph --oneline         # Graph view
git show <commit>                 # Show a specific commit
git diff                          # Show unstaged changes
git diff --staged                 # Show staged changes
git blame <file>                  # Who changed each line
git reflog                        # History of HEAD changes
```
# 5. Resetting, Reverting, and Cleaning
```bash
git reset                         # Unstage changes
git reset --hard                  # Discard all changes
git reset --soft HEAD~1           # Undo commit but keep changes
git revert <commit>               # Reverse a commit
git clean -f                      # Remove untracked files
git clean -fd                     # Remove untracked files/directories
```
# 6. Remote Repository Management
```bash
git remote                        # Show remotes
git remote -v                     # Show remotes with URLs
git remote add origin <url>       # Add remote
git remote remove origin          # Remove remote
git push -u origin <branch>       # Push and track upstream
git push origin --delete <branch> # Delete remote branch
git fetch origin                  # Fetch changes
```
# 7. Stashing Changes (Temporary Save)
```bash
git stash                         # Save current changes
git stash list                    # Show saved stashes
git stash pop                     # Apply and remove last stash
git stash apply                   # Apply last stash
git stash drop                    # Delete last stash
```
# 8. Tags (Releases)
```bash
git tag                           # List tags
git tag v1.0                      # Create tag
git tag -a v1.0 -m "Version 1"    # Annotated tag
git show v1.0                     # Show tag info
git push origin v1.0              # Push tag
git push origin --tags            # Push all tags
git tag -d v1.0                   # Delete tag locally
git push origin :refs/tags/v1.0   # Delete remote tag
```
# 9. Submodules
```bash
git submodule add <repo> path     # Add submodule
git submodule init                # Init submodules
git submodule update              # Update submodules
```
# 10. Aliases (Shortcuts)
```bash
git config --global alias.st status        # git st
git config --global alias.co checkout      # git co
git config --global alias.br branch        # git br
git config --global alias.lg "log --oneline --graph --all"
```
# 11. SSH Setup & Credentials
```bash
ssh-keygen -t rsa -C "your@email.com"     # Generate SSH key
cat ~/.ssh/id_rsa.pub                     # View public key
```
# Add it to GitHub/GitLab SSH settings
# 12. Troubleshooting & Special Commands
```bash
git cherry-pick <commit>                  # Apply commit from other branch
git bisect start                          # Begin binary search to find bug
git archive                               # Export project as tar/zip
git grep "search term"                    # Search in Git repo files
```
# 13. GitHub Forking & Upstream
```bash
git remote add upstream <original-repo-url>   # Add upstream
git fetch upstream                            # Fetch upstream changes
git merge upstream/main                       # Merge into your fork
git push origin main                          # Push to your fork
```
