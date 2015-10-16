;;
(in-package :cl-user)

(defpackage cram-quadrotor-designators
  (:use #:common-lisp #:cram-plan-occasions-events #:cram-robot-interfaces
        #:prolog #:desig #:cram-semantic-map #:cl-transforms-stamped)
  (:import-from #:cram-transforms-stamped
                *fixed-frame* *transformer* *tf-default-timeout*)
  (:shadowing-import-from #:cram-designators object-designator object)
  (:shadowing-import-from #:cram-robot-interfaces robot side))
