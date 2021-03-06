#!/bin/bash

set -xe

USER_UID=${USER_UID:-2000}
USER_LOGIN=${USER:-compute}
USER_FULL_NAME="${USER_FULL_NAME:-Compute container user}"
USER_HOME_DIR="/home/${USER_LOGIN}"

if [ ! -d ${USER_HOME_DIR} ]; then

	echo "Creating user ${USER_LOGIN} (${USER_UID}:${USER_GID})..."
	adduser --disabled-password --home "${USER_HOME_DIR}" \
		--uid "${USER_UID}" \
		--gecos "${USER_FULL_NAME},,," "${USER_LOGIN}"
	adduser "${USER_LOGIN}" compute-users

fi;

cd "${USER_HOME_DIR}"

if [ ! -f ${USER_HOME_DIR}/.graphlab/config ]; then
	HOME="${USER_HOME_DIR}" sudo -E -u "${USER_LOGIN}" \
		${CMD:-bash --login -c "source activate dato-env && pip install --upgrade --no-cache-dir https://get.dato.com/GraphLab-Create/${GRAPHLAB_VERSION}/${GRAPHLAB_EMAIL}/${GRAPHLAB_LICENSE}/GraphLab-Create-License.tar.gz"}

fi;

HOME="${USER_HOME_DIR}" sudo -E -u "${USER_LOGIN}" \
	${CMD:-bash --login -c "source activate dato-env && jupyter notebook"}

