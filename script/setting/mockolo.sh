targets=(
    "APIClient"
	"AppFirebase"
)

for target in "${targets[@]}"; do
    generated_folder="Package/Sources/Mockolo/Generated"

    if [ ! -d "$generated_folder" ]; then
		mkdir -p "$generated_folder"
	fi

	mint run mockolo mockolo --sourcedirs Package/Sources/$target \
		--destination Package/Sources/Mockolo/Generated/${target}Mock.swift \
		--testable-imports ${target} \
		--mock-final
done