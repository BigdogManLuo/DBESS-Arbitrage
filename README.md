# Recurrence of thesis: Economic Operation Strategy of Distributed Battery Energy Storage System
## 论文背景 Thesis background
分散式储能（Distributed Battery Energy Storage System,DBESS) 可以理解为储能电源分散式接入电网，其充放电功率可控，具有电力系统削峰填谷的作用。论文《分散式储能自趋优经济运行的强化学习算法》提出了一种model-free的分布式储能自趋优经济运行算法，以分布式储能的低储高发收益和参与电力市场需求响应收益之和最大为目标，考虑充放电功率、容量、需求响应时段、SOC状态转换、DBESS调用成本等约束条件，将分布式储能在某个时段的充放电策略问题建模为马尔可夫决策过程（Markov decision process，MDP）。又由于电价数据具有不确定性和周期性，因此采用无模型的强化学习Qlearning算法求解，得到某个时段某SOC状态的DBESS的最优充放电行动即充放电功率。
## 笔者的工作 My Work
根据《分散式储能自趋优经济运行的强化学习算法》中所建立的分布式储能收益模型和相关数据，采用强化学习Qlearning算法确定分布式储能的充放电策略，满足一天内低储高发，复现并优化了论文中的算例。详见“DBESS模型建立与求解.pdf ”

## 文件说明 File Description
采用MATLAB实时脚本编写
### src文件夹
calcuC.m：计算DBESS老化成本函数 <br>
updateS.m：DBESS的SOC状态转换方程<br>
case1~5.mlx：每一个算例的源文件，mlx文件只能用matlab打开<br>
draw1~5.mlx：每一个算例的可视化<br>
### data文件夹
data文件为算例可视化需要用到的数据，由case1~5产生<br>
### picture文件夹
picture文件为算例可视化的运行结果
### 可视化说明
在运行可视化的实时脚本（draw1~draw5)时，请注意以下几点：<br>
<br>
1.请确保在运行draw脚本之前，先运行了与之对应算例的case脚本
2.请确保data文件导入了matlab的工作文件夹
