#!/usr/bin/env bash

set +eux

SCRIPT_DIR=$(dirname "$0");
LOCKFILE=${SCRIPT_DIR}/IS_INITIALIZED.TMP

source ${SCRIPT_DIR}/helper.sh

if [[ -f "${LOCKFILE}" ]]; then
  echo "Environment already initialized. Exit!";
  exit 0;
else
  echo -e "No lockfile found. Your environment seems uninitialized.\n";

  echo -en "Do you want to import the initial Shopware-Dump?
${bold}${red}WARNING: This will wipe your local Shopware database!${reset}\n
${bold}[y/N]${reset}\n";
  read -n 1 importInitialDump
  echo

  echo "Do you want to import the actual live database to your system? ${bold}[y/N]${reset}"
  read -p -n 1 importLiveDump
fi


if [[ "${importLiveDb}" == "y" ]]; then
    echo "Importin Live-Database."
  else
    echo "Skipping live import.";
fi



echo "Dumping live Database."
echo "Finished. Writing Lockfile.";

touch ${LOCKFILE};
chmod 0400 ${LOCKFILE}
