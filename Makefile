SHELL = bash

MAKEFILE_DIR := $(dir $(realpath $(firstword ${MAKEFILE_LIST})))
BIN_DIR := ${MAKEFILE_DIR}/bin
LIB_DIR := ${MAKEFILE_DIR}/lib

.PHONY: open \
		bootstrap \
		xcodeproj \
		lint \
		format \
		local-install-xcodegen \
		local-install-swiftgen \
		local-install-swiftlint \
		local-install-swiftformat \
		local-install-licenseplist

open:
	@open swiftui-flowcontroller-pattern.xcodeproj

bootstrap:
	@echo "*** Install build tools ***"
	@$(MAKE) local-install-xcodegen
	@$(MAKE) local-install-swiftgen
	@$(MAKE) local-install-swiftlint
	@$(MAKE) local-install-swiftformat
	@${MAKE} local-install-licenseplist
	@echo ""
	@echo "*** Generate Xcode project ***"
	@$(MAKE) xcodeproj
	@echo ""
	@echo "Complete bootstrap."

xcodeproj: local-install-xcodegen
	@echo -n "Xcode project generating..."
	@${XCODEGEN_BIN_PATH} -q
	@echo "OK!"

lint: local-install-swiftlint
	@echo "Linting..."
	@${BIN_DIR}/swiftlint --quiet

format: local-install-swiftformat
	@echo "Formatting..."
	@${BIN_DIR}/swiftformat --swiftversion 5.5 App Infrastructures Repositories

local-install-xcodegen:
	@echo -n "XcodeGen..."
#	It won't work properly with symbolic link.
#	see https://github.com/yonaskolb/XcodeGen/issues/247, https://github.com/yonaskolb/XcodeGen/pull/248
	$(eval XCODEGEN_BIN_PATH := $(shell ${MAKEFILE_DIR}/scripts/local-install-xcodegen.sh -s "${LIB_DIR}/xcodegen"))
	@echo "OK!"

local-install-swiftgen:
	@echo -n "SwiftGen..."
	@SWIFTGEN_PATH=$$(${MAKEFILE_DIR}/scripts/local-install-swiftgen.sh -s "${LIB_DIR}/swiftgen"); \
		ln -sf "$${SWIFTGEN_PATH}" "${BIN_DIR}/swiftgen"
	@echo "OK!"

local-install-swiftlint:
	@echo -n "SwiftLint..."
	@SWIFTLINT_PATH=$$(${MAKEFILE_DIR}/scripts/local-install-swiftlint.sh -s "${LIB_DIR}/swiftlint"); \
		ln -sf "$${SWIFTLINT_PATH}" "${BIN_DIR}/swiftlint"
	@echo "OK!"

local-install-swiftformat:
	@echo -n "SwiftFormat..."
	@SWIFTFORMAT_PATH=$$(${MAKEFILE_DIR}/scripts/local-install-swiftformat.sh -s "${LIB_DIR}/swiftformat"); \
		ln -sf "$${SWIFTFORMAT_PATH}" "${BIN_DIR}/swiftformat"
	@echo "OK!"

local-install-licenseplist:
	@echo -n "LicensePlist..."
	@LICENSEPLIST_PATH=$$(${MAKEFILE_DIR}/scripts/local-install-licenseplist.sh -s "${LIB_DIR}/licenseplist"); \
		ln -sf "$${LICENSEPLIST_PATH}" "${BIN_DIR}/license-plist"
	@echo "OK!"
