import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.product(name: "Home", platform: .iOS, additionalDependency: ["UI", "Core"], additionalInterfaceDependency: ["Write", "Search"])
