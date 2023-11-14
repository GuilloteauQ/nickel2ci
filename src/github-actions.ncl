let config = import "../examples/simple2.ncl" in

let Contract = import "ci-contract.ncl" in

let prepend_run = fun step =>
    if std.is_string step then
        { run = step }
    else
        { uses = "actions/upload-artifact@v3", with = { name = std.array.first step.paths, path = std.array.first step.paths, retention-days = step.expire_in}}
in

let generate_artifact_download_step = fun need => 
    { uses = "actions/download-artifact@v3", with = { name = need}}
in

let github_jobs = fun data => 
    {
        "%{data.name}" = {
            runs-on = data.os_vm,
            steps = (std.array.map generate_artifact_download_step data.needs) @ (std.array.map prepend_run data.script), 

        } & (if data.image != "" then { container = data.image } else {}),
    }

in

let data = (config | Contract)
in

{
    on = "[push]",
    jobs = std.record.merge_all (std.array.map github_jobs data.jobs),
}


