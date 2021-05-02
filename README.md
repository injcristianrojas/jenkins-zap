# Jenkins ZAP Docker image

This Docker image aims to be a solution for [OWASP ZAP](https://www.zaproxy.org/) 
DAST operations using Jenkins. It includes the base image for Jenkins LTS
and a downloaded version of OWASP ZAP, for pipelines that includes them.

# Usage

* Download image using: `docker pull injcristianrojas/jenkins-zap`
* When launching, either with `docker run` or Docker Compose, make sure that
Jenkins runs on another port different than 8080. This is because most Java
applications use that same port, and your app won't launch if using the same
port. For this, use an environment variable: `JENKINS_OPTS="--httpPort=8585"`
* Launch the OWASP ZAP server using your Jenkinsfile. Again, use another port, since OWASP ZAP also uses 8080 by default. For example:

```shell
/opt/zaproxy/zap.sh -daemon -port 8989 -host 0.0.0.0 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true -config api.disablekey=true -config scanner.strength=INSANE &
```

* Do your DAST tests. I personally recommend the
[ZAP Maven Plugin](https://github.com/hypery2k/zap-maven-plugin) developed by
@hypery2k which includes features that allow to test tha autneticated parts of
your application.
* Explicitly shut down ZAP. This can be accomplished leveraging its API, like
this:

```shell
curl http://localhost:8989/JSON/core/action/shutdown/
```

You cah check out an example using Jenkins pipelines
[here](https://github.com/injcristianrojas/swsec-intro-spring-boot/blob/master/Jenkinsfile).