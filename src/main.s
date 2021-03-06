.module Main

.include "cpctelera.h.s"
.include "man/entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "sys/input.h.s"
.include "cpct_globals.h.s"

.area _DATA
.area _CODE

tmpl_entity_crimson:
   .db #(e_cmps_alive | e_cmps_render | e_cmps_physics)
   .db 10, 148, 0, 0, 4, 32
   .dw #_spr_crimson_00
   .dw #0xC000

tmpl_entity_arrow:
   .db #(e_cmps_alive | e_cmps_render | e_cmps_physics)
   .db 76, 148, -2, 0, 4, 3
   .dw #_spr_arrow_0
   .dw #0xC000

;;==========================MAIN=================================
_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   call man_entity_init
   call sys_render_init

   call man_entity_create
   ld hl, #tmpl_entity_crimson
   ld bc, #sizeof_e
   ldir

   call man_entity_create
   ld hl, #tmpl_entity_arrow
   ld bc, #sizeof_e
   ldir

   call sys_render_level_start

;;==========MAIN LOOP=============
loop:
   cpctm_setBorder_asm HW_RED
   call sys_render_update
   cpctm_setBorder_asm HW_GREEN
   call sys_input_update
   cpctm_setBorder_asm HW_YELLOW
   call sys_physics_update
   cpctm_setBorder_asm HW_WHITE

   call man_entity_update

   call cpct_waitVSYNC_asm
   jr    loop