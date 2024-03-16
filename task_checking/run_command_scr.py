import datetime
from task_checking.delete_folder import del_folder
from task_checking.clone_repo import clone
from task_checking.task_check import check_file


def check(file_path="https://github.com/lezhev/Neo.edu",
          task_input=["merge_sort([4, 2, 7, 1, 9, 5, 3, 8, 6])\n", "merge_sort([4, 2, 7, 1, 5, 3, 6])\n", "merge_sort([4, 2, 1, 5, 3, 6])\n"],
          expected_output=["[1, 2, 3, 4, 5, 6, 7, 8, 9]\n", "[1, 2, 3, 4, 5, 6, 7]\n", "[1, 3, 4, 5, 6]\n"]):

    folder_name = datetime.datetime.now().strftime("%H%M%S")

    clone(folder_name, file_path)

    bool_tuple = []

    for i in range(len(task_input)):
        with open(f"cloned_repos/{folder_name}/main.py", "r") as f:

            source_file = f.readlines()

        with open(f"cloned_repos/{folder_name}/main.py", "a") as f:

            f.write(f"\n"
                    f"print({task_input[i]})")
            f.close()

            bool_tuple.append(check_file(f"cloned_repos/{folder_name}/main.py", expected_output[i]))

        with open(f"cloned_repos/{folder_name}/main.py", "w") as f:

            f.writelines(source_file)
            f.flush()
            f.close()

    del_folder(folder_name)
    return bool_tuple
