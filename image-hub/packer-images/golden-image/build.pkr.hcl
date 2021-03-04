build {
    sources = [
        "source.amazon-ebs.ami-gold"
    ]

    provisioner "shell" {
        inline = [
            "echo 'packer' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
        ]
        script = "./scripts/inspect_agent_install.sh"
    }
}