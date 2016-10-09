#include <angles/angles.h>
#include <tf/transform_datatypes.h>
#include <sstream>
#include "../Goaltype.h"
#include "geometry_msgs/PoseStamped.h"
#include "geometry_msgs/Twist.h"
#include "nav_msgs/Odometry.h"
#include "ros/ros.h"

using namespace std;
int goaltype;
ros::Publisher velocity_publisher;
ros::Subscriber pose_subscriber;
ros::Subscriber goal_subscriber;
ros::Subscriber goal_type_subscriber;
geometry_msgs::PoseStamped goal;
geometry_msgs::Twist vel_msg;
nav_msgs::Odometry position;

tf::Quaternion goal_quaternion;
void move(double speed, double distance, bool isForward);
double getDistance(double x1, double y1, double x2, double y2);
void setDesiredOrientation(double goal_yaw);  // this will rotate the turtle at
					      // an absolute angle, whatever its
					      // current angle is
void positionCallBack(
    const nav_msgs::Odometry::ConstPtr &pose_message);  // Callback fn everytime
// the turtle pose msg is
// published over the
// /turtle1/pose topic.
void goalCallBack(const geometry_msgs::PoseStamped::ConstPtr &pose_message);

void goalTypeCallback(const ass2::Goaltype::ConstPtr &goal_type);
double yaw;
double goalOrientation;

void positionCallback(const nav_msgs::Odometry::ConstPtr &pose_msg) {
	yaw = tf::getYaw(pose_msg->pose.pose.orientation);

	position.pose.pose.position.x = pose_msg->pose.pose.position.x;
	position.pose.pose.position.y = pose_msg->pose.pose.position.y;
	if (goaltype == 2) {
		ROS_INFO("Position-> x: [%f], y: [%f]",
			 pose_msg->pose.pose.position.x,
			 pose_msg->pose.pose.position.y);
		ROS_INFO("Orientation->z: [%f], w: [%f]", yaw,
			 pose_msg->pose.pose.orientation.w);
	}
}

void goalCallback(const geometry_msgs::PoseStamped::ConstPtr &pose_msg) {
	ROS_INFO("Position of goal: (%f,%f,%f)", pose_msg->pose.position.x,
		 pose_msg->pose.position.y, pose_msg->pose.position.z);
	double distance, angle;

	goal_quaternion = tf::createQuaternionFromYaw(yaw);
	if (goaltype == 2) {
		goal.pose.position.x = pose_msg->pose.position.x;
		goal.pose.position.y = pose_msg->pose.position.y;
		goal.pose.orientation.x = goal_quaternion.x();
		goal.pose.orientation.y = goal_quaternion.y();
		goal.pose.orientation.z = goal_quaternion.z();
		goal.pose.orientation.w = goal_quaternion.w();

		distance =
		    getDistance(position.pose.pose.position.x,
				position.pose.pose.position.y,
				goal.pose.position.x, goal.pose.position.y);
		ROS_INFO("distance is [%f]", distance);
		angle = atan2(goal.pose.position.y, goal.pose.position.x) -
			atan2(position.pose.pose.position.y,
			      position.pose.pose.position.x);
		angles::normalize_angle(angle);
		ROS_INFO("angle is [%f]", angle);

		double orientation = angles::normalize_angle(angle - yaw);
		ROS_INFO("orientation is [%f]", orientation);
		setDesiredOrientation(orientation);
		move(0.1, distance, true);
		ROS_INFO("rotation is [%f]",
			 angles::normalize_angle(orientation - yaw));

		ros::spin();
	}

	ROS_INFO("Orientation of goal: (%f,%f,%f,%f)", goal.pose.orientation.x,
		 goal.pose.orientation.y, goal.pose.orientation.z,
		 goal.pose.orientation.w);
}
void goalTypeCallback(const ass2::Goaltype::ConstPtr &goaltype_message) {
	goaltype = goaltype_message->type;
}

int main(int argc, char **argv) {
	ros::init(argc, argv, "pointshoot_node");
	ros::NodeHandle n;

	velocity_publisher = n.advertise<geometry_msgs::Twist>("cmd_vel", 1000);
	pose_subscriber = n.subscribe("odom", 1000, positionCallback);
	goal_subscriber = n.subscribe("goal", 100, goalCallback);
	goal_type_subscriber = n.subscribe("goaltype", 100, goalTypeCallback);
	ROS_INFO("\n\n\n ********START TESTING*********\n");
	ros::spin();

	return 0;
}

double getDistance(double x1, double y1, double x2, double y2) {
	return sqrt(pow((x2 - x1), 2) + pow((y2 - y1), 2));
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

void setDesiredOrientation(double goal_yaw) {
	double desiredAngle = angles::normalize_angle(goal_yaw - yaw);
	// if we want to turn at a particular orientation, we subtract the
	// current orientation from it
	bool clockwise = ((desiredAngle < 0) ? true : false);
	rotate(0.5, abs(desiredAngle), clockwise);
}

void move(double speed, double distance, bool isForward) {
	geometry_msgs::Twist vel_msg;
	// set a random linear velocity in the x-axis
	if (isForward)
		vel_msg.linear.x = abs(speed);
	else
		vel_msg.linear.x = -abs(speed);
	vel_msg.linear.y = 0;
	vel_msg.linear.z = 0;
	// set a random angular velocity in the y-axis
	vel_msg.angular.x = 0;
	vel_msg.angular.y = 0;
	vel_msg.angular.z = 0;

	double t0 = ros::Time::now().toSec();
	double current_distance = 0.0;
	ros::Rate loop_rate(1000);
	do {
		velocity_publisher.publish(vel_msg);
		double t1 = ros::Time::now().toSec();
		current_distance = speed * (t1 - t0);
		ros::spinOnce();
		loop_rate.sleep();
	} while (current_distance < distance);
	vel_msg.linear.x = 0;
	velocity_publisher.publish(vel_msg);
}
