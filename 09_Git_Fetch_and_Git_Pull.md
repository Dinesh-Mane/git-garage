# `git fetch origin` - Fetch Remote Changes (without merge)

#### Problem Statement:
Imagine you and your team are collaborating on a Git repository. Other team members have pushed new commits to the remote repository (e.g., GitHub).   
You want to see what changes exist on the remote before merging them into your current working branch.  
You want to download those remote updates into your local repository without modifying your current working directory files immediately.  
This helps you inspect changes first, or merge/rebase them manually later.  

#### What Does `git fetch origin` Do?
- Fetch means: Download all the updated commits, branches, tags, etc. from the remote named `origin`.
- `origin` is the default name of the remote repository URL, usually the GitHub repo you cloned from.
- It updates your local remote-tracking branches (e.g., `origin/main`, `origin/feature-xyz`) but does NOT change your local branches or working files.

#### Why Use `git fetch origin`?
- To update your local copy of the remote branches without affecting your current work.
- To see new commits added by others on the remote repository.
- To prepare for later merging or rebasing after inspecting changes.
- To avoid conflicts caused by automatic merging that happens with `git pull`.

#### How `git fetch` Differs from `git pull`?
| Command            | What it does                                              | Effect on your working files                       |
| ------------------ | --------------------------------------------------------- | -------------------------------------------------- |
| `git fetch origin` | Downloads remote changes to local `.git` repo             | NO changes to working directory or current branch  |
| `git pull origin`  | Fetches remote changes **AND** merges into current branch | Updates your files immediately with remote changes |


# Detailed Flow
## 1. Before Fetch
Your local repo is at a certain commit for `main`. The remote `origin/main` has new commits pushed by others

## 2. Run Command:
```bash
git fetch origin
```

## 3. What happens internally:
- Git connects to `origin` remote URL.
- Downloads all the new commits, branches, and tags.
- Updates your remote-tracking branches like `origin/main`.
- Does not change your current branch or working directory files.
- Keeps your local branches as they are.

## 4. After Fetch:
- You can inspect what changed remotely by comparing your current branch and `origin/main`. use to inspect -> `git log main..origin/main`
- You can decide whether to merge or rebase.


## Merge or Rebase manually (optional):
```bash
git merge origin/main
# OR
git rebase origin/main
```

# Example Scenario:

Your local `main` branch points to commit `A`. Remote `origin/main` has commits `A → B → C`. Others pushed commits `B` and `C` after you last pulled.

#### Before fetch:
```less
Local main: A
Remote origin/main: C (A → B → C)
```
You run:
```bash
git fetch origin
```
- Now your `.git` knows about commits B and C.
- `origin/main` points to commit C.
- Your local `main` still points to A.
- Your working directory files stay at commit A.

You can inspect changes:
```bash
git log main..origin/main
```
Shows commits B and C.  
Example Output:
```bash
commit c3d9e7f9e91b56789abc1234fa12e671f4d84f99
Author: Priya Sharma <priya@example.com>
Date:   Fri May 17 10:21:32 2025 +0530

    fix(auth): correct token expiry logic

commit 92ac1ef3b32c45678abdeffedc2211a345defe12
Author: Rahul Mehta <rahul@example.com>
Date:   Thu May 16 18:04:09 2025 +0530

    feat(api): add new login endpoint
```

If you want to incorporate those changes:
```bash
git merge origin/main
or
git rebase origin/main
```

### OPTION 1: `git merge origin/main`
What it does:
- It merges the remote changes into your current local branch
- Creates a new merge commit (`M`) to glue local and remote histories

RESULTING HISTORY:
```css
     B → C (origin/main)
    /         \
A ------------ M (main)
```
- `M` is a merge commit combining your local A with remote changes `B` and `C`

Example Output:
```bash
Merge made by the 'ort' strategy.
 app.py | 2 ++
 1 file changed, 2 insertions(+)
```
If there are conflicts, Git will stop and show:
```bash
Auto-merging app.py
CONFLICT (content): Merge conflict in app.py
Automatic merge failed; fix conflicts and then commit the result.
```
When to use:
- When you want to preserve full history
- Good for team collaboration
- Preferred when you don’t want to rewrite commit history

### OPTION 2: `git rebase origin/main`
What it does:
It rewrites your local commits so they appear after the remote commits.

Makes the commit history linear and cleaner.

Does not create a merge commit

🔄 RESULTING HISTORY:
Let’s say you also had a local commit `D` after `A`. Before rebase:
```makefile
Local: A → D
Remote: A → B → C
```
After rebase:
```vbnet
Remote: A → B → C → D'
```
(`D'` is a new version of your local commit `D`, replayed on top of `C`)

Example Output:
```bash
Successfully rebased and updated refs/heads/main.
```
If there are conflicts:
```bash
First, rewinding head to replay your work on top of it...
Applying: feat(ui): added dashboard
Using index info to reconstruct a base tree...
M       dashboard.html
CONFLICT (content): Merge conflict in dashboard.html
error: could not apply 92ac1ef... feat(ui): added dashboard
```
You’ll fix the conflicts, then run:
```bash
git add .
git rebase --continue
```
When to use:
- You want a clean, linear history
- You're working solo or in feature branches before pushing
- You want to avoid unnecessary merge commits

---

# Git Fetch vs Git Pull
| Feature / Aspect              | `git fetch`                                                     | `git pull`                                                                 |
| ----------------------------- | --------------------------------------------------------------- | -------------------------------------------------------------------------- |
|  **Definition**             | Downloads updates from the remote repo to your local `.git`     | Downloads **and merges/rebases** updates into your current branch          |
|  **Affects working files?** | ❌ No (only updates remote tracking branches like `origin/main`) | ✅ Yes (immediately tries to merge/rebase into your current working branch) |
|  **Safer?**                  | ✅ Yes (non-intrusive, won’t break anything)                     | ⚠️ Can cause merge conflicts immediately                                   |
|  **Use case**               | You want to **inspect** changes first                           | You want to **bring changes and apply them now**                           |
|  **Review commits first?**  | ✅ Yes: Use `git log HEAD..origin/main` after fetching           | ❌ No opportunity to review before applying                                 |
|  **Manual control?**        | ✅ Yes: You decide when/how to merge or rebase later             | ❌ No control — it merges or rebases immediately                            |
|  **Example command**        | `git fetch origin`                                              | `git pull origin main`                                                     |
|  **Typical flow**           | `fetch → review → merge/rebase`                                 | `pull` (which does `fetch + merge/rebase`)                                 |
|  **Customization**          | Can fetch specific branches/tags                                | Limited (mostly pulls the current branch)                                  |
|  **Conflict risk**          | Low (no code touched)                                         | High (merges code immediately)                                          |


## When to use what?

| If you want to...                             | Use `git fetch` or `git pull`? |
| --------------------------------------------- | ------------------------------ |
| Review incoming changes before applying       | ✅ `git fetch`                  |
| Sync your branch quickly (and know it's safe) | ✅ `git pull`                   |
| Collaborate in complex projects safely        | ✅ `git fetch` + `git rebase`   |
| Avoid merge commits or surprises              | ✅ `git fetch` first            |

