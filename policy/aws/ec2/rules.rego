package policy.aws.ec2

not_configured[decision] {
  parameters := {
    "allowed_ami_ids": set()
  }

  data.global.systemtypes["terraform:1.0"].library.provider.aws.ec2.whitelist_ami.v1.ec2_whitelist_amis[message]
    with data.library.parameters as parameters

  decision := {
    "allowed": false,
    "message": message
  }
}
# Packages 1 level below the `aws` package let you organize your rules
#    according to the services they impact, e.g. aws.ec2 or aws.s3
# All enforce/monitor rules in any package of the form aws.X
#    will be applied to every terraform plan.  The name X is irrelevant
#    and is only useful as a way to organize your rules.
# You may put helpers into packages at deeper levels of the hiearchy,
#    e.g. aws.X.Y, but do not put enforce/monitor rules into those packages
#    since they will not be evaluated unless you use them as helpers.
