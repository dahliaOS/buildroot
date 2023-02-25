################################################################################
#
# appstream-glib
#
################################################################################

APPSTREAM_GLIB_VERSION = appstream_glib_0_7_14
APPSTREAM_GLIB_SITE = $(call github,hughsie,appstream-glib,$(APPSTREAM_GLIB_VERSION))
APPSTREAM_GLIB_LICENSE = LGPL-2.0+
APPSTREAM_GLIB_LICENSE_FILES = COPYING
APPSTREAM_GLIB_INSTALL_STAGING = YES

# RPM has a cross-dependency failure
APPSTREAM_GLIB_CONF_OPTS = \
	-Dintrospection=false \
	-Drpm=false \
	-Dstemmer=false \
	-Dfonts=false
APPSTREAM_GLIB_DEPENDENCIES = \
	$(TARGET_NLS_DEPENDENCIES) \
	host-gperf \
	host-libglib2 \
	host-pkgconf \
	gdk-pixbuf \
	json-glib \
  libarchive \
	libglib2 \
	libsoup \
	$(if $(BR2_ENABLE_LOCALE),,libiconv) \
	libyaml

$(eval $(meson-package))
