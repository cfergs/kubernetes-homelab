# LINTING

Consists of:
* Pre-commit
* Github Actions
* YAML Schemas

## Pre-commit

Precommit consists of the following steps:
* ansible-lint: lint ansible code
* checkov: lint ansible, kubernetes and github actions code for security issues
* yamllint: lint kubernetes code for formatting errors
* file format checks: end of line, spacing etc

These checks run prior to a commit or can be run manually with `make pre-commit`

## Github Actions

Run on pull requests. Undertakes ansible-lint & runs checkov against ansible and kubernetes code.

Located in `.github/workflows/testing.yml`

Note: The current ansible-lint action doesnt seem to like checking code requiring additional collections to be installed. Something to fix.

## YAML Schemas

The majority of yaml schema's are handled by builtin schemas from the redhat yaml extension. Unfortunately many kubernetes kind objects do not conform to the default yaml standard and require a different schema corresponding to their CRD. To handle this a script exists to extract a json of the CRD - refer to [other](other.md).

These schema's are stored in the root `schemas` folder and referenced at the top of the yaml using `# yaml-language-server: $schema=<<path_to_schema_file>>`.
