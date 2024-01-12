#!/usr/bin/env python

import os
import psutil
from datetime import datetime

# log file: /var/log/sts_monitor.log
log_file = "/var/log/sts_monitor.log"

# monitor process list
# [workflow, qemu, postgres, uwsgi]
process_list = ["workflow", "qemu", "postgres", "uwsgi"]

# get memory usage
mem_usage = os.popen("free -m | awk 'NR==2{printf \"%.2f%%\", $3*100/$2 }'").read().strip()

# memery top 5
mem_top5 = os.popen("ps aux | sort -k4nr | head -n 5 | awk '{print $4,$11}'").read().strip()

# get cpu usage
cpu_percent_list = [psutil.cpu_percent(interval=1, percpu=True) for _ in range(3)]
cpu_usage = round(sum(cpu_percent for sublist in cpu_percent_list for cpu_percent in sublist) / len(cpu_percent_list), 1)

# cpu top 5
cpu_top5 = os.popen("ps aux | sort -k3nr | head -n 5 | awk '{print $3,$11}'").read().strip()

# get disk usage (datavol-datavolfs)
disk_usage = os.popen("df -h | grep \"/flash/system/volume\" | awk '{print $4}'").read().strip()

# get time now
time_now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# print (title in color green)
# Time:           2024-01-12 13:01:20
# Memory Usage:   86.84%
#                 50.8 qemu
#                 3.4 /usr/java/bin/java
#                 2.3 /flash/system/appr/testconnect
#                 1.8 /usr/bin/postgres
#                 1.1 uwsgi
# CPU Usage:      0.72%
#                 4.1 qemu
#                 3.0 /flash/system/appr/logsave
#                 1.4 /flash/system/appr/replayserver
#                 0.4 /usr/bin/python
#                 0.2 /usr/bin/python
# Disk Usage:     8%
# Process Status:
# workflow on
# qemu on
# postgres on
# uwsgi on

result = []
result.append("\033[32mTime:           {}\033[0m".format(time_now)
                + "\n\033[32mMemory Usage:   {}\033[0m".format(mem_usage)
                + "\n" + mem_top5
                + "\n\033[32mCPU Usage:      {}%\033[0m".format(cpu_usage)
                + "\n" + cpu_top5
                + "\n\033[32mDisk Usage:     {}\033[0m".format(disk_usage)
                + "\n\033[32mProcess Status: {}\033[0m".format(" ".join(process_list)))

print("\033[32mTime:           {}\033[0m".format(time_now))
print("\033[32mMemory Usage:   {}\033[0m".format(mem_usage))
print(mem_top5)
print("\033[32mCPU Usage:      {}%\033[0m".format(cpu_usage))
print(cpu_top5)
print("\033[32mDisk Usage:     {}\033[0m".format(disk_usage))
print("\033[32mProcess Status: {}\033[0m".format(" ".join(process_list)))
for process in process_list:
    process_status = os.popen("ps -ef | grep {} | grep -v grep | wc -l".format(process)).read().strip()
    if int(process_status) > 0:
        print("** {} ON".format(process))
    else:
        print("** {} OFF".format(process))

# print in purple
# Write in logfile: /var/log/sts_monitor.log
print("\033[35mWrite in logfile: {}\033[0m".format(log_file))

# write into log file
with open(log_file, "a") as f:
    f.write("\033[32mTime:           {}\033[0m\n".format(time_now))
    f.write("\033[32mMemory Usage:   {}\033[0m\n".format(mem_usage))
    f.write(mem_top5 + "\n")
    f.write("\033[32mCPU Usage:      {}%\033[0m\n".format(cpu_usage))
    f.write(cpu_top5 + "\n")
    f.write("\033[32mDisk Usage:     {}\033[0m\n".format(disk_usage))
    f.write("\033[32mProcess Status: {}\033[0m\n".format(" ".join(process_list)))
    for process in process_list:
        process_status = os.popen("ps -ef | grep {} | grep -v grep | wc -l".format(process)).read().strip()
        if int(process_status) > 0:
            f.write("** {} ON\n".format(process))
        else:
            f.write("** {} OFF\n".format(process))