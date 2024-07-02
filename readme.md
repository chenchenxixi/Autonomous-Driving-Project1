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
* 横向控制：针对误差模型，观察发现多出一项关于航向角加速度的线性项，考虑使用前馈控制，抵消这部分稳态误差，因为状态方程的输入矩阵
  $B$不是方阵，因此不可以通过简单的求逆来解决这部分稳态误差，因此使用数学软件计算出具体的表达式，结果表明

**3.代码** 
