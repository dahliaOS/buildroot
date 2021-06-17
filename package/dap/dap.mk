################################################################################
#
# dap
#
################################################################################

DAP_VERSION = latest
DAP_SOURCE = master.tar.gz
DAP_SITE = https://github.com/dahliaOS/dap/archive
DAP_INSTALL_STAGING = NO
# help
define DAP_BUILD_CMDS
	cd $(@D)&&dart pub get&&dart compile exe bin/pkg.dart -o bin/dap
endef

define DAP_INSTALL_TARGET_CMDS
	cp $(@D)/bin/dap $(TARGET_DIR)/bin
endef
$(eval $(generic-package))
