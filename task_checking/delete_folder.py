import os


def del_folder(folder_name):
    folder_path = f"cloned_repos/{folder_name}"

    os.system(f'rmdir /s /q "{folder_path}"')
