
output "jenkins_ip" {
    value = format("http://%s:%s", aws_instance.jenkins-build-agent.public_ip, var.jenkins_port)
}


