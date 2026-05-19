# citadel-victim

Deliberately vulnerable demo repo for the Citadel hackathon project.
Used to demonstrate detection of supply-chain attacks against
GitHub Actions runners.

**Do not deploy any code here. This repo intentionally has insecure
workflow patterns** (`pull_request_target` + checkout of the fork's
head commit + secrets exposed to the build script).

See [Citadel](https://github.com/kiran-sec/citadel) for the defender.
