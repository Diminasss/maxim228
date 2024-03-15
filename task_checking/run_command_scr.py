import datetime
from delete_folder import del_folder
from clone_repo import clone
from task_check import check_file


folder_name = datetime.datetime.now().strftime("%H%M%S")
file_path = "https://github.com/lezhev/Neo.edu"
expected_output = '[1, 2, 3, 4, 5, 6, 7, 8, 9]\n'
task_input = "merge_sort([4, 2, 7, 1, 9, 5, 3, 8, 6])"

clone(folder_name, file_path)

with open(f"cloned_repos/{folder_name}/main.py", "a") as file:
    file.write(f"\nprint({task_input})")
    file.flush()
    file.close()

if check_file(f"cloned_repos/{folder_name}/main.py", expected_output):
    print("ok")
else:
    print("ne ok")

del_folder(folder_name)

