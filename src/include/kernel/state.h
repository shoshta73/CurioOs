#ifndef __CURIO_OS_KERNEL_STATE_H__
#define __CURIO_OS_KERNEL_STATE_H__ 1

typedef enum kernel_display_mode_t
{
    KDM_VGA
} kdisplay_mode;

typedef struct
{
    kdisplay_mode display_mode;
} kernel_state_t;

extern kernel_state_t kernel_state;

void init_kernel_state(void);
void set_kernel_display_mode(kdisplay_mode mode);

#endif // __CURIO_OS_KERNEL_STATE_H__
