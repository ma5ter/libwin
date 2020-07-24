# Welcome to libwin

**libwin** is a collection of simple batch scripts to compile popular open source libraries under windows environment with **cmake**

## Concept

The main concept is to have one script which deals most common tasks and per-project one-liner build.cmd to bootstrap the main script.

## Parameters

Main script shuld not to be run by user and it accepts one required parameter which is the name of the function to call and none or several optional parameters which should be passed to the function.

Per-project build.cmd usually calls the *run* function of the main script and along with required parameters of *git-url*, *extra-cmake-parameters* and *relative-path-to-pdbs* can pass some essential options:

 - **update** -- updates sources from git repository,
 - **clean** -- cleans the *build* folder before build,
 - **keep** -- instructs not to clean the *build* folder on successful build,

When one project depends on some others a list of dependencies may be passed via environmental variable *DEPENDS_ON*.
