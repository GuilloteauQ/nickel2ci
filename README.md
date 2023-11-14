# Nickel2CI

WIP: A single Nickel expression generating several CI configuration files

## Support

Basic: Gitlab CI, Github Actions


## CI Configuration

Nickel CI file:

```ncl
# ci.ncl
{
    stages = [
        "build",
        "deploy"
    ],
    jobs = [
        {
            name = "build",
            image = "golang:alpine",
            stage = "build",
            script = [
                "apk update",
                "go build -o bin/hello",
                { paths = [ "bin/hello" ], expire_in = 7 }
            ]
        },
        {
            name = "deploy",
            image = "golang:alpine",
            stage = "deploy",
            needs = [ "/bin/hello" ],
            script = [
                "echo 'Deploying to Staging'",
                "scp bin/hello remoteuser@remotehost:/remote/directory"
            ]
        }
    ]
}

```

This CI configuration defines 2 jobs: `build` and `deploy`, with support for artifact.

## Exporting

In the `project.ncl` change the name of the example to point to the desired CI configuration.

```
# Gitlab CI
nickel export -f tests/gitlab-ci.ncl --format yaml
# Github Actions
nickel export -f tests/github-actions.ncl --format yaml
```
