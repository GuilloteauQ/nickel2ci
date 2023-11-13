let config = import "../examples/simple_gitlab.ncl" in

let Contract = import "ci-contract.ncl" in

let prepend_run = fun step =>
    { run = step }
in

let github_jobs = fun data => 
    {
        "%{data.name}" = {
            runs-on = data.os_vm,
            steps = std.array.map prepend_run data.script, 

        },
    }

in

let data = (config | Contract)
in

{
    on = "[push]",
    jobs = std.record.merge_all (std.array.map github_jobs data.jobs),
}


