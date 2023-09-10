# Jenkins Security

`Security Realm` and `Authorization`&#x20;

Install `Role-based Authorization` plugin.

\------------------------------------------------\
`Distributed builds` in Jenkins is a great start for protecting the Jenkins controller from malicious (or just broken) build scripts.

the best describes the concept of distributed builds in Jenkins : Builds should be executed on other nodes than the built-in node

\------------------------------------------------

By default, Jenkins run its builds on the `built-in node`. It is done to make smooth transition towards learning Jenkins but is `inadvisable` in long term.\
It is due to the fact that any builds running on the built-in node have the same level of access to the controller file system as the Jenkins process.

\-------------------------------------------------

Configure Jenkins to prevent builds from running on the `Built-In Node` directly :&#x20;

Navigate to `Manage Jenkins » Manage Nodes and Clouds` screen and change the number of Executors to `0` for the `Built-In Node`.
