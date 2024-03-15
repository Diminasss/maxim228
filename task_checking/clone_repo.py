import subprocess


def clone(folder_name, repo_url):
    destination_path = f"cloned_repos/{folder_name}"

    command = ["git", "clone", repo_url, destination_path]

    subprocess.run(command, check=True)
