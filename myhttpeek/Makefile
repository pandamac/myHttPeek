THEOS_DEVICE_IP = 127.0.0.1
THEOS_DEVICE_PORT = 2222
ARCHS = armv7
TARGET = iPhone:7.1

include theos/makefiles/common.mk

APPLICATION_NAME = myhttpeek
myhttpeek_FILES = main.m myhttpeekApplication.mm RootViewController.mm AppDB.m 
myhttpeek_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk
after-stage::
	$(ECHO_NOTHING)chmod +s $(THEOS_STAGING_DIR)/Applications/myhttpeek.app/myhttpeek$(ECHO_END)