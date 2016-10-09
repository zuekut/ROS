
(cl:in-package :asdf)

(defsystem "assignment1-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Triangle" :depends-on ("_package_Triangle"))
    (:file "_package_Triangle" :depends-on ("_package"))
  ))