.module Render

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "sys/render.h.s"

;;=======================================================
;;              PUBLIC FUNCTIONS
;;=======================================================

;;=======================================================
;;              PRIVATE FUNCTIONS
;;=======================================================

;;=======================================================
;; RENDER_INIT
;;  Initializes the render system
;; Modifies:
;;      - AF, BC, DE, HL
sys_render_init::
    ld c, #0
    call cpct_setVideoMode_asm

    ;;cpctm_setBoreder_asm HW_WHITE ;;Esto ha dicho que es una macro o algo asi --> Actualizar luego si eso

    ld hl, #_g_palette
    ld de, #16
    call cpct_setPalette_asm

    ret

;;=======================================================
;; RENDER_ONE_ENTITY
;;  Renders one entity
;;  Input:
;;      - IX: Pointer to the entity having render component
;; Modifies:
;;      - AB, BC, DE, HL 
sys_render_one_entity::
    ;,Obtain the x, y coordinates to draw the sprite
    ld de, #0xC000
    ld b, e_pos_y(ix)
    ld c, e_pos_x(ix)
    call cpct_getScreenPtr_asm
    ex de, hl   ; DE = Ptr videomem(X,Y)

    ld hl, #_spr_crimson_00
    ld b, e_h(ix)   ;; 32 lines
    ld c, e_w(ix)    ;; 4 bytes
    call cpct_drawSprite_asm 

    ret

;;=======================================================
;; RENDER_UPDATE
;;  Updates the render system
;; Modifies:
;;  - AF, BC, DE, HL, IX
render_cmps = (e_cmps_alive | e_cmps_render)
sys_render_update::

    ld hl, #sys_render_one_entity
    ld bc, #render_cmps
    call man_entity_forall_matching
    ret