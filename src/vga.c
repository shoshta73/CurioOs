#include <system.h>

unsigned short *textmemptr;
int attrib = 0x0F;
int csr_x = 0, csr_y = 0;

void scroll()
{
    unsigned blank, temp;
    blank = 0x20 | (attrib << 8);
    if (csr_y >= 25)
    {
        temp = csr_y - 25 + 1;
        memcpy((unsigned char *)textmemptr, (unsigned char *)(textmemptr + temp * 80), (25 - temp) * 80 * 2);
        memsetw(textmemptr + (25 - temp) * 80, blank, 80);
        csr_y = 25 - 1;
    }
}

void move_csr()
{
    unsigned temp;
    temp = csr_y * 80 + csr_x;

    outportb(0x3D4, 14);
    outportb(0x3D5, temp >> 8);
    outportb(0x3D4, 15);
    outportb(0x3D5, temp);
}

void cls()
{
    unsigned blank;
    int i;
    blank = 0x20 | (attrib << 8);
    for (i = 0; i < 25; ++i)
    {
        memsetw(textmemptr + i * 80, blank, 80);
    }
    csr_x = 0;
    csr_y = 0;
    move_csr();
}

void putch(char c)
{
    unsigned short *where;
    unsigned att = attrib << 8;
    if (c == 0x08)
    {
        if (csr_x != 0)
            csr_x--;
    }
    else if (c == 0x09)
    {
        csr_x = (csr_x + 8) & ~(8 - 1);
    }
    else if (c == '\r')
    {
        csr_x = 0;
    }
    else if (c == '\n')
    {
        csr_x = 0;
        csr_y++;
    }
    else if (c >= ' ')
    {
        where = textmemptr + (csr_y * 80 + csr_x);
        *where = c | att;
        csr_x++;
    }
    if (csr_x >= 80)
    {
        csr_x = 0;
        csr_y++;
    }
    scroll();
    move_csr();
}

void puts(char *text)
{
    int i;
    int len = strlen(text);
    for (i = 0; i < len; ++i)
    {
        putch(text[i]);
    }
}

void settextcolor(unsigned char forecolor, unsigned char backcolor)
{
    attrib = (backcolor << 4) | (forecolor & 0x0F);
}

void init_video()
{
    textmemptr = (unsigned short *)0xB8000;
    cls();
}
