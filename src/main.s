.module Main

.include "cpctelera.h.s"
.include "man/entity.h.s"
.include "sys/render.h.s"
.include "sys/physics.h.s"
.include "cpct_globals.h.s"

.area _DATA
.area _CODE

tmpl_entity:
   .db #(e_cmps_alive | e_cmps_render)
   .db 10, 20

;;==========================MAIN=================================
_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm

   call man_entity_init
   call sys_render_init

   call man_entity_create

;;==========MAIN LOOP=============
loop:
   call sys_render_update
   call sys_physics_update

   call man_entity_update

   call cpct_waitVSYNC_asm
   jr    loop