 #!/bin/bash
# conda activate pylinton39
mkdocs build
# cp site/*.* dep/
cd site
git add .
git commit -m "r"
git push dep master
