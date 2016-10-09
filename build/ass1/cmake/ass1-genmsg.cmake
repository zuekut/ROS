# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "ass1: 1 messages, 0 services")

set(MSG_I_FLAGS "-Iass1:/root/catkin_ws/src/ass1/msg;-Iass1:/root/catkin_ws/src/ass1/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(ass1_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/root/catkin_ws/src/ass1/msg/Triangles.msg" NAME_WE)
add_custom_target(_ass1_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ass1" "/root/catkin_ws/src/ass1/msg/Triangles.msg" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(ass1
  "/root/catkin_ws/src/ass1/msg/Triangles.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ass1
)

### Generating Services

### Generating Module File
_generate_module_cpp(ass1
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ass1
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(ass1_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(ass1_generate_messages ass1_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/root/catkin_ws/src/ass1/msg/Triangles.msg" NAME_WE)
add_dependencies(ass1_generate_messages_cpp _ass1_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ass1_gencpp)
add_dependencies(ass1_gencpp ass1_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ass1_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(ass1
  "/root/catkin_ws/src/ass1/msg/Triangles.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ass1
)

### Generating Services

### Generating Module File
_generate_module_lisp(ass1
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ass1
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(ass1_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(ass1_generate_messages ass1_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/root/catkin_ws/src/ass1/msg/Triangles.msg" NAME_WE)
add_dependencies(ass1_generate_messages_lisp _ass1_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ass1_genlisp)
add_dependencies(ass1_genlisp ass1_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ass1_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(ass1
  "/root/catkin_ws/src/ass1/msg/Triangles.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ass1
)

### Generating Services

### Generating Module File
_generate_module_py(ass1
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ass1
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(ass1_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(ass1_generate_messages ass1_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/root/catkin_ws/src/ass1/msg/Triangles.msg" NAME_WE)
add_dependencies(ass1_generate_messages_py _ass1_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ass1_genpy)
add_dependencies(ass1_genpy ass1_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ass1_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ass1)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ass1
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(ass1_generate_messages_cpp ass1_generate_messages_cpp)
add_dependencies(ass1_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ass1)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ass1
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(ass1_generate_messages_lisp ass1_generate_messages_lisp)
add_dependencies(ass1_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ass1)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ass1\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ass1
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(ass1_generate_messages_py ass1_generate_messages_py)
add_dependencies(ass1_generate_messages_py std_msgs_generate_messages_py)
