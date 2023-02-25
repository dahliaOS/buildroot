################################################################################
#
## python-pip
#
#################################################################################

PYTHON_PIP_VERSION = 7.1.2
PYTHON_PIP_SOURCE = pip-$(PYTHON_PIP_VERSION).tar.gz
PYTHON_PIP_SITE = http://pypi.python.org/packages/source/p/pip/
PYTHON_PIP_SETUP_TYPE = setuptools
PYTHON_PIP_DEPENDENCIES = python python-setuptools
PYTHON_PIP_LICENSE = MIT
PYTHON_PIP_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
