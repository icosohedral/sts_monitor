# script name: sts_monitor_som7.sh
# use for som v7
# use for monitor sts server status

# log file: /var/log/sts_monitor.log
log_file="/var/log/sts_monitor.log"

# monitor process list
# [workflow, qemu, postgres, uwsgi]
process_list="workflow qemu postgres uwsgi"

# get memory usage
mem_usage=`free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }'`

# memery top 5
mem_top5=`ps aux | sort -k4nr | head -n 5 | awk '{print $4,$11}'`

# get cpu usage with python
# import psutil
# cpu_percent_list = [psutil.cpu_percent(interval=1, percpu=True) for _ in range(3)]
# result = round(sum(cpu_percent for sublist in cpu_percent_list for cpu_percent in sublist) / len(cpu_percent_list), 1)
# print(result)
cpu_usage=`python -c "import psutil; cpu_percent_list = [psutil.cpu_percent(interval=1, percpu=True) for _ in range(3)]; result = round(sum(cpu_percent for sublist in cpu_percent_list for cpu_percent in sublist) / len(cpu_percent_list), 1); print(str(result)+'%')"`

# cpu top 5
cpu_top5=`ps aux | sort -k3nr | head -n 5 | awk '{print $3,$11}'`

# get disk usage (datavol-datavolfs)
disk_usage=`df -h | grep "/flash/system/volume" | awk '{print $4}'`

# get time now
time_now=`date +"%Y-%m-%d %H:%M:%S"`

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
echo -e "\033[32mTime:           $time_now\033[0m"
echo -e "\033[32mMemory Usage:   $mem_usage\033[0m"
echo -e "$mem_top5"
echo -e "\033[32mCPU Usage:      $cpu_usage\033[0m"
echo -e "$cpu_top5"
echo -e "\033[32mDisk Usage:     $disk_usage\033[0m"
echo -e "\033[32mProcess Status: $process_list\033[0m"
for process in $process_list
do
    process_status=`ps -ef | grep $process | grep -v grep | wc -l`
    if [ $process_status -gt 0 ]; then
        echo -e "** $process ON"
    else
        echo -e "** $process OFF"
    fi
done

# print in purple
# Write in logfile: /var/log/sts_monitor.log
echo -e "\033[35mWrite in logfile: $log_file\033[0m"

# write into log file
echo -e "\033[32mTime:           $time_now\033[0m" >> $log_file
echo -e "\033[32mMemory Usage:   $mem_usage\033[0m" >> $log_file
echo -e "$mem_top5" >> $log_file
echo -e "\033[32mCPU Usage:      $cpu_usage\033[0m" >> $log_file
echo -e "$cpu_top5" >> $log_file
echo -e "\033[32mDisk Usage:     $disk_usage\033[0m" >> $log_file
echo -e "\033[32mProcess Status: $process_list\033[0m" >> $log_file
for process in $process_list
do
    process_status=`ps -ef | grep $process | grep -v grep | wc -l`
    if [ $process_status -gt 0 ]; then
        echo -e "** $process ON" >> $log_file
    else
        echo -e "** $process OFF" >> $log_file
    fi
done

