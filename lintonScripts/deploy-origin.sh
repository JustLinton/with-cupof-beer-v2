 #!/bin/bash
mkdocs build
git add .
git commit -m "auto-commit"
git push origin master
