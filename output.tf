
output "jenkins_ip" {
    value = format("https://%s:%s", aws_instance.jenkins-build-agent.pulic_ip, var.jenkins_port)
}


