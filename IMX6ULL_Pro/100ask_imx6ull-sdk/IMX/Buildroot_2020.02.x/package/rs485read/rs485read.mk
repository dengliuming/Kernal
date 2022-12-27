################################################################################
#
# rs485 read for weidongshan@qq.com
#
################################################################################

RS485READ_VERSION = 7486128a1a8122236ea67632a1b3a12226a1eced
RS485READ_SITE = https://gitee.com/weidongshan/RootfsPackages.git
RS485READ_SITE_METHOD = git
RS485READ_LICENSE = GPL-3.0

define RS485READ_BUILD_CMDS
	cd $(@D); \
		$(TARGET_CC)  -o rs485_read  -I ./ rs485_read.c  serial.c
endef
		  			 		  						  					  				 	   		  	  	 	  
define RS485READ_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/rs485_read $(TARGET_DIR)/usr/bin/rs485_read
endef
		  			 		  						  					  				 	   		  	  	 	  
$(eval $(generic-package))
