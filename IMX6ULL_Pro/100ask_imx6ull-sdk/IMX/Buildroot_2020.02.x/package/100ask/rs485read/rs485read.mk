################################################################################
#
# rs485 read for weidongshan@qq.com
#
################################################################################
		  			 		  						  					  				 	   		  	  	 	  
RS485_READ_VERSION = 7486128a1a8122236ea67632a1b3a12226a1eced
RS485_READ_SITE = https://gitee.com/weidongshan/RootfsPackages.git
RS485_READ_SITE_METHOD = git
RS485_READ_LICENSE = GPL-3.0
		  			 		  						  					  				 	   		  	  	 	  
define RS485_READ_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef
		  			 		  						  					  				 	   		  	  	 	  
define RS485_READ_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/rs485_read $(TARGET_DIR)/usr/bin/rs485_read
endef
		  			 		  						  					  				 	   		  	  	 	  
$(eval $(generic-package))