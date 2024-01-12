# script name: sts_monitor_lec4.sh
# use for lec v4
# use for monitor sts server status
# cp cpu to /usr/bin

# log file: /var/log/sts_monitor.log
log_file="/var/log/sts_monitor.log"

# get memory usage with top -n 1
mem_usage=`top -n 1 | grep Mem | awk '{printf "%.2f%%", $8*100/$4 }'`

# get cpu usage with excutable file cpu
# /flash/system/storage/cpu
cpu_usage=`/flash/system/storage/cpu`

# get top -n 1
#top=`top -n 1`

# get disk
disk_usage=`df -h | grep "/flash/system/storage" | awk '{print $5}'`

# get time
time_now=`date +"%Y-%m-%d %H:%M:%S"`

# print (title in color green)
echo -e "\033[32mTime:           $time_now\033[0m"
echo -e "\033[32mMemory Usage:   $mem_usage\033[0m"
echo -e "\033[32mCPU Usage:      $cpu_usage%\033[0m"
# echo -e "$top"
echo -e "\033[32mDisk Usage:     $disk_usage\033[0m"
echo -e "Write in logfile: $log_file"

# write into log file
echo -e "\033[32mTime:           $time_now\033[0m" >> $log_file
echo -e "\033[32mMemory Usage:   $mem_usage\033[0m" >> $log_file
echo -e "\033[32mCPU Usage:      $cpu_usage%\033[0m" >> $log_file
#echo -e "$top" >> $log_file
echo -e "\033[32mDisk Usage:     $disk_usage\033[0m" >> $log_file
