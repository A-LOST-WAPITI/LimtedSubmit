#!/bin/sh


jobNameListFile="JobList.dat"   # 存储任务列表的文件


maxJobNumAtATime=$1 # 最大同时存在的任务数
JobKeyword=$2       # 任务的关键词
waitTime=$3         # 每次检测的等待时间（默认值为10分钟）
waitTime=${waitTime:-600}           # 设置等待默认值
JobNameList=$(cat $jobNameListFile) # 获取任务名的列表


for JobName in $JobNameList # 遍历所有任务名
do
    # 信息输出
    echo "*********"
    echo "Target Job is titled as $JobName"
    echo "*********"
    echo

    submitFlag=0    # 用于检测是否已经提交当前任务
    waitCount=0     # 用于记录等待次数

    while [ $submitFlag -le 0 ] # 如果当前任务未提交则不断检验
    do
        jobNumAtATime=$(squeue | grep ${JobKeyword} | grep -v "grep" | wc -l)   # 获取当前已经提交任务的数量

        if [ $jobNumAtATime -lt $maxJobNumAtATime ] # 如果当前任务数没有达到上限
        then
            echo -e "Submitting\n"  # 信息输出

            cd $JobName                 # 进入任务名文件夹
            sbatch -J ${JobName} job.sh # 将任务名文件夹下job.sh提交
            cd ..                       # 返回脚本目录

            let submitFlag++    # 当前任务已提交
        else    # 如果当前任务数已经达到上限
            let waitCount++                             # 等待次数累加
            echo "Waitting for the ${waitCount}th time" # 信息输出
            sleep $waitTime                             # 等待下次检验
        fi
    done
done