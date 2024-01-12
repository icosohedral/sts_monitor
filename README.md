# 系统监控脚本

## som7

### 说明
som7/sts_monitor_som7.sh 用于监控SOM7的状态，包括CPU、内存、硬盘等，以及SOM7上运行的进程。

### 使用方法
把脚本放到/root/目录下，添加权限
```bash
chmod +x /root/sts_monitor_som7.sh
```
然后执行
```bash
/root/sts_monitor_som7.sh
```

### 定时任务
添加到crontab中，每一小时执行一次
```bash
crontab -e
0 * * * * /root/sts_monitor_som7.sh
```

## lec4

### 说明
lec4/sts_monitor_lec4.sh 用于监控LEC4的状态，包括CPU、内存、硬盘等，以及LEC4上运行的进程。

### 使用方法
把脚本放到/root/目录下，把cpu文件放到/flash/system/storage/目录下，添加权限
```bash
chmod +x /root/sts_monitor_lec4.sh
chmod +x /flash/system/storage/cpu
```
然后执行
```bash
/root/sts_monitor_lec4.sh
```

### 定时任务
添加到WatchDog.sh脚本中
