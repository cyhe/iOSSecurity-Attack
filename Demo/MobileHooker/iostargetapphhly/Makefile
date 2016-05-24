export THEOS=/opt/theos
export THEOS_DEVICE_IP = 192.168.34.41
ARCHS = armv7 arm64
TARGET = iphone:8.1:8.0
include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = iostargetapphhly
iostargetapphhly_FILES = main.m iostargetapphhlyApplication.mm RootViewController.mm
iostargetapphhly_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk
after-install::
		install.exec "su mobile -c uicache"
