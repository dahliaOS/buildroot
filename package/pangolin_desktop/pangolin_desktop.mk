################################################################################
#
# pangolin_desktop
#
################################################################################
PANGOLIN_DESKTOP_SITE = https://github.com/dahliaOS/pangolin_desktop/archive/refs/heads/main.tar.gz
#PANGOLIN_DESKTOP_GIT_SUBMODULES = YES
PANGOLIN_DESKTOP_INSTALL_STAGING = NO
# help
define PANGOLIN_DESKTOP_BUILD_CMDS
	cd $(@D)&&git clone https://github.com/dahliaOS/pangolin_desktop/&&mv pangolin_desktop/* ./&&flutter build linux --release --verbose
	#echo "pangolin_desktop is disabled and will need to be installed manually."
endef

define PANGOLIN_DESKTOP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/dahlia/pangolin_desktop
	cp -r $(@D)/build/linux/x64/release/bundle/* $(TARGET_DIR)/dahlia/pangolin_desktop
endef
$(eval $(generic-package))
