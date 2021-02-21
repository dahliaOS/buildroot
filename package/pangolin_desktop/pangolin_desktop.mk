################################################################################
#
# pangolin_desktop
#
################################################################################

PANGOLIN_DESKTOP_VERSION = latest
PANGOLIN_DESKTOP_SOURCE = master.tar.gz
PANGOLIN_DESKTOP_SITE = https://github.com/dahliaOS/pangolin-desktop/archive
PANGOLIN_DESKTOP_INSTALL_STAGING = NO
# help
define PANGOLIN_DESKTOP_BUILD_CMDS
	cd $(@D)&&flutter build linux --debug
endef

define PANGOLIN_DESKTOP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/dahlia/pangolin_desktop
	cp -r $(@D)/build/linux/debug/bundle/* $(TARGET_DIR)/dahlia/pangolin_desktop
endef
$(eval $(generic-package))