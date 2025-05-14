# Real-world Git Scenarios
## 1. Broken Merges
A broken merge happens when Git tries to automatically merge two branches, but it cannot reconcile differences between them. The result is either:
1. A failed merge with conflicts that you must resolve.
2. A broken or broken code state after the merge, where something is merged incorrectly.

**Scenario:** You try to merge a feature branch into `main`, but the merge breaks the code.  
Let’s say you’re working on a feature branch, feature/login-form, and you try to merge it into main, but there are errors in the merge.  
**Steps to Fix Broken Merges:**  
1. Attempt the Merge (you notice it’s broken):
```bash
git checkout main
git pull origin main  # Ensure you're up-to-date
git merge feature/login-form
```
2. Git reports a conflict:
   - Git will stop and report the conflict files
   - Open these files to inspect the code
   - The conflicting sections will be marked like this:
```bash
<<<<<<< HEAD
// Code in the main branch
=======
// Code in the feature branch
>>>>>>> feature/login-form
```
3. Manually resolve the conflict:
   - You need to decide which changes to keep. You may:
     - Keep code from `feature/login-form`
     - Keep code from main
     - Combine the changes logically
   - After fixing, remove the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)

4. Mark the conflict as resolved: `git add conflicted-file.js`
5. Commit the merge:
   - After all conflicts are resolved and added, commit the merge: `git commit -m "Resolved merge conflict between main and feature/login-form"`
6. Push the merged code: `git push origin main`

---

## 2. Solving Merge Conflicts (Practical Example)
Merge conflicts occur when two developers have edited the same lines in the same file differently. Git can’t decide which change to keep, and you must manually resolve it.

**Scenario:** You and your teammate are working on the same file, `app.js`
- You modify `app.js` on your branch (`feature-login`)
- Your teammate modifies the same section of `app.js` on `feature-dashboard`

You try to merge feature-dashboard into feature-login, and Git reports a conflict.

#### How to Resolve the Conflict:
1. Checkout your branch: `git checkout feature-login`
2. Pull the latest changes from the main branch or your teammate’s branch:
```bash
git fetch origin
git merge feature-dashboard
```
> Git shows you a conflict in `app.js`

3. Open `app.js` to resolve the conflict:
```javascript
<<<<<<< HEAD
// Your changes in feature-login
const user = getUser();
=======
// Your teammate's changes in feature-dashboard
const user = getCurrentUser();
>>>>>>> feature-dashboard
```
4. Resolve the conflict by editing the code logically:
```javascript
// After resolving
const user = getUser() || getCurrentUser();
```
5. Stage the resolved file: `git add app.js`
6. Complete the merge: `git commit -m "Resolved merge conflict between feature-login and feature-dashboard"`
7. Push the changes: `git push origin feature-login`

---

# 3. Rebasing in Teams
Rebasing is a process where you reapply your changes on top of another branch, such as main. It helps maintain a clean history by avoiding merge commits.  
However, rebasing in a team setting requires caution. If multiple people are working on the same branch, rebasing can cause issues for others.  

**Scenario:** You have feature/login-form, and you want to keep your branch up-to-date with main. The team is also working on main.

#### Steps for Rebasing:
1. Checkout your feature branch: `git checkout feature/login-form`
2. Fetch the latest changes from the remote: `git fetch origin`
3. Rebase your feature branch onto main: `git rebase origin/main`
4. Handling conflicts during rebase:
   - If there are conflicts, Git will pause and show which files are in conflict
   - Manually resolve the conflicts in the files
Example:
```text
<<<<<<< HEAD
// Code in feature/login-form
=======
// Code in main
>>>>>>> main
```
5. Mark conflicts as resolved: `git add resolved-file.js`
6. Continue the rebase: `git rebase --continue`
7. Push the rebased branch: After rebasing, you may need to force-push because the commit history has changed:
   - `git push origin feature/login-form --force`

**Important Note:**
1. Never rebase shared branches unless absolutely necessary. If you rebase a branch that someone else is also working on, it rewrites history and creates problems for their local copies.
2. Rebasing is great for personal branches, but once a branch is pushed to a shared remote (like main or develop), it’s better to merge instead of rebase.

---

## Best Practices for Handling Merge Conflicts and Rebasing
**1. Communication is Key:**
   - Before merging or rebasing, always coordinate with your team
   - Communicate about feature work and potential conflicts early in the process

**2. Small Commits:** Make small, incremental commits. They are easier to review and resolve conflicts in  
**3. Rebase Frequently (on personal branches):** Rebase your branch on main frequently to avoid conflicts building up  
**4. Resolve Conflicts Manually:** Don’t trust Git’s automatic merges — review changes manually  
**5. Avoid Force-pushing:** Only force-push if necessary, after rebasing or re-writing commit history. Always coordinate with your team if you do.  


**Q1: What do you do when there’s a merge conflict?**
A: When a merge conflict occurs, I first stop and carefully inspect the conflicting files. Git will mark conflicting sections, and I resolve those by choosing the correct version of the code or combining both changes logically. After resolving the conflict, I stage the files with git add and then commit the merge. If the merge is part of a rebase, I continue the rebase process and push the final result. I also communicate with my team to avoid overwriting each other’s work.

