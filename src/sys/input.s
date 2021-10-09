.module Input

.area _DATA
.area _CODE

.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"

move_right::
    ld e_vel_x(ix), #1
    ret

move_left::
    ld e_vel_x(ix), #-1
    ret

jump::
    ;;ld e_vel_y(ix), #-2 ;;placeholder
    ret

key_actions::
    .dw Key_D, move_right
    .dw Key_A, move_left
    .dw Key_J, jump
    .dw 0
sys_input_check_keyboard_and_update_player::
    ;;Reset player velocity
    ld e_vel_x(ix), #0
    
    call cpct_scanKeyboard_f_asm

    ;; Key-Action Check-Call loop
    ld iy, #key_actions-4
    
    loop_keys:
        ld bc, #4
        add iy, bc

        ld l, 0(iy)
        ld h, 1(iy)

        ;;Check if Key == null
        ld a, l
        or h
        ret z ;; if A = 0, Key = null, ret

        ;;Check if key is pressed
        call cpct_isKeyPressed_asm
        jr z, loop_keys

        ;;Key is pressed, execute action
        ld hl, #loop_keys
        push hl

        ld l, 2(iy)
        ld h, 3(iy)
        jp (hl)
sys_input_update::
    ;; Get Entity 0 (Player)
    ;;xor a
    ;;call man_entity_get_from_idx ;;TODO: tengo que implementar esta funcion
    ld ix, #m_entities
    
    ;;Update player using keyboard status
    call sys_input_check_keyboard_and_update_player

    ret