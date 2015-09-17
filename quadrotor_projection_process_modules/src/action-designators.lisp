;;; Copyright (c) 2011, Lorenz Moesenlechner <moesenle@in.tum.de>
;;; All rights reserved.
;;; 
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are met:
;;; 
;;;     * Redistributions of source code must retain the above copyright
;;;       notice, this list of conditions and the following disclaimer.
;;;     * Redistributions in binary form must reproduce the above copyright
;;;       notice, this list of conditions and the following disclaimer in the
;;;       documentation and/or other materials provided with the distribution.
;;;     * Neither the name of the Intelligent Autonomous Systems Group/
;;;       Technische Universitaet Muenchen nor the names of its contributors 
;;;       may be used to endorse or promote products derived from this software 
;;;       without specific prior written permission.
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

(in-package :projection-designators)

(defmethod resolve-designator ((designator action-designator) (role (eql 'projection-role)))
  (cut:lazy-mapcan (lambda (bindings)
                     (cut:with-vars-bound (?solution) bindings
                       (unless (cut:is-var ?solution)
                         (list ?solution))))
                   (prolog:prolog `(action-desig-projection ,designator ?solution))))

(def-fact-group process-modules (matching-process-module available-process-module projection-running)
 (<- (matching-process-module ?designator projection-ptu)
    (trajectory-desig? ?designator)
    (or (desig-prop ?designator (:to :see))
        (desig-prop ?designator (:to :follow))))

  (<- (matching-process-module ?designator projection-perception)
    (desig-prop ?designator (:to :perceive)))
 (<- (matching-process-module ?designator projection-navigation)
    (desig-prop ?designator (:type :navigation)))

  (<- (available-process-module projection-ptu)
    (symbol-value *projection-environment* pr2-bullet-projection-environment))

  (<- (available-process-module projection-perception)
    (symbol-value *projection-environment* pr2-bullet-projection-environment))
 (<- (available-process-module projection-navigation)
    (symbol-value *projection-environment* pr2-bullet-projection-environment))

  (<- (cram-process-modules:projection-running projection-ptu)
    (available-process-module projection-ptu))

  (<- (cram-process-modules:projection-running projection-perception)
    (available-process-module projection-perception))
(<- (cram-process-modules:projection-running projection-navigation)
    (available-process-module projection-navigation)))


(def-fact-group ptu-designators (action-desig-projection)

  (<- (action-desig-projection ?desig ?pose)
    (or 
     (desig-prop ?desig (:to :see))
     (desig-prop ?desig (:to :follow)))
    (desig-prop ?desig (:pose ?pose)))

  (<- (action-desig-projection ?desig ?pose)
    (or
     (desig-prop ?desig (:to :see))
     (desig-prop ?desig (:to :follow)))
    (desig-location-prop ?desig ?pose)))

(def-fact-group perception-designators (action-desig-projection)

  (<- (action-desig-projection ?designator ?object-designator)
    (desig-prop ?designator (:to :perceive))
    (or (desig-prop ?designator (:obj ?object-designator))
        (desig-prop ?designator (:object ?object-designator)))))

(def-fact-group navigation-designators (action-desig-projection)
  (<- (action-desig-projection ?desig ?goal-location)
    (desig-prop ?desig (:type :navigation))
    (desig-prop ?desig (:goal ?goal-location))))
