import subprocess

print("Gitlab Runner is installing")

if subprocess.call("command -v gitlab-runner", shell=True) == 0:
    print("GitLab Runner is already installed.")
    exit(0)

subprocess.call("curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash", shell=True)
subprocess.call("sudo apt-get install gitlab-runner", shell=True)

subprocess.call("sudo gitlab-runner register", shell=True)

subprocess.call("sudo systemctl start gitlab-runner", shell=True)
subprocess.call("sudo systemctl enable gitlab-runner", shell=True)

print("GitLab Runner installation complete.")