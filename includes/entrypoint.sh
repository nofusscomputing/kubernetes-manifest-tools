#!/bin/sh

set -e

export TMP_OUTPUT_DIR="/tmp/yaml-files";

if [ -d "/workspace/github" ]; then


  export NFC_GIT_PROVIDER=github;

  export NFC_WORKDIR="/github/workspace";


  if [ "${ACTIONS_STEP_DEBUG:-}" = "true" ] || [ "${RUNNER_DEBUG:-}" = "1" ]; then

    export KUBECTL_SLICE_DEBUG="true"

  fi;


elif [ -n "${CI_PROJECT_DIR}" ]; then


  export NFC_GIT_PROVIDER=gitlab;

  export NFC_WORKDIR="${CI_PROJECT_DIR}"

else


  export NFC_WORKDIR="/workdir"


fi;


cd $NFC_WORKDIR;


if [ ! -n "${KUBECTL_SLICE_INPUT_FILE}" ]; then

  echo "var KUBECTL_SLICE_INPUT_FILE must be set to the input file.";
  exit 1;

fi;


if [ ! -n "${KUBECTL_SLICE_TEMPLATE}" ]; then

  export KUBECTL_SLICE_TEMPLATE='{{ .kind }}-{{ .metadata.name | dottodash | replace ":" "-" }}.yaml';

fi;


if [ ! -n "${KUBECTL_SLICE_OUTPUT_DIR}" ]; then

  export NFC_OUTPUT_DIR="${PWD}";

else

  export NFC_OUTPUT_DIR="${KUBECTL_SLICE_OUTPUT_DIR}";

fi;

if printf '%s\n' "${KUBECTL_SLICE_INPUT_FILE}" | grep -Eq '^https?://|^ftp://'; then

  wget ${KUBECTL_SLICE_INPUT_FILE} -O /tmp/manifest.yaml;

  export KUBECTL_SLICE_INPUT_FILE="/tmp/manifest.yaml";

fi

mkdir -p $TMP_OUTPUT_DIR;

kubectl-slice --output-dir $TMP_OUTPUT_DIR


if [ "${NFC_FORMAT_YAML:-}" = "true" ]; then

  echo "adding yaml headers '---' to output files";

  # sed -i "1s/^/---\n/" ${KUBECTL_SLICE_OUTPUT_DIR}*.yaml;
  yaml-format $TMP_OUTPUT_DIR $NFC_OUTPUT_DIR

fi;
