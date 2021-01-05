# LimtedSubmit
*一个用于保持自己不被人打死的脚本*

## 主要用途
在Slurm管理的超算上提交一定数量的任务并维持，
防止同时提交过多任务导致被其他人打死。

## 使用方法
1. 所有任务应位于`Submit.sh`所在目录的子目录中并命名为`job.sh`，所有任务的名称应分行记录在`JobList.dat`文件中；
2. 在`Submit.sh`所在目录新开启一个screen，例如运行`screen -R "Submit"`开启一个名为`Submit`的screen（其他具体用法可参考[这里](https://www.runoob.com/linux/linux-comm-screen.html)）；
3. 在新的screen中使用`./Submit.sh 5 MyJob 600`运行当前脚本，其中`5`为同时存在的任务上限、`MyJob`为用于grep确定是否为自己任务的关键词、`600`为脚本的检验间隔（默认为600秒）；
4. 开始享受自动提交任务的快乐。

## TODO
没想到