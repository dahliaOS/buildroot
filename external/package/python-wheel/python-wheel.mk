################################################################################
#
## python-wheel
#
#################################################################################

PYTHON_WHEEL_VERSION = 0.24.0
PYTHON_WHEEL_SOURCE = wheel-$(PYTHON_WHEEL_VERSION).tar.gz
PYTHON_WHEEL_SITE = http://pypi.python.org/packages/source/w/wheel/
PYTHON_WHEEL_SETUP_TYPE = setuptools
PYTHON_WHEEL_DEPENDENCIES = python 
PYTHON_WHEEL_LICENSE = MIT
PYTHON_WHEEL_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
