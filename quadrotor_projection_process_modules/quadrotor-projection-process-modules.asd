;;; Copyright (c) 2014, Fereshta Yazdani <yazdani@cs.uni-bremen.de>
;;; All rights reserved.
;; 
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are met:
;;; 
;;;     * Redistributions of source code must retain the above copyright
;;;       notice, this list of conditions and the following disclaimer.
;;;     * Redistributions in binary form must reproduce the above copyright
;;;       notice, this list of conditions and the following disclaimer in the
;;;       documentation and/or other materials provided with the distribution.
;;;     * Neither the name of the Institute for Artificial Intelligence/
;;;       Universitaet Bremen nor the names of its contributors may be used to 
;;;       endorse or promote products derived from this software without 
;;;       specific prior written permission.
;;; 
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
;;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;;; POSSIBILITY OF SUCH DAMAGE.

(defsystem projection-process-modules
  :author "Fereshta Yazdani"
  :license "BSD"
  :depends-on (alexandria
               cram-process-modules
               cram-designators
               cram-bullet-reasoning
               cram-bullet-reasoning-designators
               cram-plan-occasions-events
               cram-occasions-events
               cram-plan-library
               cram-bullet-reasoning-belief-state
               cram-projection
               cram-robot-interfaces
               cram-plan-failures
               cram-quadrotor-designators
               cram-semantic-map-utils
               cram-semantic-map
               cram-transforms-stamped)
  :components
  ((:module "src"
    :components
    ((:file "package")
     (:file "tf" :depends-on ("package"))
     (:file "process-module-definitions" :depends-on ("package"))
     (:file "perception" :depends-on ("package" "action-events"))
     (:file "ptu" :depends-on ("package" "tf" "action-events"))
     (:file "action-designators" :depends-on ("package"))
     (:file "navigation" :depends-on ("package" "action-events" "process-module-definitions"))
     (:file "projection-environment" :depends-on ("package" "tf" "action-events"))
     (:file "action-events" :depends-on ("package"))
     (:file "resources" :depends-on ("package"))))))
