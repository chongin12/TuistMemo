import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.product(name: "Write", platform: .iOS, additionalDependency: ["UI", "Core"], additionalInterfaceDependency: [])
