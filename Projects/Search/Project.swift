import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.product(name: "Search", platform: .iOS, additionalDependency: ["UI", "Core"], additionalInterfaceDependency: [])
