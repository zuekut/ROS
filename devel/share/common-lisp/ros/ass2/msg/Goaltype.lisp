; Auto-generated. Do not edit!


(cl:in-package ass2-msg)


;//! \htmlinclude Goaltype.msg.html

(cl:defclass <Goaltype> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0))
)

(cl:defclass Goaltype (<Goaltype>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Goaltype>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Goaltype)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ass2-msg:<Goaltype> is deprecated: use ass2-msg:Goaltype instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <Goaltype>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ass2-msg:type-val is deprecated.  Use ass2-msg:type instead.")
  (type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Goaltype>) ostream)
  "Serializes a message object of type '<Goaltype>"
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Goaltype>) istream)
  "Deserializes a message object of type '<Goaltype>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Goaltype>)))
  "Returns string type for a message object of type '<Goaltype>"
  "ass2/Goaltype")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Goaltype)))
  "Returns string type for a message object of type 'Goaltype"
  "ass2/Goaltype")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Goaltype>)))
  "Returns md5sum for a message object of type '<Goaltype>"
  "bda37decd5e3814bcc042f341d2e60a1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Goaltype)))
  "Returns md5sum for a message object of type 'Goaltype"
  "bda37decd5e3814bcc042f341d2e60a1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Goaltype>)))
  "Returns full string definition for message of type '<Goaltype>"
  (cl:format cl:nil "int32 type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Goaltype)))
  "Returns full string definition for message of type 'Goaltype"
  (cl:format cl:nil "int32 type~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Goaltype>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Goaltype>))
  "Converts a ROS message object to a list"
  (cl:list 'Goaltype
    (cl:cons ':type (type msg))
))
