
# System requirements

- coreutils

# Goals
  - Allow a clone and use setup without modifying the upstream content
  - Demo how to use the gRPC tools and give example projects in various languages
  - Use the base tools (i.e. Buf tooling is not used for now)
- .
- Implementation outline
  - There is a template hierarchy
  - A project hierarchy is created from the template, and can be compared with the template as the templates evolves.
  - Scripts load _grpcenv.sh from the repo root
    - It loads _grpcenv-project.sh  for project specific overrides.
  - If TMPL_PROJECT folder doesn't exist, copy from template
  - Load environment from "${TMPL_PROJECT}/etc/env.sh"
- 
- environment variables
    - TMP_  a prefix for all variable names, so they sort together
    - See the various variables in `"${TMPL_PROJECT}/etc/env-local.sh"`
    - TMPL_DIR  is the directory of the bin folder of a script. It should only be available in a script for its own use.
    - TMPL_TEMPLATE  the template folder name (_template)
    - TMPL_PROJECT  the project folder name (_hello_world)
    - TMPL_SETUP  a flag variable to indicate if the setup code should run with each script. Running the setup code slows down scripts, so it can be turned off with this variable.
      - If its value is `setup` the code will run with every script.
      - So, for example, to temporarily turn this off, set TMPL_SETUP to something else in the `"${TMPL_PROJECT}/etc/env-local.sh"` file.
    - TMPL_PROJECT_VER  a version string for the project so the language specific projects can be set accordingly. It's an artifact version to be used based on how a language project does artifact/package versioning.



