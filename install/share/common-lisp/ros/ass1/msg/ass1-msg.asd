
(cl:in-package :asdf)

(defsystem "ass1-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Triangles" :depends-on ("_package_Triangles"))
    (:file "_package_Triangles" :depends-on ("_package"))
    (:file "Triangles" :depends-on ("_package_Triangles"))
    (:file "_package_Triangles" :depends-on ("_package"))
  ))