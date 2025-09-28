@attached(peer)
public macro Init(label: String) = #externalMacro(
    module: "AutoInitMacroMacros",
    type: "InitMacro"
)

@attached(peer)
public macro Init(default: Any?) = #externalMacro(
    module: "AutoInitMacroMacros",
    type: "InitMacro"
)

@attached(peer)
public macro Init(label: String, default: Any?) = #externalMacro(
    module: "AutoInitMacroMacros",
    type: "InitMacro"
)

@attached(member, names: arbitrary)
public macro AutoInit() = #externalMacro(
    module: "AutoInitMacroMacros",
    type: "AutoInitMacro"
)
