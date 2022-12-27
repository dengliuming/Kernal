################################################################################
#
# myir-hmi-v2.0 for weidongshan@qq.com
#
################################################################################
		  			 		  						  					  				 	   		  	  	 	  
MYIR_HMI_GUI_VERSION = 509b96ab2466326df2ea3fe673edcabd899cc96d
MYIR_HMI_GUI_SITE = https://gitee.com/weidongshan/Qtmxapp-desktop.git
MYIR_HMI_GUI_SITE_METHOD = git
MYIR_HMI_GUI_DEPENDENCIES = qt5multimedia qt5base qt5declarative
MYIR_HMI_GUI_LICENSE = GPL-3.0
		  			 		  						  					  				 	   		  	  	 	  
define MYIR_HMI_GUI_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE))
endef
		  			 		  						  					  				 	   		  	  	 	  
define MYIR_HMI_GUI_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef
		  			 		  						  					  				 	   		  	  	 	  
define MYIR_HMI_GUI_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/mxapp2 \
		$(TARGET_DIR)/usr/bin/mxapp2  \
	mkdir -p $(TARGET_DIR)/usr/share/fonts; \
	mkdir -p $(TARGET_DIR)/usr/share/myir; \
	mkdir -p $(TARGET_DIR)/usr/share/ecg; \
	
	$(INSTALL) -D -m 0755 $(@D)/Samplelibrary/fonts/ttf/msyh.ttc \
		$(TARGET_DIR)/usr/lib/fonts/msyh.ttc \		
	$(INSTALL) -D -m 0755 $(@D)/Samplelibrary/fonts/ttf//msyh.ttc \
		$(TARGET_DIR)/usr/share/fonts/msyh.ttc
	
endef
		  			 		  						  					  				 	   		  	  	 	  
define MYIR_HMI_GUI_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D  package/myir-hmi-gui/S99myirhmi2 \
		$(TARGET_DIR)/etc/init.d/S99myirhmi2
endef

define MYIR_HMI_GUI_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 755 package/myir-hmi-gui/start.sh \
		$(TARGET_DIR)/usr/bin/start.sh \
	$(INSTALL) -D -m 644 package/myir-hmi-gui/myir.service \
		$(TARGET_DIR)/usr/lib/systemd/system/myir.service
endef
		  			 		  						  					  				 	   		  	  	 	  
$(eval $(generic-package))