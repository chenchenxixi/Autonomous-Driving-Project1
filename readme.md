**这是一个关于自动驾驶控制算法的项目，涵盖了简单场景(直线，变道和转弯)和复杂场景(转弯半径较小)下的控制算法的实现**

**1.效果** 

* 直线行驶

  ![image](https://github.com/chenchenxixi/Autonomous-Driving-Project1/blob/main/gif/%E7%9B%B4%E7%BA%BF.gif) 

* 变道

  ![image](https://github.com/chenchenxixi/Autonomous-Driving-Project1/blob/main/gif/%E5%8F%98%E9%81%93.gif)

* 转弯

  ![image](https://github.com/chenchenxixi/Autonomous-Driving-Project1/blob/main/gif/%E8%BD%AC%E5%BC%AF.gif)

* 复杂场景

  参考轨迹如下所示：

  ![image](https://github.com/chenchenxixi/Autonomous-Driving-Project1/blob/main/gif/planning_trajectory.png)

  跟踪效果：

  ![image](https://github.com/chenchenxixi/Autonomous-Driving-Project1/blob/main/gif/%E5%A4%8D%E6%9D%82%E5%9C%BA%E6%99%AF%E6%95%88%E6%9E%9C.gif)

  ![image](https://github.com/chenchenxixi/Autonomous-Driving-Project1/blob/main/gif/%E8%B7%9F%E8%B8%AA%E6%95%88%E6%9E%9C%E5%B8%A6%E6%A0%87%E7%AD%BE.png)



**2.理论**

* 规划：生成在世界坐标系下的参考轨迹
  $(x_r, y_r, \theta, k_r)$
* 建模：在车身坐标系下建立二自由度的车辆动力学模型,选择并计算投影点，将车身坐标系下的模型投影至自然坐标系，形成误差模型。
* 横向控制：

  ①针对误差模型，观察发现多出一项关于航向角加速度的线性项，考虑使用前馈控制，抵消这部分稳态误差，因为状态方程的输入矩阵
  $B$不是方阵，因此不可以通过简单的求逆来解决这部分稳态误差，需使用数学软件计算出具体的表达式，结果表明若需抵消这个稳态误差则控制量应该加上
  $\delta_f = k[a+b-bk_3-\frac{mv^2_x}{a+b}(\frac{b}{C_{\alpha f}}+\frac{a}{C_{\alpha r}}K_3-\frac{a}{C_{\alpha r}})]$
  ，其中
  $K_3$为LQR的反馈增益中的第三个增益。

  ②针对线性误差模型使用LQR控制器。本质是求解黎卡提方程得到反馈增益的P矩阵，进而求出状态反馈的增益

* 投影点计算：

  参考轨迹是离散点，找到距离当前位置最近的点，称之为匹配点，将匹配点和投影点的曲率看做相等，利用这个条件和几何关系计算出投影点

* 预测模块

  在跟踪过程中，车的轨迹跟踪不具有预测性，根据误差量来调整控制量，因此需要加入预测模块来提前控制。

* 整体控制框架

  ![image](https://github.com/chenchenxixi/Autonomous-Driving-Project1/assets/43198432/586a6d3f-90e0-433f-872b-93060904cd6e)



**3.代码** 

  本仓库的代码均为matlab代码使用simulink和carsim联合仿真。所有代码都在src文件夹中，该文件夹下pid_lqr_demo.slx为simulink文件，里面包含了所有的控制器实现的模块。lqr_offline.m用于计算不同速度下对应的LQR控制器的反馈增益，并存储起来。routing_planning.m为轨迹规划模块，用于规划轨迹，但是曲率变化是不连续的。plot_tracking_error.m用来绘制最终的跟踪效果图。运行顺序如下：

* 打开carsim，将carsim模型与simulink模型（pid_lqr_demo.slx）链接起来
* 运行routing_planning.m和lqr_offline.m文件
* 运行pid_lqr_demo.slx
* 运行plot_tracking_error.m绘制跟踪误差曲线图
