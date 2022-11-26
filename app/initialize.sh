LARAWIND_CLI_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
LARAWIND_CLI_VERSION="$(cd $LARAWIND_CLI_PATH && git describe --abbrev=0  && cd ~-)"
## update version variable so bashly is aware of the version:
version=$LARAWIND_CLI_VERSION

## load the project's .env variables into shell
set -o allexport
source .env
set +o allexport

