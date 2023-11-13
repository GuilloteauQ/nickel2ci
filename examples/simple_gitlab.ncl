{
    stages = [
        "hello"
    ],
    jobs = [
        {
            name = "hello",
            stage = "hello",
            script = [ "echo 'Hello World'"],
        },
    ],
}
