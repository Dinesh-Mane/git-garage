#!/bin/bash

# Display a message
echo "Running all Git commands..."

# 1. Initialize a new Git repository
git init
echo "Initialized a new Git repository"

# 2. Check the current status of the repository
echo "Checking the status of the repository..."
git status

# 3. Create a new file
echo "Creating a new file..."
echo "print('Hello Git!')" > hello.py

# 4. Check status again after creating the file (should be untracked)
echo "Checking the status after creating the file..."
git status

# 5. Add the untracked file to staging
echo "Adding the new file to the staging area..."
git add hello.py

# 6. Check status after staging the file
echo "Checking status after staging the file..."
git status

# 7. Commit the staged changes
echo "Committing the staged file..."
git commit -m "Add hello.py file"

# 8. Modify the file
echo "Modifying the hello.py file..."
echo "print('Goodbye Git!')" >> hello.py

# 9. Check status after modification (file should be modified)
echo "Checking the status after modifying the file..."
git status

# 10. Stage the modified file
echo "Staging the modified file..."
git add hello.py

# 11. Commit the changes after modification
echo "Committing the changes after modification..."
git commit -m "Update hello.py with Goodbye message"

# 12. Create a new branch and switch to it
echo "Creating a new branch 'feature-branch' and switching to it..."
git checkout -b feature-branch

# 13. Create another file on the new branch
echo "Creating another file 'feature.py' on the new branch..."
echo "def feature(): print('This is a feature!')" > feature.py

# 14. Stage and commit the new file in the feature branch
git add feature.py
git commit -m "Add feature.py with a feature function"

# 15. Switch back to main branch
echo "Switching back to the main branch..."
git checkout main

# 16. Merge 'feature-branch' into 'main'
echo "Merging 'feature-branch' into 'main'..."
git merge feature-branch

# 17. Check the status again after merge
echo "Checking the status after merge..."
git status

# 18. Create a tag for the current commit
echo "Creating a tag 'v1.0' for the current commit..."
git tag -a v1.0 -m "Version 1.0 release"

# 19. Push changes to the remote repository (change 'origin' and 'main' to your remote name and branch)
echo "Pushing changes to the remote repository..."
git push origin main

# 20. Push the tag to the remote repository
echo "Pushing the tag 'v1.0' to the remote repository..."
git push origin v1.0

# 21. Clean up unnecessary files in the repository (Git garbage collection)
echo "Cleaning up the repository..."
git gc

# 22. Check if the repository has any untracked files
echo "Checking for untracked files..."
git status

# 23. Show Git configuration details
echo "Displaying Git configuration..."
git config --list

# 24. Use Git to ignore certain files (example: .log files)
echo "Setting up Git to ignore .log files..."
echo "*.log" > .gitignore
git add .gitignore
git commit -m "Add .gitignore to ignore .log files"

# 25. Archive the current state of the repository into a zip file
echo "Archiving the repository into a zip file 'release.zip'..."
git archive --format zip --output=release.zip main

# 26. Display the current branch
echo "Displaying the current branch..."
git branch

# End of script
echo "All Git commands executed successfully."
