;;; xact-test.el --- ERT for ledger-mode

;;; Commentary:
;;  Regression tests for ledger-xact

;;; Code:
(require 'test-helper)


(ert-deftest ledger-xact/test-001 ()
  "Regress test for Bug 952
http://bugs.ledger-cli.org/show_bug.cgi?id=952"
  :tags '(xact regress)

  (ledger-tests-with-temp-file
   "2013/05/01 foo
    Expenses:Foo                            $10.00
    Assets:Bar

2013/05/03 foo
    Expenses:Foo                            $10.00
    Assets:Bar
"
   (end-of-buffer)
   (ledger-add-transaction "2013/05/02 foo")
   (should
    (equal (buffer-string)
           "2013/05/01 foo
    Expenses:Foo                            $10.00
    Assets:Bar

2013/05/02 foo
    Expenses:Foo                              $10.00
    Assets:Bar

2013/05/03 foo
    Expenses:Foo                            $10.00
    Assets:Bar
" ))))


(provide 'xact-test)

;;; xact-test.el ends here
