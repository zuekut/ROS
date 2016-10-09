#include "ros/ros.h"
#include "std_msgs/String.h"
#include "../Triangles.h"
#include <sstream>

/**
 * This tutorial demonstrates simple sending of messages over the ROS system.
 */
int main(int argc, char **argv)
{
  ros::init(argc, argv, "parameter_node");

  ros::NodeHandle n;



  ros::Publisher parameters_pub = n.advertise<ass1::Triangles>("cmd", 1000);

  ros::Rate loop_rate(10);

  int count = 0;
  while (ros::ok()&&count < 2)
  {
    double side_lenght;
    bool cw;

    std::cout<<"enter side lenght";
    std::cin>>side_lenght;
    std::cout<<"clockwise";
    std::cin>>cw;
count++;

    ass1::Triangles msg;

    msg.side_lenght = side_lenght;
    
    msg.cw = cw;

    parameters_pub.publish(msg);
    
    ros::spinOnce();
  }


  return 0;
}
