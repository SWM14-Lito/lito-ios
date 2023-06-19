import ProjectDescription

public extension TargetDependency {
    enum Projcet {}
}

public extension TargetDependency.Projcet {
    static let Presentation = TargetDependency.project(
        target: "Presentation",
        path: .relativeToRoot("Projects/Presentation")
    )
    static let Domain = TargetDependency.project(
        target: "Domain",
        path: .relativeToRoot("Projects/Domain")
    )
    static let Data = TargetDependency.project(
        target: "Data",
        path: .relativeToRoot("Projects/Data")
    )
}
