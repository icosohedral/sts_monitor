# 系统监控脚本

## som7

### 说明
som7/sts_monitor_som7.sh 用于监控SOM7的状态，包括CPU、内存、硬盘等，以及SOM7上运行的进程。

### 使用方法
把脚本放到/root/目录下，然后执行
```bash
chmod +x /root/sts_monitor_som7.sh
```

## lec4

### 说明
lec4/sts_monitor_lec4.sh 用于监控LEC4的状态，包括CPU、内存、硬盘等，以及LEC4上运行的进程。

### 使用方法
把脚本放到/root/目录下，把cpu文件放到/flash/system/storage/目录下，然后执行
```bash
chmod +x /root/sts_monitor_lec4.sh
chmod +x /flash/system/storage/cpu
```
