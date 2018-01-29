cfg = {}

cfg.debug = true  -- if debug is true it will print the prop name on client console and notify you

cfg.distance = 1.5

cfg.enter = "You are close to an object on which you can sit! Press ~INPUT_CONTEXT~ to sit!"
cfg.leave = "Press ~INPUT_ENTER~ to get up."

cfg.chairs = {
	--all tasks: pastebin.com/6mrYTdQv
	
	-- BENCH
	{prop = 'prop_bench_01a', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_01b', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_01c', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_03', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_04', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_05', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_06', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_05', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_08', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_09', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_10', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_bench_11', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_fib_3b_bench', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_ld_bench01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},
	{prop = 'prop_wait_bench_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.5, h = 180.0},

	-- CHAIR
	{prop = 'hei_prop_heist_off_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'hei_prop_hei_skid_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_01a', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_01b', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_03', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_04a', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_04b', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_05', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_06', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_05', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_08', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_09', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chair_10', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_chateau_chair_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_clown_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_cs_office_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_direct_chair_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_direct_chair_02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_gc_chair02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_off_chair_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_off_chair_03', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_off_chair_04', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_off_chair_04b', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_off_chair_04_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_off_chair_05', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_old_deck_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_old_wood_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_rock_chair_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_skid_chair_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_skid_chair_02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_skid_chair_03', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_sol_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_wheelchair_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_wheelchair_01_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_armchair_01_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_clb_officechair_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_dinechair_01_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_ilev_p_easychair_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_soloffchair_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_yacht_chair_01_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_club_officechair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_corp_bk_chair3', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_corp_cd_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_corp_offchair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_chair02_ped', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_hd_chair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_p_easychair', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ret_gc_chair03', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_ld_farm_chair01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_table_04_chr', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_table_05_chr', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_table_06_chr', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_leath_chr', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_table_01_chr_a', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_table_01_chr_b', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_table_02_chr', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_table_03b_chr', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_table_03_chr', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_torture_ch_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_fh_dineeamesa', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},


	{prop = 'v_ilev_fh_kitchenstool', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_tort_stool', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_fh_kitchenstool', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_fh_kitchenstool', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_fh_kitchenstool', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_fh_kitchenstool', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},

	-- SEAT
	{prop = 'hei_prop_yah_seat_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'hei_prop_yah_seat_02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'hei_prop_yah_seat_03', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_waiting_seat_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_yacht_seat_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_yacht_seat_02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_yacht_seat_03', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_hobo_seat_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},

	-- COUCH
	{prop = 'prop_rub_couch01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'miss_rub_couch_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_ld_farm_couch01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_ld_farm_couch02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_rub_couch02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_rub_couch03', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_rub_couch04', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},

	-- SOFA
	{prop = 'p_lev_sofa_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_res_sofa_l_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_v_med_p_sofa_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'p_yacht_sofa_01_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_ilev_m_sofa', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_res_tre_sofa_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_tre_sofa_mess_a_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_tre_sofa_mess_b_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'v_tre_sofa_mess_c_s', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},

	-- MISC
	{prop = 'prop_roller_car_01', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0},
	{prop = 'prop_roller_car_02', task = 'PROP_HUMAN_SEAT_BENCH', x = 0.0, y = 0.0, z = 0.0, h = -90.0}
}

return cfg