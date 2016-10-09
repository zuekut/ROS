#include <sstream>
#include "../Goaltype.h"
#include "geometry_msgs/PoseStamped.h"
#include "ros/ros.h"
#include "std_msgs/String.h"

geometry_msgs::PoseStamped goalmsg;
ass2::Goaltype goaltypemsg;
int main(int argc, char **argv) {
	ros::init(argc, argv, "goal_node");

	ros::NodeHandle n;

	ros::Publisher parameters_pub =
	    n.advertise<geometry_msgs::PoseStamped>("goal", 1000);
	ros::Publisher goaltype_pub = n.advertise<ass2::Goaltype>("goaltype", 1000);

	ros::Rate loop_rate(10);

	while (ros::ok()) {
		double x;
		double y;
		double z;
		int type;
		std::cout << "Enter 1 for servoing, Enter 2 for point_shoot";
		std::cin >> type;
		if (type == 1) {
			goaltypemsg.type = type;
			goaltype_pub.publish(goaltypemsg);
		} else if (type == 2) {
			goaltypemsg.type = type;
			goaltype_pub.publish(goaltypemsg);
		}
		std::cout << "enter x coordinate: ";
		std::cin >> x;
		std::cout << "enter y coordinate: ";
		std::cin >> y;
		std::cout << "enter z coordinate: ";
		std::cin >> z;
		goalmsg.pose.position.x = x;
		goalmsg.pose.position.y = y;
		goalmsg.pose.position.z = z;
		parameters_pub.publish(goalmsg);

		ros::spinOnce();
	}

	return 0;
}
