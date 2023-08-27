using PkgTemplates

template = Template(
    dir="/workspaces/julia-programming-cookbook/program/chapter16/myproject",
    julia=v"1.9",
    plugins=[
        Tests(project=true),
        GitHubActions(),
        Codecov(),
        Documenter{GitHubActions}(),
    ],
)