# script name: sts_monitor_som7.sh
# use for som v7
# use for monitor sts server status

# log file: /var/log/sts_monitor.log
log_file="/var/log/sts_monitor.log"

# get memory usage
mem_usage=`free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }'`

# memery top 5
mem_top5=`ps aux | sort -k4nr | head -n 5 | awk '{print $4,$11}'`

# get cpu usage
cpu_usage=`top -bn1 | grep load | awk '{printf "%.2f%%", $(NF-2)}'`

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
echo -e "\033[32mTime:           $time_now\033[0m"
echo -e "\033[32mMemory Usage:   $mem_usage\033[0m"
echo -e "$mem_top5"
echo -e "\033[32mCPU Usage:      $cpu_usage\033[0m"
echo -e "$cpu_top5"
echo -e "\033[32mDisk Usage:     $disk_usage\033[0m"

echo -e "Write in logfile: $log_file"
# write into log file
echo -e "\033[32mTime:           $time_now\033[0m" >> $log_file
echo -e "\033[32mMemory Usage:   $mem_usage\033[0m" >> $log_file
echo -e "$mem_top5" >> $log_file
echo -e "\033[32mCPU Usage:      $cpu_usage\033[0m" >> $log_file
echo -e "$cpu_top5" >> $log_file
echo -e "\033[32mDisk Usage:     $disk_usage\033[0m" >> $log_file

