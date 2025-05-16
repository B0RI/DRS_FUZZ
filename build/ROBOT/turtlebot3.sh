#!/usr/bin/env bash
set -e

sudo apt-get update && sudo apt-get install -y ros-${ROS_DISTRO}-gazebo-* \
    ros-${ROS_DISTRO}-cartographer ros-humble-cartographer-ros \
    ros-${ROS_DISTRO}-navigation2 ros-humble-nav2-bringup \
  && rm -rf /var/lib/apt/lists/*

mkdir -p ~/turtlebot3_ws/src
cd ~/turtlebot3_ws/src
git clone -b ${ROS_DISTRO} https://github.com/ROBOTIS-GIT/DynamixelSDK.git
git clone -b ${ROS_DISTRO} https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git
git clone -b ${ROS_DISTRO} https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b ${ROS_DISTRO} https://github.com/ROBOTIS-GIT/turtlebot3.git

source /opt/ros/humble/setup.sh
cd ~/turtlebot3_ws
colcon build --parallel-worker 1 --cmake-args -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS=-fsanitize=address -DCMAKE_CXX_FLAGS=-fsanitize=address

echo 'export TURTLEBOT3_MODEL=burger' >> /etc/profile.d/turtlebot3.sh
