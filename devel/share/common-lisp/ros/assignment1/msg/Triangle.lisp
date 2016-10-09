; Auto-generated. Do not edit!


(cl:in-package assignment1-msg)


;//! \htmlinclude Triangle.msg.html

(cl:defclass <Triangle> (roslisp-msg-protocol:ros-message)
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

(cl:defclass Triangle (<Triangle>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Triangle>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Triangle)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name assignment1-msg:<Triangle> is deprecated: use assignment1-msg:Triangle instead.")))

(cl:ensure-generic-function 'side_lenght-val :lambda-list '(m))
(cl:defmethod side_lenght-val ((m <Triangle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader assignment1-msg:side_lenght-val is deprecated.  Use assignment1-msg:side_lenght instead.")
  (side_lenght m))

(cl:ensure-generic-function 'cw-val :lambda-list '(m))
(cl:defmethod cw-val ((m <Triangle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader assignment1-msg:cw-val is deprecated.  Use assignment1-msg:cw instead.")
  (cw m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Triangle>) ostream)
  "Serializes a message object of type '<Triangle>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'side_lenght))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'cw) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Triangle>) istream)
  "Deserializes a message object of type '<Triangle>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'side_lenght) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'cw) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Triangle>)))
  "Returns string type for a message object of type '<Triangle>"
  "assignment1/Triangle")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Triangle)))
  "Returns string type for a message object of type 'Triangle"
  "assignment1/Triangle")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Triangle>)))
  "Returns md5sum for a message object of type '<Triangle>"
  "26462833dbbf58d1691798b80b2a0b94")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Triangle)))
  "Returns md5sum for a message object of type 'Triangle"
  "26462833dbbf58d1691798b80b2a0b94")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Triangle>)))
  "Returns full string definition for message of type '<Triangle>"
  (cl:format cl:nil "float32 side_lenght~%bool cw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Triangle)))
  "Returns full string definition for message of type 'Triangle"
  (cl:format cl:nil "float32 side_lenght~%bool cw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Triangle>))
  (cl:+ 0
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Triangle>))
  "Converts a ROS message object to a list"
  (cl:list 'Triangle
    (cl:cons ':side_lenght (side_lenght msg))
    (cl:cons ':cw (cw msg))
))
