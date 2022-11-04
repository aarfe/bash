# Use if you need to disconnect the repo from another git repo submodule, 
either because you want to use another release or because you need to reset the current submodule

set +e 
set -x

# Remove the submodule entry from .git/config
git submodule deinit -f parent_repo/sub_repo

# Remove the submodule directory from the superproject's .git/modules directory
rm -rf .git/modules/sub_repo

# Remove the entry in .gitmodules and remove the submodule directory located at path/to/submodule
git rm -f parent_repo/sub_repo

# Remove the directory if the previous git remove failed.
rm -fr parent_repo/sub_repo
