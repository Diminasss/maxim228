import datetime
from delete_folder import del_folder
from clone_repo import clone
from task_check import check_file


folder_name = datetime.datetime.now().strftime("%H%M%S")
file_path = "https://github.com/lezhev/Neo.edu"
extended_output = "15"
task_input = "sum_process([1, 2, 3, 4, 5])"

clone(folder_name, file_path)

with open(f"D:/Neo.edu/cloned_repos/{folder_name}/main.py", "a") as file:
    file.write(f"print({task_input})")
    file.flush()
    file.close()

if check_file(f"D:/Neo.edu/cloned_repos/{folder_name}/main.py", extended_output):
    print("ok")
else:
    print("ne ok")

del_folder(folder_name)

