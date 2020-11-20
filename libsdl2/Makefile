#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=SDL2
PKG_VERSION:=2.0.12
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.libsdl.org/release/
PKG_HASH:=349268f695c02efbc9b9148a70b85e58cefbbf704abd3e91be654db7f1e2c863

include $(INCLUDE_DIR)/package.mk

define Package/sdl2
	SECTION:= libs
	CATEGORY:= Libraries
	TITLE:= Simple DirectMedia Layer 2
	URL:=http://www.libsdl.org
  	DEPENDS:=+zlib +libpthread
endef



REAL_CPU_TYPE:=$(firstword $(subst +, ,$(CONFIG_CPU_TYPE)))
REAL_CPU_TYPE:=$(subst octeonplus,octeon+,$(REAL_CPU_TYPE))



define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef


define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/SDL2 $(1)/usr/include/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libSDL2.{a,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/sdl2.pc $(1)/usr/lib/pkgconfig/
endef


define Package/sdl2/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/sdl2-config $(1)/usr/bin/
endef


$(eval $(call BuildPackage,sdl2))
