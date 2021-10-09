.module Entity

.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "macros/math.h.s"

.area _DATA
.area _CODE

m_entities: 		        .ds e_total_size	;;Reserved memory for the entities
m_zero_type_at_the_end:     .db #0x00           ;;Trick for stop the loop of entities, positioned
m_next_free_entity:         .ds 2				;;Reserved memory for the pointer of the next free entity
m_num_entities: 	        .db 0				;;Current number of entities
m_function_given_forall:    .ds 2               ;; Pointer to the given function for forall functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ENTITY_INIT 
;;Pre requirements
;;  -
;; Objetive: Initialize the entities establishing their values to 0
;; Also m_next_free_entity points to the first free entity to write
;;
;; Modifies: A, BC, DE, IX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_entity_init::
    ld de, #m_entities
    ld a, #0x00 
    ld bc, #e_total_size

    call cpct_memset_asm
    
    ;;Next free entity should point towards m_entities
    ld ix, #m_entities
    ld (#m_next_free_entity), ix
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;ENTITY_CREATE
;; Pre requirements
;;  -
;; Objetive: Increase m_num_entities and increase m_next_free_entity
;; to point towards the next free entity
;;
;; Modifies: a, de
;;
;; Returns: In de, returns the direction of the entity created
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_entity_create::
    ld de, (#m_next_free_entity)

    INCREMENT_VARIABLE m_num_entities, 1

    INCREMENT_VARIABLE m_next_free_entity, sizeof_e
    ret

man_entity_destroy::
    ret

man_entity_set4destruction::
    ret

man_entity_get_from_idx::
    ret

man_entity_update_one_entity::
    ret
man_entity_update::
    ret

man_entity_forall::
    ret

;;=======================================================
;; man_entity_forall_matching
;;  Objective
;;  Pre requirements
;;  - hl: should contain the memory direction for the given function to be called
;;  - bc: contains a signature that needs to be true to call the function in de
;; Modifies:
;;      - A, BC, HL, IX 
man_entity_forall_matching::
    ld ix, #m_entities
    ;;Keeping the function adress in a variable to use it.
    ld (m_function_given_forall), hl
        repeat_man_entity_forall_matching:

        ;;Compare against type to know if we should continue looping
        ;;IS_ENTITY_VALID (ix) ;;No me compila el macro --> dice que no encuentra el simbolo
        ld a, #e_cmps_invalid
        cp (ix)
        jr z, entity_no_valid_matching

        ;if ((e->type & signature) == signature)
            ;;call function given
        ;; TODO: hacer esto en macro
        ld a, (ix)      
        and c           ;;a contains now the result of entity->type & signature
        sub c           ;;entity->type - signature = 0, entity matching
        jr nz, entity_no_matching_signature

        push bc         ;;we keep the signature

        ;;Call the funcion given registered in m_function_given_forall
		ld hl, #position_after_function_given_matching
		push hl

        ld hl, (#m_function_given_forall)
		jp (hl)

        position_after_function_given_matching:
        pop bc

        entity_no_matching_signature:
        
        INCREMENT_REGISTER ix, sizeof_e

    jr repeat_man_entity_forall_matching
    entity_no_valid_matching:
    ret

man_entity_forall_matching_pairs::
    ret