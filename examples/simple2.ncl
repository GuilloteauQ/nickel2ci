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
