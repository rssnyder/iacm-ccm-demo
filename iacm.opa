package terraform_plan

allowed_instance_types = ["t3.nano", "m7g.xlarge"]

required_tags = ["Name", "ttl"]

# Deny any plan that makes use of an insteance type outside of the allowed list
deny[sprintf("%s: instance type %s is not allowed", [r.address, r.values.instance_type])] {
	r = input.planned_values.root_module.resources[_]
	r.type == "aws_instance"
	not contains(allowed_instance_types, r.values.instance_type)
}

# Deny any plan that makes specified instances that are missing any of the required tags
deny[sprintf("%s: missing required tag '%s'", [r.address, required_tag])] {
	r = input.planned_values.root_module.resources[_]
	r.type == "aws_instance"
	existing_tags := [key | r.values.tags_all[key]]
	required_tag := required_tags[_]
	not contains(existing_tags, required_tag)
}

contains(arr, elem) {
	arr[_] = elem
}
