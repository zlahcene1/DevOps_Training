#!/usr/bin/env groovy

jobs:
  - script: >
      folder('/Tools') {
        description('Folder for miscellaneous tools.')
        displayName('Tools')
      }

      freeStyleJob('/Tools/clone-repository') {
        wrappers {
          preBuildCleanup {
            preBuildCleanup()
          }
        }
        parameters {
          stringParam("GIT_REPOSITORY_URL", "", "Git URL of the repository to clone")
        }
        steps {
          shell("git clone \$GIT_REPOSITORY_URL")
        }
      }

