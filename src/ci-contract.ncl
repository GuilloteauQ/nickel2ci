let Artifacts = {
    paths
        | doc "Paths to save"
        | Array String,
    expire_in
        | doc "How many days to keep the artifact"
        | Number
} in

let Job = {
    name
        | doc "Name/Label of the job"
        | String,
    image
        | doc "Docker Image to use"
        | String,
    os_vm
        | doc "OS to use"
        | String
        | default
        = "ubuntu-latest",
    stage
        | doc "Name of the Stage"
        | String,
    script
        | doc "Commands to execute"
        | Array String,
    artifacts
        | doc "Artifacts"
        | Artifacts,

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
