# iacm-ccm-demo

provision:
- three ec2 instances
    - nginx
    - one idle instance
    - one instance using two cpu
        - use [stress](https://linux.die.net/man/1/stress) to peg cpus
    - one instance using four cpu
        - - use [stress](https://linux.die.net/man/1/stress) to peg cpus  
- alb
    - points at ec2

workshop:
- provision the lab using terraform
    - optional Harness IacM workspace definition in `workspace.tf.example`
    - optional Harness IacM OPA policy in `iacm.opa`
- create perspective in Harness CCM to show costs of application
- use Harness CCM to autostop instances using the existing ALB
- use Harness asset governance to resize the idle and half-idle instances
    - example governance rule in `resize.yaml`
