### Steps to Contribute:

1. **Fork the Repository**  
   Anyone interested in contributing should first **fork** your repository. They can do this by going to your GitHub project page and clicking the "Fork" button in the top-right corner. This creates a copy of the repository under their GitHub account.

2. **Clone the Repository**  
   After forking, they should clone the forked repository to their local machine to make changes:
   ```bash
   git clone https://github.com/their-username/KeyCrafter.git
   cd KeyCrafter
   ```

3. **Create a New Branch**  
   It's good practice to create a new branch for any changes or new features, rather than working directly on the `main` branch. They can create a new branch like so:
   ```bash
   git checkout -b feature-name
   ```

4. **Make Changes**  
   They should now make changes to the code or documentation as needed.

5. **Commit Changes**  
   Once their changes are ready, they need to commit them with a descriptive message:
   ```bash
   git add .
   git commit -m "Describe the changes made"
   ```

6. **Push Changes**  
   After committing, they should push the changes to their forked repository:
   ```bash
   git push origin feature-name
   ```

7. **Open a Pull Request (PR)**  
   After pushing, they can go to their forked repository on GitHub and click the "Compare & Pull Request" button. This opens the PR form where they can:

   - Choose the base repository (your original `KeyCrafter` repo) and the branch to merge into (typically `main` or `master`).
   - Provide a title and description for the PR, explaining the changes they’ve made.
   - Submit the PR.

8. **Review and Merge**  
   Once a PR is submitted, you can review the changes. If everything looks good, you can merge the PR into the main codebase. If there are any issues, you can leave comments, and the contributor can address them.



### Example PR Process:

1. **Fork and Clone:**
   ```bash
   git clone https://github.com/mahros-alqabasy/KeyCrafter.git
   ```

2. **Create a Branch:**
   ```bash
   git checkout -b fix-typos
   ```

3. **Make Changes:**
   Edit the README.md or any other files.

4. **Commit Changes:**
   ```bash
   git add .
   git commit -m "Fix typos in the README"
   ```

5. **Push Changes:**
   ```bash
   git push origin fix-typos
   ```

6. **Create PR:**
   On GitHub, click "Compare & Pull Request", add a description, and submit the PR.

