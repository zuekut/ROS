//Dimitar Aleksov

#include "ros/ros.h"
#include "../Triangles.h"
#include "geometry_msgs/Twist.h" //turtle's cmd_vel
#include "turtlesim/Pose.h" //reading turtle's position
#include "turtlesim/Color.h"
#include "turtlesim/SetPen.h"
#include "turtlesim/Kill.h"
#include "sstream"


using namespace std;

ros::Publisher velocity_publisher;

double speed, angular_speed;
double side_lenght, angle;
bool isForward, clockwise;

const double PI = 3.14159265359;

void move(double speed, double side_lenght, bool isForward);
void rotate(double angular_speed, double angle, bool cloclwise);
double degrees2radians(double angle_in_degrees);


void position_callback(const turtlesim::Pose::ConstPtr& msg)
{
    ROS_INFO("Turtle @[%f, %f, %f]",msg->x,msg->y,msg->theta);
}

void triangleCallback(const ass1::Triangles::ConstPtr& msg)
{
    side_lenght = abs(msg->side_lenght);
    clockwise = msg->cw;
    if (side_lenght>5.55)   //current position in x is 5.54 
    {                       //size of window is 11.08 learned the information with the position_callback
        side_lenght =5.54;  
    }
    
    for (int i = 0; i < 2; ++i)
    {
        move(3, side_lenght, true);
        rotate(degrees2radians(100), degrees2radians(120), clockwise);
    }
    move(3, side_lenght, true);
}


int main(int argc, char **argv)
{
    // Initiate new ROS node
    ros::init(argc, argv, "turtlesim");
    ros::NodeHandle n;
    
    ros::service::waitForService("turtle1/set_pen");
    ros::ServiceClient client_color = n.serviceClient<turtlesim::SetPen>("turtle1/set_pen");
    turtlesim::SetPen req_color;
    req_color.request.b = 0;
    req_color.request.r =255;
    req_color.request.g =0;
    req_color.request.width = 3;
    req_color.request.off =0;
    bool success = client_color.call(req_color);
    if ( success) 
    {
        ROS_INFO_STREAM( "success") ;
    } 
    else 
    { 
        ROS_ERROR_STREAM( "Couldn't set the pen color" ) ;
    }

    
    //Define the subscriber to turtle's position
    //ros::Subscriber sub = n.subscribe("/turtle1/pose",1,position_callback);
    //  /turtle1/cmd_vel is the Topic name
    //  /geometry_msgs::Twist is the msg type 
    ROS_INFO("\n\n\n ********START ASSIGNMENT 1 *********\n");
  
    


     ROS_INFO("\n\n\n ********END ASSIGNMENT 1 *********\n");

    ros::Subscriber sub_param = n.subscribe("cmd",1000,triangleCallback);
    
    velocity_publisher = n.advertise<geometry_msgs::Twist>("turtle1/cmd_vel", 1000);
    ros::Rate loop_rate(100);

    ros::spin();
    return 1;
}



void move(double speed, double side_lenght, bool isForward){
   geometry_msgs::Twist vel_msg;
   //set a random linear velocity in the x-axis
   if (isForward)
       vel_msg.linear.x =abs(speed);
   else
       vel_msg.linear.x =-abs(speed);
   vel_msg.linear.y =0;
   vel_msg.linear.z =0;
   //set a random angular velocity in the y-axis
   vel_msg.angular.x = 0;
   vel_msg.angular.y = 0;
   vel_msg.angular.z =0;

   double t0 = ros::Time::now().toSec();
   double current_side_lenght = 0.0;
   ros::Rate loop_rate(100);
   do{
       velocity_publisher.publish(vel_msg);
       double t1 = ros::Time::now().toSec();
       current_side_lenght = speed * (t1-t0);
       ros::spinOnce();
       loop_rate.sleep();       
   }while(current_side_lenght<side_lenght);
   vel_msg.linear.x =0;
   velocity_publisher.publish(vel_msg);

}

void rotate (double angular_speed, double relative_angle, bool clockwise){

    geometry_msgs::Twist vel_msg;
       //set a random linear velocity in the x-axis
       vel_msg.linear.x =0;
       vel_msg.linear.y =0;
       vel_msg.linear.z =0;
       //set a random angular velocity in the y-axis
       vel_msg.angular.x = 0;
       vel_msg.angular.y = 0;
       if (clockwise)
        vel_msg.angular.z =-abs(angular_speed);
       else
        vel_msg.angular.z =abs(angular_speed);

       double t0 = ros::Time::now().toSec();
       double current_angle = 0.0;
       ros::Rate loop_rate(100);
       do{
           velocity_publisher.publish(vel_msg);
           double t1 = ros::Time::now().toSec();
           current_angle = angular_speed * (t1-t0);
           ros::spinOnce();
           loop_rate.sleep();
       }while(current_angle<relative_angle);
       vel_msg.angular.z =0;
       velocity_publisher.publish(vel_msg);
}

/**
 *  converts angles from degree to radians  
 */

double degrees2radians(double angle_in_degrees){
    return angle_in_degrees *PI /180.0;
}
