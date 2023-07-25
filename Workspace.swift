//
//  Workspace.swift
//  ProjectDescriptionHelpers
//
//  Created by 정종인 on 2023/07/19.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let modules: [String] = [
    "App",
    "Home",
    "Write",
    "Search",
    "UI",
    "Core",
]

private let projects: [Path] = modules.map { "Projects/\($0)" }

private let workspace = Workspace(
    name: "\(projectName)",
    projects: projects
)
