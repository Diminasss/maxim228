import subprocess


def check_file(file_path, expected_output):
    result = subprocess.run(['python', file_path], capture_output=True, text=True)
    output = result.stdout
    print(output, expected_output)
    return output == expected_output

