(progn
  (handler-bind
    ((simple-error #'(lambda (c) (declare (ignore c))
      (invoke-restart 'quicklisp-quickstart::load-setup))))
      (quicklisp-quickstart:install))
  (funcall (intern "QUICKLOAD" :ql) :cl-store)
  (funcall (intern "QUICKLOAD" :ql) :jsown)
  (funcall (intern "QUICKLOAD" :ql) :cl-json)
  (funcall (intern "QUICKLOAD" :ql) :usocket))
