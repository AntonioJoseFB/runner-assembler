;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Given a certain _increment, increment the _register
;; in _increment times
;;
;; Return: The _register incremented _increment times
;; Modifies: -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro INCREMENT_REGISTER _register, _increment

   ;;TODO: This can be more efficient, loading the content of the variable and with add DO IT RETARD
   .rept _increment
      inc _register
   .endm

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Given a certain _decrement, decrement the _register
;; in _decrement times
;;
;; Return: The _register decremented _decrement times
;; Modifies: -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.macro DECREMENT_REGISTER _register, _decrement

   ;;TODO: This can be more efficient, loading the content of the variable and with add DO IT RETARD
   .rept _decrement
      inc _register
   .endm

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Increase in _n a variable,
;; given the memory direction of the variable itself
;; 
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro INCREMENT_VARIABLE _variable_md, _n
   
   ;;TODO: This can be more efficient, loading the content of the variable and with add DO IT RETARD
   ld a, (#_variable_md)
   INCREMENT_REGISTER a, _n
   ld (_variable_md), a

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Decrement in _n a variable,
;; given the memory direction of the variable itself
;; 
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DECREMENT_VARIABLE _variable_md, _n
   
   ;;TODO: This can be more efficient, loading the content of the variable and with add DO IT RETARD
   ld a, (#_variable_md)
   DECREMENT_REGISTER a, _n
   ld (_variable_md), a

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Params:
;;  - _register: Register where we want to store the result
;; Objetive: Calculate the multiplication of _n1 * _n2
;;
;; Return: The result of the multiplication stored at the _stored_register
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro MULTIPLY _n1, _n2, _register

   ld a, #0x00

   .rept _n1
      add a, #_n2
   .endm

   ld _register, a

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Calculate the given number negated
;; Return: Return the number negated in the _register
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro NEGATE_NUMBER _n1

   ld a, #_n1
   xor #FF
   add a, #0x01

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Compare if _n1 and _n2 are equals
;;
;; Return: Z = 1 if _n1, _n2 are equals, otherwise Z = 0
;; Modifies: a, b
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.macro IS_EQUALS _n1, _n2
   
   ld a, #_n1
   ld b, #_n2

   sub b
.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Compare if _n1 >  _n2
;;
;; Return: C = 0 if _n1, > _n2, otherwise C = 1
;; Modifies: a, b
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.macro IS_HIGHER _n1, _n2
   
   ld a, #_n1
   ld b, #_n2

   cp b

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Compare if _n1 < _n2
;;
;; Return: C = 0 if _n1, < _n2, otherwise C = 1
;; Modifies: a, b
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.macro IS_LOWER _n1, _n2
   IS_HIGHER _n2, _n1
.endm
