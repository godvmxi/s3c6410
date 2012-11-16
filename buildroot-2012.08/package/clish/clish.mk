#############################################################
#
# clish
#
#############################################################
#http://prdownloads.sourceforge.net/clish/clish-0.7.3.tar.gz
CLISH_VERSION = 0.7.3
CLISH_SOURCE = clish-$(CLISH_VERSION).tar.gz
CLISH_SITE = http://prdownloads.sourceforge.net/clish
CLISH_INSTALL_STAGING = YES
CLISH_INSTALL_TARGET = YES
#CLISH_INSTALL_STAGING_OPT = INSTALL_ROOT=$(STAGING_DIR) install
#CLISH_INSTALL_TARGET_OPT = INSTALL_ROOT=$(TARGET_DIR) install
CLISH_CONF_OPT = 
CLISH_DEPENDENCIES = libxml2 binutils
#CLISH_DEPENDENCIES = libxml2 
#define CLISH_BUILD_CMD
#	configure --prefix=$(STAGING_DIR)
#	$(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" 
#	$(MAKE) install
#endef


#define CLISH_UNINSTALL_STAGING_CMDS
#	$(MAKE) uninstall
#endef
#(eval $(generic-package))
$(eval $(autotools-package))
