# Scenario 1: if we made any changes by mistake and saved them
I made changes to some files and saved them (i.e., modified working directory), but I haven’t staged or committed yet.  
**Let’s assume:** You changed main.py but didn’t run `git add` or `git commit`  
Now you want to handle that situation depending on what you want to achieve.

## 1. Undo all local changes (reset file to last commit)
If you want to discard your saved changes completely and go back to the last committed state:
```bash
git restore main.py
```
What happens?
- Restores `main.py` to the state of the last commit.
- Your unsaved work is lost.

Note: Use only if you're sure you don't need the changes.

## 2. Undo all changes in all files
To discard all uncommitted, unstaged changes across the entire working directory:
```bash
git restore .
```
OR
```bash
git checkout -- .
# Older Git version (pre-2.23)
```
## 3. Keep some changes, discard others
Let’s say you modified two files: `main.py` and `config.txt`.  
You want to keep `main.py` but discard `config.txt`:  
```bash
git restore config.txt
```
Only `config.txt` will be reset.

## 4. Save changes temporarily (stash)
```bash
git stash
```
This saves the changes and gives you a clean working directory. Later you can get them back using:
```bash
git stash pop     # apply and remove
# or
git stash apply   # apply but keep in stash
```

## 5. Made changes, but want to stage them now
If you realize your changes are valid and you want to continue:
```bash
git add main.py
git commit -m "Your changes"
```
Done! You decided to move forward with them.

## 6. Compare saved changes with last commit
Before discarding, you might want to see what changed:
```bash
git diff
```
This shows the differences between your current file and the last commit.  
You can even check for a specific file:  
```bash
git diff main.py
```

## 7. Recover a file even after restoring
If you accidentally discard a file with git restore and want it back but didn't commit it — **Git cannot recover it because it wasn't saved anywhere.**  

But if it was staged or committed earlier, you can get it back:  
```bash
git checkout HEAD^ -- main.py
# OR
git restore --source=HEAD~1 main.py
```
## Summary:
| Goal                                    | Command                    | Keeps Changes? | Danger Level |
| --------------------------------------- | -------------------------- | -------------- | ------------ |
| Discard changes to 1 file               | `git restore <file>`       | ❌ No           | ⚠️ Medium    |
| Discard changes to all files            | `git restore .`            | ❌ No           | ⚠️ High      |
| Save changes temporarily                | `git stash`                | ✅ Yes          | 🟢 Safe      |
| Apply saved stash                       | `git stash pop`            | ✅ Yes          | 🟢 Safe      |
| View what changed                       | `git diff`                 | ✅ Yes          | 🟢 Safe      |
| Move forward with changes (commit)      | `git add` + `git commit`   | ✅ Yes          | 🟢 Safe      |

---

# Scenario 2: If we added the changes using git add then... 
I made some changes and did git add <file> — now I want to undo, reset, or manage those changes before committing.  
#### Situation:
You have:
- Edited a file (e.g., `main.py`)
- Run: `git add main.py`

Now the file is staged, meaning it's ready to be committed.  
`git status` now shows:
```bash
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   main.py
```

## 1. Unstage the file (but keep changes)
If you just want to undo `git add` and move the file back to “modified” status:
```bash
git restore --staged main.py
```
OR older Git versions:
```bash
git reset HEAD main.py
```
What happens:
- File is still modified (your code changes are safe)
- It's no longer staged for commit

## 2. Edit the file again before committing
You can modify the file after staging. Git notices the change.
```bash
echo "extra line" >> main.py
```
Now `git status` will show:
```bash
Changes to be committed:
  modified: main.py

Changes not staged for commit:
  modified: main.py
```
This means:
- You staged one version of `main.py`
- Then changed it again
- You’ll need to run `git add main.py` again to update the staged copy

## 3. Completely discard all changes (reset staged + working copy)
If you're sure you don’t want the changes at all — not even in your working copy:
```bash
git restore --staged main.py  #jr sarv staging area madhlya files parat aanaychya asel tr: `git restore --staged .`
git restore main.py
```

OR, in older Git versions:
```bash
git reset HEAD main.py
git checkout -- main.py
```
This resets both the staged and working version.
> This is **targeted**: it affects only `main.py`, not other files.  
> Completely resets a specific file to the last commit — nothing staged, nothing changed in the working copy.

## 4. Stage changes from scratch (clean up and re-stage)
If you want to reset everything and re-stage cleanly:
```bash
git reset      # Unstage all files
git restore .  # Discard all working changes
```
Then start again.  
> This is **broad and global**: it affects all tracked files in the current directory (and subdirectories).  
> All files are unstaged. All changes are gone. Everything is back to committed state.

## 5. Stash even staged changes
If you want to switch branches or work on something else without committing, stash even the staged changes:
```bash
git stash push -m "WIP changes" --staged
```
Or simply:
```bash
git stash
```
Default `git stash` includes staged and unstaged tracked changes.  
Then later:
```bash
git stash pop
```

## 6. Commit it if satisfied
If the staging is correct and you're happy:
```bash
git commit -m "Fix issue in main.py"
```

## 7. See what exactly was staged vs unstaged
To check the staged version of your file:
```bash
git diff --cached main.py
# OR 
git diff --staged main.py   
# both works same
# shows difference between:
# 1. The staging area (your last git add version)
# 2. and the last committed version (HEAD)
```
To see what’s not staged:
```bash
git diff main.py
# shows the difference between:
# The working directory version of the file (your latest saved changes)
# and the staging area (index) version (the version you added using git add)
```
This helps you decide what to do next.  

1. **Let’s say:**  
- You edited `main.py` and did `git add main.py`
- Then edited `main.py` again after adding it

Now run: `git diff main.py` => It will show the changes you made after staging, which are currently not staged.

2. **Let’s say:**  
- You committed something
- Then made changes to main.py and did git add main.py

Now run: `git diff --cached main.py` => It shows you what will go into the next commit.

## Summary 
| Situation / Goal                | Command(s)                                           | Effect                                       |
| ------------------------------- | ---------------------------------------------------- | -------------------------------------------- |
| Unstage a file but keep changes | `git restore --staged <file>`                        | Removes from staging, working changes intact |
| Undo `git add` for all files    | `git reset`                                          | All files unstaged, changes stay             |
| Discard all changes completely  | `git restore --staged <file>` + `git restore <file>` | File is as it was in last commit             |
| Stash staged changes            | `git stash` or `git stash push --staged`             | Saves changes temporarily                    |
| Check staged diff               | `git diff --cached <file>`                           | Shows what will be committed                 |
| Commit changes                  | `git commit -m "msg"`                                | Makes snapshot in repo                       |

---

# Scenario 3: If we added the changes to staging area (didn't commit) after this added more changes to file
Let’s say you:
1. Made changes to a file (main.py)
2. Ran git add main.py → Staged it
3. Then made more changes to the same file

Now you're confused: “What do I do now? What will get committed?

#### What’s Actually Happening Internally?
When you run:
```bash
git add main.py
```
Git takes a **snapshot** of that version and stores it in the **Staging Area (Index).**  
Then, if you **edit the file again**, those changes are only in your **working directory, not yet staged.**  

### Example Setup
```bash
# Start with committed file
echo "print('Hello')" > main.py
git add main.py
git commit -m "Initial"

# Edit + stage
echo "print('Hello again')" >> main.py
git add main.py

# Edit again (after staging)
echo "print('Another change')" >> main.py
```
Now run:
```bash
git status
```
You’ll see:
```yaml
Changes to be committed:
  modified: main.py

Changes not staged for commit:
  modified: main.py
```

## 1. Re-stage the file (overwrite previous staging)
If the new change is also important, and you want it included in the commit:
```bash
git add main.py
```
Now both edits are in staging. Then commit:
```bash
git commit -m "Both changes included"
```

## 2. Commit only the first change (ignore recent edits)
If the second edit was accidental or WIP, and you want to keep it out of the commit:  
Just commit what's already staged:  
```bash
git commit -m "Only first change"
```
- Second edit remains in working directory
- `main.py` will still show as "modified" after commit

## 3. Split the changes and commit separately (Interactive)
Use git add -p to stage selectively:
```bash
git restore --staged main.py    # Optional: start fresh
git add -p main.py              # Pick only the parts you want
```
You’ll see:
```kotlin
Stage this hunk? [y,n,q,a,d,s,e,?]
```
Choose wisely:
- `y` = yes (stage this chunk)
- `n` = no (don’t stage)
- `e` = edit the hunk manually

Then commit just what you staged.

## 4. Discard only the last (unwanted) change
If you want to throw away the last change (but keep the first one which was already staged):
```bash
git restore main.py
# OR
git restore --worktree main.py
```
**This will:** 
1. Discard un-staged working directory changes
2. Keep the staged version as is (ready to commit)

Then you can:
```bash
git commit -m "Safe commit"
```

## 5. Reset everything and start over
If the situation is messy and you want to go back to last commit:
```bash
git restore --staged main.py
git restore main.py
```
> `main.py` is now exactly as it was in last commit

You can now redo the changes cleanly and re-add.  

## Summary 
| Scenario                             | What to Do           | Command                                                   |
| ------------------------------------ | -------------------- | --------------------------------------------------------- |
| Want to include all changes          | Re-add file          | `git add main.py`                                         |
| Want to keep last edit out of commit | Just commit          | `git commit -m "..."`                                     |
| Want to throw away last edit         | Restore working file | `git restore main.py`                                     |
| Want fine-grained control            | Patch staging        | `git add -p main.py`                                      |
| Want to reset completely             | Discard all          | `git restore --staged main.py` <br> `git restore main.py` |

---


# Scenario 3: I accidentally committed the wrong file (or some extra files)!
You committed something you didn't mean to, and now you want to fix it properly depending on the situation.  

### Git Internals Behind the Scenes
When you run:
```bash
git commit -m "Some message"
```
You save a snapshot of all staged files into the Git history. If that commit included:
- A wrong file (wrong.txt)
- Or wrong changes in a correct file

You now have several ways to correct that, depending on the situation.

## 1. You haven't pushed yet → Use `git reset`
If the commit is local only (not pushed), you're in full control.

**Goal:** Remove the commit completely and start fresh.
```bash
git reset HEAD~1
````
This:
- Removes the last commit
- Preserves all changes in working directory and staging area

You can now:
- Remove the wrong file
- Edit things
- Re-add only correct files
- Then re-commit

**Example:**
```bash
# Added wrong.txt by mistake
git add wrong.txt correct.py
git commit -m "Oops"

# Undo last commit
git reset HEAD~1

# Remove the wrong file
rm wrong.txt

# Re-stage correct file only
git add correct.py
git commit -m "Fixed commit"
```

## 2. You already pushed → Use git revert (safe for teams)
You can't `reset` if others may have already pulled your commit. In this case, use `git revert`  

**Goal:** Undo the changes by creating a new opposite commit
```bash
git revert <bad_commit_hash>
```
It:
- **Does NOT delete history**
- Adds a new commit that undoes the changes in that one

Find commit hash using: `git log --oneline`

**Example:**
```bash
git revert abcd1234
```
This creates a new commit that undoes what `abcd1234` did.

## 3. Commit only wrong file? Use `git reset --soft HEAD~1`
**Goal:** Bring everything back to staging area
```bash
git reset --soft HEAD~1  
```
This:
- Removes the last commit
- Keeps all files in staged area

Then:
```bash
git restore --staged wrong.txt   # Unstage wrong file
rm wrong.txt                     # Optional: delete file
git commit -m "Corrected commit"
```
> use `git reset --hard HEAD~1` if you want to completely undo a commit, unstage files, and discard local file changes (working directory too).  
> This is destructive — any unsaved code changes will be lost forever.  

### git reset – All 3 Types

| Type                  | Affects Commit | Affects Staging Area | Affects Working Directory    |
| --------------------- | -------------- | -------------------- | ---------------------------- |
| `--soft`              | ✅ Yes          | ❌ No                 | ❌ No                         |
| `--mixed` *(default)* | ✅ Yes          | ✅ Yes                | ❌ No                         |
| `--hard`              | ✅ Yes          | ✅ Yes                | ✅ Yes (⚠️ discards changes!) |



## 4. Amend the last commit if unpushed
If the commit is recent and you only want to **replace it**, use:
```bash
git reset HEAD~1
# OR
git commit --amend
```
Then remove the file from staging and re-commit.

**Example:**
```bash
git restore --staged wrong.txt
rm wrong.txt
git commit --amend
```
`--amend` just replaces the last commit without creating a new one.

## 5. Use Interactive Rebase to fix older commit (advanced)
If the bad file is committed in a previous commit (not the last one), use:
```bash
git rebase -i HEAD~3
```
Choose the commit you want to fix:
- Change pick to edit
- Then use git reset, remove the file, and re-commit

Risky if pushed and shared with others.

## Summary 
| Scenario                                     | Action                    | Command                |
| -------------------------------------------- | ------------------------- | ---------------------- |
| Unpushed wrong commit                        | Remove commit             | `git reset HEAD~1`     |
| Wrong file + commit but want to keep staging | `git reset --soft HEAD~1` |                        |
| Undo mistake after pushing                   | Revert commit             | `git revert <commit>`  |
| Fix last commit                              | Amend                     | `git commit --amend`   |
| Fix old commit                               | Interactive Rebase        | `git rebase -i HEAD~n` |
| Accidentally committed secrets               | Purge history             | `git filter-repo`      |




