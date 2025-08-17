PRODUCT_NAME := SwiftTemplate

.PHONY: setup
setup:
	$(MAKE) install-bundler
	$(MAKE) install-mint-packages
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

.PHONY: run-format
run-format:
	swift run --package-path BuildTools swiftformat .

.PHONY: open
open:
	open ./$(PRODUCT_NAME).xcworkspace

.PHONY: clean
clean:
	rm -rf $${HOME}/Library/Developer/Xcode/DerivedData