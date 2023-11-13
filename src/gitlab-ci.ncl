let config = import "../examples/simple_gitlab.ncl" in

let Contract = import "ci-contract.ncl" in

let get_stages = fun data =>
    # TODO get unique
    std.array.map (fun x => x.stage) data
in

let create_entry = fun data =>
    { "%{data.name}" = { stage = data.stage, script = data.script, },}
in

let data = (config | Contract)
in

{
    stages = data.stages,
} & (std.record.merge_all (std.array.map create_entry data.jobs))


