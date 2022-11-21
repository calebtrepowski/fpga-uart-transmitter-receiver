/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/keil/Documents/Proyectos_Xilinx/uart/RX.vhd";
extern char *IEEE_P_2592010699;



static void work_a_1557240426_3212880686_p_0(char *t0)
{
    char t24[16];
    char t25[16];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    unsigned char t13;
    unsigned char t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    int t26;
    unsigned int t27;
    char *t28;

LAB0:    xsi_set_current_line(47, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 5456);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(48, ng0);
    t4 = (t0 + 1192U);
    t9 = *((char **)t4);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB11;

LAB12:    t4 = (t0 + 2312U);
    t12 = *((char **)t4);
    t13 = *((unsigned char *)t12);
    t14 = (t13 == (unsigned char)3);
    t8 = t14;

LAB13:    if (t8 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 2472U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB14;

LAB15:    t2 = (t0 + 2632U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB18;

LAB19:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(49, ng0);
    t4 = xsi_get_transient_memory(8U);
    memset(t4, 0, 8U);
    t15 = t4;
    memset(t15, (unsigned char)2, 8U);
    t16 = (t0 + 5552);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t4, 8U);
    xsi_driver_first_trans_fast(t16);
    goto LAB9;

LAB11:    t8 = (unsigned char)1;
    goto LAB13;

LAB14:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1352U);
    t5 = *((char **)t2);
    t6 = *((unsigned char *)t5);
    t2 = (t0 + 2152U);
    t9 = *((char **)t2);
    t21 = (7 - 7);
    t22 = (t21 * 1U);
    t23 = (0 + t22);
    t2 = (t9 + t23);
    t15 = ((IEEE_P_2592010699) + 4000);
    t16 = (t25 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = 7;
    t17 = (t16 + 4U);
    *((int *)t17) = 1;
    t17 = (t16 + 8U);
    *((int *)t17) = -1;
    t26 = (1 - 7);
    t27 = (t26 * -1);
    t27 = (t27 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t27;
    t12 = xsi_base_array_concat(t12, t24, t15, (char)99, t6, (char)97, t2, t25, (char)101);
    t27 = (1U + 7U);
    t7 = (8U != t27);
    if (t7 == 1)
        goto LAB16;

LAB17:    t17 = (t0 + 5552);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t28 = *((char **)t20);
    memcpy(t28, t12, 8U);
    xsi_driver_first_trans_fast(t17);
    goto LAB9;

LAB16:    xsi_size_not_matching(8U, t27, 0);
    goto LAB17;

LAB18:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 2152U);
    t5 = *((char **)t2);
    t2 = (t0 + 5552);
    t9 = (t2 + 56U);
    t12 = *((char **)t9);
    t15 = (t12 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t5, 8U);
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

}

static void work_a_1557240426_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(58, ng0);

LAB3:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 5616);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 8U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 5472);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1557240426_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    xsi_set_current_line(60, ng0);

LAB3:    t1 = (t0 + 5680);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1557240426_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    xsi_set_current_line(61, ng0);

LAB3:    t1 = (t0 + 5744);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1557240426_3212880686_p_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;

LAB0:    xsi_set_current_line(62, ng0);

LAB3:    t1 = (t0 + 5808);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1557240426_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1557240426_3212880686_p_0,(void *)work_a_1557240426_3212880686_p_1,(void *)work_a_1557240426_3212880686_p_2,(void *)work_a_1557240426_3212880686_p_3,(void *)work_a_1557240426_3212880686_p_4};
	xsi_register_didat("work_a_1557240426_3212880686", "isim/RX_tb_isim_beh.exe.sim/work/a_1557240426_3212880686.didat");
	xsi_register_executes(pe);
}
