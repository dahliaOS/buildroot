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
	cd $(@D)&&dart pub get&&dart compile exe bin/pkg.dart&&cp bin/pkg.exe dap
endef

define DAP_INSTALL_TARGET_CMDS
	rm -f $(TARGET_DIR)/bin/dap
	cp $(@D)/dap $(TARGET_DIR)/bin/dap
	echo "dap: already installed by DAP_BUILD_CMDS"
endef
$(eval $(generic-package))
