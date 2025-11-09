PRODUCT_NAME := SwiftTemplate

.PHONY: setup
setup:
	$(MAKE) install-bundler
	$(MAKE) install-mint-packages
	$(MAKE) generate-sourcery
	$(MAKE) generate-mock
	$(MAKE) setting-xcode
	$(MAKE) open

.PHONY: pre-commit
pre-commit:
	$(MAKE) setup-pre-commit
	$(MAKE) install-pre-commit

.PHONY: setup-pre-commit
setup-pre-commit:
	brew install pre-commit

.PHONY: install-pre-commit
install-pre-commit:
	pre-commit install

.PHONY: install-bundler
install-bundler:
	bundle install

.PHONY: install-mint-packages
install-mint-packages:
	mint bootstrap --overwrite y

.PHONY: update-package
update-package:
	sh ./script/renovate/update-package.sh

.PHONY: generate-sourcery
generate-sourcery:
	$(MAKE) generate-resolver
	$(MAKE) generate-app-environment

.PHONY: generate-resolver
generate-resolver:
	mint run krzysztofzablocki/Sourcery \
		--sources Package/Sources/Core/ViewEnvironment/ViewDescriptor.swift \
		--templates stencil/ViewResolver.stencil \
		--output Package/Sources/Core/ViewEnvironment/ViewResolver.swift

.PHONY: generate-app-environment
generate-app-environment:
	mint run krzysztofzablocki/Sourcery \
		--sources Package/Sources/Core/ViewEnvironment/ViewDescriptor.swift \
		--templates stencil/AppEnvironment.stencil \
		--output Package/Sources/App/AppEnvironment/AppEnvironment.swift

.PHONY: generate-mock
generate-mock:
	zsh ./script/setting/mockolo.sh

.PHONY: setting-xcode
setting-xcode:
	defaults write com.apple.dt.Xcode IDEPackageEnablePrebuilts YES

.PHONY: run-format
run-format:
	swift run --package-path BuildTools swiftformat .

.PHONY: open
open:
	open ./$(PRODUCT_NAME).xcworkspace

.PHONY: clean
clean:
	rm -rf $${HOME}/Library/Developer/Xcode/DerivedData
	rm -rf ~/Library/Caches/com.apple.dt.Xcode
	rm -rf ~/Library/Developer/Xcode/DerivedData/
	rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport
	rm -rf ~/Library/Developer/XCPGDevices
