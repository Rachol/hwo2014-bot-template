;; Bot template for Hello World Open https://helloworldopen.com
;;
;; Requirements: SBCL and Quicklip
;;
;; From command line: sbcl --noinform --disable-debugger --noprint --quit --load client.lisp
;;
(ql:quickload "usocket")
(ql:quickload "cl-json")

(defun message (type data)
  (pairlis '(:data :msg-type)
           (list data type)))

(defun ping-message ()
  (message "ping" "ping"))

(defun join-message (name key)
  (message "join" 
           (pairlis '("key" "name") 
                    (list key name))))

(defun throttle-message (value)
  (message "throttle" value))

(defun send-message (message stream)
  (write-line (cl-json:encode-json-to-string message) stream)
  (force-output stream))

(defun get-message (stream)
  (let ((line (read-line stream nil nil)))
    (if (and line (> (length line) 0))
        (cl-json:decode-json-from-string line))))

(defun message-type (msg)
  (intern (cl-json:camel-case-to-lisp (cdr (assoc :msg-type msg)))
          :keyword))

(defun message-data (msg)
  (cdr (assoc :data msg)))

(defun start-bot (host port name key)
  (usocket:with-client-socket (socket stream host port)    
    (send-message (join-message name key) stream)
    (do ((msg (get-message stream) (get-message stream)))
        ((null msg))
      ;; (format t "Got message: ~A~%" msg)
      (let ((reply (case (message-type msg)
                     (:car-positions (throttle-message 0.5))
                     (t (ping-message)))))
        ;; (format t "Sending reply: ~A~%" reply)
        (send-message reply stream)))))

(let ((args (cdr sb-ext:*posix-argv*)))
  (if (= (length args) 4)
      (let ((host (first args))
            (port (parse-integer (second args)))
            (name (third args))
            (key (fourth args)))
        (start-bot host port name key))
      (format t "usage: run <hostname> <port> <bot-name> <bot-key>~%")))
