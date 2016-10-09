
(cl:in-package :asdf)

(defsystem "ass2-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Goaltype" :depends-on ("_package_Goaltype"))
    (:file "_package_Goaltype" :depends-on ("_package"))
  ))