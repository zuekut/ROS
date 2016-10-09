; Auto-generated. Do not edit!


(cl:in-package ass1-msg)


;//! \htmlinclude Triangles.msg.html

(cl:defclass <Triangles> (roslisp-msg-protocol:ros-message)
  ((side_lenght
    :reader side_lenght
    :initarg :side_lenght
    :type cl:float
    :initform 0.0)
   (cw
    :reader cw
    :initarg :cw
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Triangles (<Triangles>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Triangles>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Triangles)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ass1-msg:<Triangles> is deprecated: use ass1-msg:Triangles instead.")))

(cl:ensure-generic-function 'side_lenght-val :lambda-list '(m))
(cl:defmethod side_lenght-val ((m <Triangles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ass1-msg:side_lenght-val is deprecated.  Use ass1-msg:side_lenght instead.")
  (side_lenght m))

(cl:ensure-generic-function 'cw-val :lambda-list '(m))
(cl:defmethod cw-val ((m <Triangles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ass1-msg:cw-val is deprecated.  Use ass1-msg:cw instead.")
  (cw m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Triangles>) ostream)
  "Serializes a message object of type '<Triangles>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'side_lenght))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'cw) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Triangles>) istream)
  "Deserializes a message object of type '<Triangles>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'side_lenght) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'cw) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Triangles>)))
  "Returns string type for a message object of type '<Triangles>"
  "ass1/Triangles")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Triangles)))
  "Returns string type for a message object of type 'Triangles"
  "ass1/Triangles")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Triangles>)))
  "Returns md5sum for a message object of type '<Triangles>"
  "26462833dbbf58d1691798b80b2a0b94")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Triangles)))
  "Returns md5sum for a message object of type 'Triangles"
  "26462833dbbf58d1691798b80b2a0b94")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Triangles>)))
  "Returns full string definition for message of type '<Triangles>"
  (cl:format cl:nil "float32 side_lenght~%bool cw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Triangles)))
  "Returns full string definition for message of type 'Triangles"
  (cl:format cl:nil "float32 side_lenght~%bool cw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Triangles>))
  (cl:+ 0
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Triangles>))
  "Converts a ROS message object to a list"
  (cl:list 'Triangles
    (cl:cons ':side_lenght (side_lenght msg))
    (cl:cons ':cw (cw msg))
))
