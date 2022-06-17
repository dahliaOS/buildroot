################################################################################
#
# flatpak
#
################################################################################

FLATPAK_VERSION = 1.0.6
FLATPAK_SITE = https://github.com/flatpak/flatpak
FLATPAK_SITE_METHOD = git
FLATPAK_GIT_SUBMODULES = YES

FLATPAK_AUTORECONF = YES
FLATPAK_GETTEXTIZE = YES
FLATPAK_LICENSE = LGPL-2.1+
FLATPAK_LICENSE_FILES = COPYING

FLATPAK_INSTALL_TARGET_OPTS = DESTDIR=$(TARGET_DIR) DSTROOT=$(TARGET_DIR) install

FLATPAK_CONF_OPTS = \
	--enable-sandboxed-triggers \
	--enable-xauth \
	--without-system-bubblewrap \
	--with-system-helper
FLATPAK_CONF_ENV += \
	ac_cv_path_GPGME_CONFIG=$(STAGING_DIR)/usr/bin/gpgme-config \
	ac_cv_path_GPGERR_CONFIG=$(STAGING_DIR)/usr/bin/gpg-error-config
FLATPAK_DEPENDENCIES = \
	appstream-glib \
	host-autoconf \
	host-automake \
	host-libtool \
	host-pkgconf \
	json-glib \
	libarchive \
	libcap \
	libglib2 \
	libgpgme \
	libostree \
	libsoup \
	libxml2 \
	polkit \
	xlib_libXau \
	xorgproto \
	xutil_util-macros

# see autogen.sh in flatpak
define FLATPAK_TOUCHUP_VENDOR
	cd $(@D); \
		sed -e 's,$$(libglnx_srcpath),libglnx,g' <\
			libglnx/Makefile-libglnx.am >\
			libglnx/Makefile-libglnx.am.inc; \
		sed -e 's,$$(bwrap_srcpath),bubblewrap,g' <\
			bubblewrap/Makefile-bwrap.am >\
			bubblewrap/Makefile-bwrap.am.inc
endef
FLATPAK_PRE_CONFIGURE_HOOKS += FLATPAK_TOUCHUP_VENDOR

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
FLATPAK_CONF_OPTS += --with-systemd=/usr/lib/systemd/system \
	--enable-systemd
FLATPAK_DEPENDENCIES += systemd
else
FLATPAK_CONF_OPTS += --disable-systemd
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
FLATPAK_CONF_OPTS += --enable-dbus
FLATPAK_DEPENDENCIES += dbus
else
FLATPAK_CONF_OPTS += --disable-dbus
endif

ifeq ($(BR2_PACKAGE_GNUTLS),y)
FLATPAK_CONF_OPTS += --enable-gnutls
FLATPAK_DEPENDENCIES += gnutls
else
FLATPAK_CONF_OPTS += --disable-gnutls
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
FLATPAK_CONF_OPTS += --enable-seccomp
FLATPAK_DEPENDENCIES += libseccomp host-pkgconf
else
FLATPAK_CONF_OPTS += --disable-seccomp
endif

$(eval $(autotools-package))
