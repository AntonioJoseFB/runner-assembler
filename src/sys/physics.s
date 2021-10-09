.module Physics

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"


sys_physics_update_one_entity::
    ld a, e_pos_x(ix)
    add e_vel_x(ix)
    ld e_pos_x(ix), a

    ret

cmp_physics_signature = (e_cmps_alive | e_cmps_physics)
sys_physics_update::
    ld hl, #sys_physics_update_one_entity
    ld bc, #cmp_physics_signature
    call man_entity_forall_matching
    
    ret