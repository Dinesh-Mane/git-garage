# GitHub Essentials: Pull Requests, Forks, Issues, Secrets, GitHub Actions
## 1. Pull Requests (PRs)
> A Pull Request is a request to merge your changes from one branch (or fork) into another — usually into the `main` branch of the original repo.

**Use Case:** You fix a bug or add a feature in a branch → Open a PR → Reviewer approves → It gets merged into `main`
**Steps:**
1. Push changes to your branch: `git push origin feature-xyz`
2. Go to GitHub → Click "Compare & Pull Request"
3. Add description → Click “Create Pull Request”
4. Reviewer reviews and merges.

**Q1) How do you handle code reviews in GitHub?**  
Ans: We use Pull Requests where we follow a checklist, add reviewers, assign tags, and comment directly on lines of code.

## 2. Forks
> A Fork is a copy of someone else’s repo under your GitHub account — lets you work without affecting the original repo.

**Use Case:** 
1. You don’t have write access to a repo.
2. You want to contribute — fork → make changes → open PR to original repo.

**Example:**
1. Click "Fork" on a GitHub repo
2. Clone your fork: `git clone https://github.com/yourname/their-project.git`
3. Add the original repo as a remote: `git remote add upstream https://github.com/original-user/their-project.git`

**Sync with upstream:**
```bash
git fetch upstream
git merge upstream/main
```
> **Tip:** Forks are for external contributors, branches are for team members.

## 3. Issues
> GitHub Issues are used to report bugs, request features, or track tasks.

**Use Case:** 
1. Anyone (or a team member) finds a bug.
2. They open an issue like: `"Login button not working on Firefox"`

Features:  
1. Assignees
2. Labels (e.g., bug, enhancement, urgent)
3. Milestones
4. Linked PRs

**Example:**
```nginx
Issue #21: [Bug] Infinite loader on cart page
```
**Q1) How does your team manage tasks or bugs?**  
Ans: We use GitHub Issues with labels and milestones. Each PR references its issue (Fixes #21).

## 4. GitHub Secrets
> Store API keys, tokens, passwords securely — used in CI/CD workflows (e.g., GitHub Actions).

**Use Case:** 
1. AWS Credentials  
2. DockerHub username/password  
3. Slack webhooks  

Steps:  
1. Go to repo → Settings → Secrets and variables → Actions  
2. Add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

Use in GitHub Actions:
```yml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
```
> Never commit secrets directly to code!


## 5. GitHub Actions
> GitHub’s CI/CD system — lets you automate workflows: tests, builds, deploys, linting, notifications

**Use Case:** 
1. Auto-run tests when PR is created  
2. Auto-deploy on `main` push  
3. Send Slack alerts when build fails    

Files go in:  
```bah
.github/workflows/<name>.yml
```
Example Workflow:
```yaml
name: Deploy to S3

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Deploy to AWS S3
      run: aws s3 sync . s3://my-bucket --delete
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```
**Q1) What CI/CD system do you use?**  
Ans: We use GitHub Actions for build, test, and deploy. Secrets are stored in GitHub, and workflows are triggered by pull requests and commits to specific branches.


### Summary
1. Fork → Copy of repo (for external contribution)  
2. Branch → Internal feature work  
3. PR → Code review + merge  
4. Issue → Bug/feature tracker  
5. Secrets → Secure config for CI/CD  
6. GitHub Actions → Automation engine  

---

# Collaboration Scenario: Fork → Pull Request → Code Review

## 1. Forking the Repository (External Contributor)
You are a contributor to a public GitHub project, but you don’t have write access. So, you fork the project to your own GitHub account, and make changes in your fork.
- Go to the original repo you want to contribute to (e.g., `https://github.com/organization/repo`)
- Click the Fork button (top-right of the page).

GitHub will create a copy of the repository under your username: `https://github.com/your-username/repo`

## 2. Cloning Your Fork (On Your Local Machine)
Now, you need to clone your fork to your local machine to start working on it.
```bash
git clone https://github.com/your-username/repo.git
cd repo
```
Now you have the repo on your local machine. Let’s start coding!

## 3. Creating a New Branch
Before making any changes, create a new branch to work on your feature or fix. This keeps your changes isolated from the main branch
```bash
git checkout -b feature/add-login
```
**Branch Naming Convention Tip:** Use descriptive names like `feature/add-login`, `bugfix/fix-header`, etc.

## 4. Making Changes (Implementing the Feature/Fix)
Make your changes in the code. For example, let's say you are adding a login form to a webpage. After editing files:
```bash
# Example change
echo "New login form HTML" >> login.html
```

## 5. Committing Your Changes
Once you've made your changes, you’ll need to commit them with a meaningful message.
```bash
git add login.html
git commit -m "Added a new login form to the homepage"
```

## 6. Pushing Your Changes to GitHub (Your Fork)
After committing your changes locally, push them to your fork on GitHub.
```bash
git push origin feature/add-login
```

## 7. Opening a Pull Request (PR)
Now that your changes are pushed to your fork, you can open a pull request (PR) to the original repository. Go to your GitHub repo page and you’ll see a banner like this:
- "Compare & pull request" → Click on it.

Ensure that you're requesting a pull into the correct base branch (e.g., `main` or `develop`) of the **original repo**
- Title: Be descriptive (e.g., "Add Login Form to Homepage")
- Description: Explain what changes were made and why.

Example PR message: 
> "This PR adds a new login form to the homepage to allow users to sign in."

## 8. Code Review by the Team (Maintainer’s Perspective)
Once the PR is created, the repository maintainer or team member will review the changes. They will typically:
- Check for code quality, readability, and test coverage.
- Look for any bugs or potential conflicts with other parts of the codebase.
- Ensure the changes align with the project's coding standards.

Here’s how they might review:
- Commenting on Specific Lines:
  1. “This line can be optimized.”
  2. “Can you add a check for null here?”
- Requesting Changes: If something is wrong or needs to be improved, they will request changes:
  > "Please modify the login form to handle edge cases, like empty fields."
- Approve PR: Once everything looks good, the reviewer approves the PR.

## 9. Addressing Code Review Feedback (Contributor’s Responsibility)
Once feedback is provided, you, as the contributor, make necessary changes to the code and push the updated code to your fork again. You don’t need to open a new PR for each update; you can just push to the same branch.
```bash
git add login.html
git commit -m "Fixed validation for empty login fields"
git push origin feature/add-login
```

## 10. Final Merge (Maintainer)
Once the PR is reviewed and approved, the maintainer merges the changes into the main repository. This can be done through:
1. Merge button on GitHub: If everything is fine, the reviewer hits the "Merge" button.
2. Squash and merge: If there were many small commits, the maintainer might choose "Squash and Merge" to combine them into a single commit.
3. Rebase and merge: Alternatively, they could rebase the PR branch and merge it to keep a linear history.


## 11. Syncing Your Fork with the Original Repository
Now that your changes are merged into the original repository, it’s a good idea to sync your fork with the latest changes from the main repo.
```bash
# Fetch updates from the original repo
git fetch upstream

# Checkout your main branch
git checkout main

# Merge the updates from upstream (original repo) into your fork
git merge upstream/main

# Push changes to your fork
git push origin main
```

#### Complete Workflow Summary
1. Fork the repo → Clone it to your local machine
2. Create a new branch for your feature/fix
3. Make changes to the code
4. Commit your changes with a detailed message
5. Push the branch to your fork on GitHub
6. Open a PR and describe the changes
7. Code review happens: Comments, requests for changes
8. Make necessary changes and update the PR
9. Final merge by the maintainer
10. Sync your fork with the original repository


**Q1) How do you collaborate on a public GitHub project with other developers?**  
Ans: I typically start by forking the repo to my own GitHub account. After cloning my fork locally, I create a new branch for the feature or fix I’m working on. Once I’ve implemented my changes, I commit them with meaningful messages, push them to my fork, and then open a pull request (PR) to the main repository. The team reviews the PR, and I make any necessary adjustments based on feedback. Once it’s approved, the maintainer merges the PR. After the merge, I sync my fork with the latest updates from the main repository to stay up-to-date.





