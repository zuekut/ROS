#include <sstream>
#include "../Goaltype.h"
#include "geometry_msgs/PoseStamped.h"
#include "geometry_msgs/Twist.h"
#include "nav_msgs/Odometry.h"
#include "ros/ros.h"

#include <tf/transform_datatypes.h>
using namespace std;

ros::Publisher velocity_publisher;
ros::Subscriber pose_subscriber;  // to determine the position for turning the
				  // robot in an absolute orientation --> in the
				  // setDesiredOrientation fn

ros::Subscriber goal_subscriber;
ros::Subscriber goal_type_subscriber;
geometry_msgs::PoseStamped goal;
nav_msgs::Odometry position;
tf::Quaternion goal_quaternion;
int goaltype;

double yaw;
void positionCallBack(
    const nav_msgs::Odometry::ConstPtr &pose_message);  // Callback fn everytime
// the turtle pose msg is
// published over the
// /turtle1/pose topic.
void goalCallBack(const geometry_msgs::PoseStamped::ConstPtr &pose_message);
void goalTypeCallback(const ass2::Goaltype::ConstPtr &goal_type);
void moveGoal(geometry_msgs::PoseStamped goal, double distance_tolerance);
double getDistance(double x1, double y1, double x2, double y2);
int main(int argc, char **argv) {
	ros::init(argc, argv, "servoing_node");
	ros::NodeHandle n;
	velocity_publisher = n.advertise<geometry_msgs::Twist>("cmd_vel", 1000);
	pose_subscriber = n.subscribe(
	    "odom", 100, positionCallBack);  // call poseCallback everytime
					     // the turtle pose msg is
					     // published over the
					     // odometry topic

	goal_type_subscriber = n.subscribe("goaltype", 100, goalTypeCallback);
	goal_subscriber = n.subscribe("goal", 100, goalCallBack);
	ROS_INFO("\n\n\n ********START TESTING*********\n");
	ros::spin();
	return 0;
}

void rotate(double angular_speed, double relative_angle, bool clockwise) {
	geometry_msgs::Twist vel_msg;
	// set a random linear velocity in the x-axis
	vel_msg.linear.x = 0;
	vel_msg.linear.y = 0;
	vel_msg.linear.z = 0;
	// set a random angular velocity in the y-axis
	vel_msg.angular.x = 0;
	vel_msg.angular.y = 0;
	if (clockwise)
		vel_msg.angular.z = -abs(angular_speed);
	else
		vel_msg.angular.z = abs(angular_speed);
	double t0 = ros::Time::now().toSec();
	double current_angle = 0.0;
	ros::Rate loop_rate(1000);
	do {
		velocity_publisher.publish(vel_msg);
		double t1 = ros::Time::now().toSec();
		current_angle = angular_speed * (t1 - t0);
		ros::spinOnce();
		loop_rate.sleep();
	} while (current_angle < relative_angle);
	vel_msg.angular.z = 0;
	velocity_publisher.publish(vel_msg);
}

/**
 * * callback function to update the pose of the robot
 * */
void positionCallBack(const nav_msgs::Odometry::ConstPtr &pose_message) {
	if (goaltype == 1) {
		ROS_INFO("Position of robot: (%f,%f)",
			 pose_message->pose.pose.position.x,
			 pose_message->pose.pose.position.y);
		ROS_INFO("Orientation of robot: (%f,%f)",
			 pose_message->pose.pose.orientation.z,
			 pose_message->pose.pose.orientation.w);
	}
	yaw = tf::getYaw(pose_message->pose.pose.orientation);
	position.pose.pose.position.x = pose_message->pose.pose.position.x;
	position.pose.pose.position.y = pose_message->pose.pose.position.y;
	position.pose.pose.orientation.z =
	    pose_message->pose.pose.orientation.z;
}

void moveGoal(geometry_msgs::PoseStamped goal, double distance_tolerance) {
	geometry_msgs::Twist vel_msg;
	ros::Rate loop_rate(100);
	do {
		// linear and angular difference

		vel_msg.linear.x =
		    0.65 * getDistance(position.pose.pose.position.x,
				       position.pose.pose.position.y,
				       goal.pose.position.x,
				       goal.pose.position.y);
		vel_msg.linear.y = 0;
		vel_msg.linear.z = 0;

		vel_msg.angular.x = 0;
		vel_msg.angular.y = 0;
		vel_msg.angular.z =
		    4 *
		    (atan2(
			 goal.pose.position.y - position.pose.pose.position.y,
			 goal.pose.position.x - position.pose.pose.position.x) -
		     position.pose.pose.orientation.z);
		velocity_publisher.publish(vel_msg);
		ros::spinOnce();
		loop_rate.sleep();
	} while (getDistance(position.pose.pose.position.x,
			     position.pose.pose.position.y,
			     goal.pose.position.x,
			     goal.pose.position.y) > distance_tolerance);
	vel_msg.linear.x = 0;
	vel_msg.angular.z = 0;

	velocity_publisher.publish(vel_msg);
}
// Linear distance is obtained, by doing the square root of the difference
// between the x and y coordinates of the goal and the position
double getDistance(double x1, double y1, double x2, double y2) {
	return sqrt(pow((x2 - x1), 2) + pow((y2 - y1), 2));
}
void goalTypeCallback(const ass2::Goaltype::ConstPtr &goaltype_message) {
	goaltype = goaltype_message->type;
}
void goalCallBack(const geometry_msgs::PoseStamped::ConstPtr &pose_message) {
	ROS_INFO("Position of goal: (%f,%f,%f)", pose_message->pose.position.x,
		 pose_message->pose.position.y, pose_message->pose.position.z);

	goal_quaternion = tf::createQuaternionFromYaw(yaw);
	if (goaltype == 1) {
		goal.pose.position.x = pose_message->pose.position.x;
		goal.pose.position.y = pose_message->pose.position.y;
		goal.pose.orientation.x = goal_quaternion.x();
		goal.pose.orientation.y = goal_quaternion.y();
		goal.pose.orientation.z = goal_quaternion.z();
		goal.pose.orientation.w = goal_quaternion.w();
		ROS_INFO("Orientation of goal: (%f,%f,%f)",
			 pose_message->pose.position.x,
			 pose_message->pose.position.y,
			 pose_message->pose.position.z);

		moveGoal(goal, 0.01);
		ros::spinOnce();
	}
}
