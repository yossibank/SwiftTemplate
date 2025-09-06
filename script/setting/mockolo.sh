#!/bin/zsh

typeset -A target_paths

target_paths=(
	APIClient "Package/Sources/Core/APIClient"
	FirebaseLive "Package/Sources/Core/FirebaseLive"
	Rakuten "Package/Sources/Feature/Rakuten"
	RakutenView "Package/Sources/Feature/RakutenView"
)

generated_folder="Package/Mockolo/Generated"

if [ ! -d "$generated_folder" ]; then
	mkdir -p "$generated_folder"
fi

for target source_dir in ${(kv)target_paths}; do
    mint run mockolo mockolo \
        --sourcedirs "$source_dir" \
        --destination "$generated_folder/${target}Mock.swift" \
        --testable-imports "$target" \
        --mock-final
done

