################################################################################
#
# pangolin_desktop
#
################################################################################

PANGOLIN_DESKTOP_VERSION = main 
PANGOLIN_DESKTOP_SITE = https://github.com/dahliaOS/pangolin_desktop.git
PANGOLIN_DESKTOP_GIT_SUBMODULES = YES
PANGOLIN_DESKTOP_INSTALL_STAGING = NO
# help
define PANGOLIN_DESKTOP_BUILD_CMDS
	cd $(@D)&&flutter build linux --release --verbose
	#echo "pangolin_desktop is disabled and will need to be installed manually."
endef

define PANGOLIN_DESKTOP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/dahlia/pangolin_desktop
	cp -r $(@D)/build/linux/x64/release/bundle/* $(TARGET_DIR)/dahlia/pangolin_desktop
endef
$(eval $(generic-package))
