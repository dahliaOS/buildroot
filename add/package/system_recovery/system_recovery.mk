################################################################################
#
# system_recovery
#
################################################################################
SYSTEM_RECOVERY_SITE = https://github.com/dahliaOS/system_recovery/archive/refs/heads/main.tar.gz
#PANGOLIN_DESKTOP_GIT_SUBMODULES = YES
SYSTEM_RECOVERY_INSTALL_STAGING = NO
# help
define SYSTEM_RECOVERY_BUILD_CMDS
	cd $(@D)&&git clone https://github.com/dahliaOS/system_recovery/&&mv system_recovery/* ./&&flutter build linux --release --verbose
endef

define SYSTEM_RECOVERY_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/dahlia/system_recovery
	cp -r $(@D)/build/linux/x64/release/bundle/* $(TARGET_DIR)/dahlia/system_recovery
endef
$(eval $(generic-package))
