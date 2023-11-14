let Artifact = {
    paths
        | doc "Paths to save"
        | Array String,
    expire_in
        | doc "How many days to keep the artifact"
        | Number,
}

in

let Script = fun label value =>
    if std.is_string value then
        value | String
    else
        value | Artifact
in

let Job = {
    name
        | doc "Name/Label of the job"
        | String,
    image
        | doc "Docker Image to use"
        | String
        | default
        = "",
    os_vm
        | doc "OS to use"
        | String
        | default
        = "ubuntu-latest",
    stage
        | doc "Name of the Stage"
        | String,
    needs
        | doc "Paths of required artifacts"
        | Array String
        | default
        = [],
    script
        | doc "Commands to execute"
        | Array Script,
}
in
{
    stages
        | doc "Names of the stages"
        | Array String,
    jobs
        | doc "Jobs"
        | Array Job,
}
