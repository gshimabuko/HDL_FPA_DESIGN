/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern void execute_2(char*, char *);
extern void execute_3(char*, char *);
extern void execute_4(char*, char *);
extern void execute_5(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_31(char*, char *);
extern void execute_46(char*, char *);
extern void execute_34(char*, char *);
extern void execute_49(char*, char *);
extern void execute_40(char*, char *);
extern void execute_52(char*, char *);
extern void execute_53(char*, char *);
extern void execute_54(char*, char *);
extern void execute_45(char*, char *);
extern void execute_59(char*, char *);
extern void execute_60(char*, char *);
extern void execute_61(char*, char *);
extern void execute_62(char*, char *);
extern void execute_63(char*, char *);
extern void execute_64(char*, char *);
extern void execute_65(char*, char *);
extern void execute_66(char*, char *);
extern void execute_58(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_32(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_33(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_34(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_35(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_36(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_37(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_39(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_40(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_41(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_42(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_43(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[39] = {(funcp)execute_2, (funcp)execute_3, (funcp)execute_4, (funcp)execute_5, (funcp)execute_6, (funcp)execute_7, (funcp)execute_8, (funcp)execute_9, (funcp)execute_31, (funcp)execute_46, (funcp)execute_34, (funcp)execute_49, (funcp)execute_40, (funcp)execute_52, (funcp)execute_53, (funcp)execute_54, (funcp)execute_45, (funcp)execute_59, (funcp)execute_60, (funcp)execute_61, (funcp)execute_62, (funcp)execute_63, (funcp)execute_64, (funcp)execute_65, (funcp)execute_66, (funcp)execute_58, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_32, (funcp)transaction_33, (funcp)transaction_34, (funcp)transaction_35, (funcp)transaction_36, (funcp)transaction_37, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_39, (funcp)transaction_40, (funcp)transaction_41, (funcp)transaction_42, (funcp)transaction_43};
const int NumRelocateId= 39;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/AAC2M1H1_tb_func_impl/xsim.reloc",  (void **)funcTab, 39);
	iki_vhdl_file_variable_register(dp + 13424);
	iki_vhdl_file_variable_register(dp + 13480);
	iki_vhdl_file_variable_register(dp + 19184);
	iki_vhdl_file_variable_register(dp + 19320);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/AAC2M1H1_tb_func_impl/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/AAC2M1H1_tb_func_impl/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 18864, dp + 20088, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 18920, dp + 20200, 0, 0, 0, 0, 1, 1);

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 18976, dp + 20312, 0, 0, 0, 0, 1, 1);
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/AAC2M1H1_tb_func_impl/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/AAC2M1H1_tb_func_impl/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/AAC2M1H1_tb_func_impl/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
