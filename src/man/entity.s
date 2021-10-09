.module Entity

.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "macros/math.h.s"

.area _DATA
.area _CODE

m_entities: 		.ds e_total_size	;;Reserved memory for the entities
m_next_free_entity: .ds 2				;;Reserved memory for the pointer of the next free entity
m_num_entities: 	.db 0				;;Current number of entities

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
man_entity_forall_matching::
    ret

man_entity_forall_matching_pairs::
    ret