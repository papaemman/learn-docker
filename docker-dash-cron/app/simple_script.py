import os
from datetime import datetime
from pathlib import Path


def write_file(filename, data):
    if os.path.isfile(filename):
        with open(filename, "a") as f:
            f.write("\n" + data)
    else:
        with open(filename, "w+") as f:
            f.write(data)


def print_time():
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    data = "CRON JOB | Current Time = " + current_time
    return data


# Call the function
print("Cron is running....")
write_file(
    filename = Path(__file__).parent.parent / "logs" / "cronjob.log",
    data=print_time()
)