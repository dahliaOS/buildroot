################################################################################
#
# pangolin_desktop
#
################################################################################

PANGOLIN_DESKTOP_VERSION = main 
PANGOLIN_DESKTOP_SITE = git://github.com/dahliaOS/pangolin_desktop.git
PANGOLIN_DESKTOP_GIT_SUBMODULES = YES
PANGOLIN_DESKTOP_INSTALL_STAGING = NO
# help
define PANGOLIN_DESKTOP_BUILD_CMDS
	cd $(@D)&&rm -rf pangolin_desktop&&git clone https://github.com/dahliaOS/pangolin_desktop&&cd $(@D)/pangolin_desktop&&git submodule update --init --recursive &&ls&& cd backend &&git checkout main&&cd ../&&flutter build linux --debug --verbose
	#echo "pangolin_desktop is disabled and will need to be installed manually."
endef

define PANGOLIN_DESKTOP_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/dahlia/pangolin_desktop
	cp -r $(@D)/pangolin_desktop/build/linux/x64/debug/bundle/* $(TARGET_DIR)/dahlia/pangolin_desktop
endef
$(eval $(generic-package))
