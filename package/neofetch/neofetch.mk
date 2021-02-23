################################################################################
#
# neofetch
#
################################################################################

NEOFETCH_VERSION = latest
NEOFETCH_SOURCE = master.tar.gz
NEOFETCH_SITE = https://github.com/dylanaraps/neofetch/archive
NEOFETCH_INSTALL_STAGING = NO
# help
define NEOFETCH_BUILD_CMDS
	echo 'None needed!'
endef

define NEOFETCH_INSTALL_TARGET_CMDS
	chmod +x $(@D)/neofetch
	cp $(@D)/neofetch $(TARGET_DIR)/bin/neofetch
endef
$(eval $(generic-package))
