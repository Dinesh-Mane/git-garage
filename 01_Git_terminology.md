# Three Main Git Areas (States)
```sql
        ┌─────────────┐       git add        ┌────────────┐       git commit       ┌───────────────┐
        │ Working Dir │ ───────────────────► │Staging Area│  ────────────────────► │ Git Repository│
        └─────────────┘                      └────────────┘                        └───────────────┘
```

# 1. Untracked
**Definition:** A file that exists in your working directory but is not being tracked by Git.  
**Example:** Let’s say you just created a new file:
```bash
touch hello.py
```
Now check status:
```bash
git status
```
Output:
```bash
Untracked files:
  (use "git add <file>" to include in what will be committed)
        hello.py
```
> This means Git doesn’t know this file yet. You need to `git add` it if you want to start tracking it.

# 2. Tracked (but Modified)
**Definition:** A file that is already being tracked by Git, but its content has changed after the last commit.  
**Example:** You had this file committed earlier:
```bash
git add script.sh
git commit -m "Add script"
```
Now you change something in `script.sh`:
```bash
echo "echo Hello" >> script.sh
```
Then:
```bash
git status
```
Output:
```bash
Changes not staged for commit:
  (use "git add <file>" to update what will be committed)
        modified:   script.sh
```
> This is a modified file — you changed it but haven’t staged it yet.



# 3. Staged
**Definition:** A file whose current version is ready to be committed (you’ve added it to the staging area using `git add`).  
**Example:**
```bash
git add script.sh
git status
```
Output:
```bash
Changes to be committed:
        modified:   script.sh
```
> This file is now staged — Git has taken a snapshot, and it's ready for the next commit.



# 4. Committed
**Definition:** A file that’s saved in Git’s local repository history. It means you’ve finalized the version.  
**Example:**
```bash
git commit -m "Update script with Hello message"
```
Now:
```bash
git status
```
Output:
```bash
nothing to commit, working tree clean
```
> This means everything is committed and synced with your local `.git` repo.

## Summary:
| State     | Meaning                                                               |
| --------- | --------------------------------------------------------------------- |
| Untracked | File not added to Git yet                                             |
| Modified  | File changed after last commit, but not staged                        |
| Staged    | File is staged and ready to be committed                              |
| Committed | File snapshot saved in Git’s history                                  |
| Tracked   | Git is keeping an eye on this file (can be modified/staged/committed) |


# The Full Cycle with One File
#### Step 1: Create a new file
```bash
echo "print('Hi')" > greet.py
```

#### Step 2: Check its status
```bash
git status
```
Output:
```bash
Untracked files: greet.py
```
#### Step 3: Stage the file
```bash
git add greet.py
```

#### Step 4: Check status again
```bash
git status
```
Output:
```bash
Changes to be committed: greet.py
```

#### Step 5: Commit it
```bash
git commit -m "Add greet script"
```

#### Step 6: Modify it
```bash
echo "print('Bye')" >> greet.py
```
#### Step 7: Git sees it as modified
```bash
git status
```
Output:
```bash
Modified: greet.py
```

