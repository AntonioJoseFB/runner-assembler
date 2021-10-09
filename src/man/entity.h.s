.include "man/macros.h.s"

;;=======================================================
;; This is a macro that creates the entity structure and 
;; returns the size of the entity
;; Parameters:
;;      - e: entity
;;      - name of the field
;;      - size in bytes of the field
;;BeginStruct e
;;    Field e, cmps, 1
;;    Field e,    x, 1
;;    Field e,    y, 1
;;EndStruct e

;;=======================================================
;; This is a macro that adds the cmps bits
;; Parameters:
;;      - size of the paramater
;;      - Value of the parameter
;;BeginBitField8 e_cmps
;;    Bit8 e_cmps, alive
;;    Bit8 e_cmps, render
;;EndBitfield8 e_cmps

;;=======================================================
;;PUBLIC ENTITY VARIABLES
sizeof_e            = 3         ;;How much memory takes one entity
e_total_size        = 45   	    ;;Total size of the entities
max_entites         = 15        ;;How many entities can exist

;;=======================================================
;;TYPES FLAGS

;;=======================================================
;;COMPONENTS FLAGS
e_cmps_invalid  = 0x00
e_cmps_default  = 0xFF
e_cmps_alive    = 0x01
e_cmps_render   = 0x02


;;=======================================================
;;MACROS
.macro DEFINE_ENTITY_TEMPLATE _name, _type, _cmp, _pos_x, _pos_y
_name:
	.db _cmp            ; Entity's components
	.db _pos_x          ; Entity's x position
	.db _pos_y          ; Entity's y position
.endm

;;=======================================================
;;ENTITY STRUCT REFERENCES USEFUL FOR IX
e_cmps       = 0 
e_x         = 1 
e_y         = 2 

;;=======================================================
;;Functions
;; Declarations of global public functions
.globl man_entity_init
.globl man_entity_create
.globl man_entity_destroy
.globl man_entity_update_one_entity
.globl man_entity_update
.globl man_entity_forall
.globl man_entity_forall_matching
.globl man_entity_forall_matching_pairs
.globl man_entity_get_from_idx
.globl man_entity_set4destruction