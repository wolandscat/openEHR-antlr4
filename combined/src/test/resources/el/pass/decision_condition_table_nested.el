Result :=
    choice in
        ================================================================================
        not metastatic:     choice in
                                ========================================================================
                                molecular_subtype matches
                                    {#luminal_B_HER2_negative, #triple_negative}
                                and
                                (tnm_t matches {"1b", "1c"} or tnm_n > 0):     #taxanes,
                                ------------------------------------------------------------------------
                                molecular_subtype = #luminal_A and
                                (tnm_t ≥ 3 or tnm_n ≥ 2 or tnm_g ≥ 3):         #anthracyclines,
                                ------------------------------------------------------------------------
                                molecular_subtype = #luminal_B_HER2_positive and
                                (tnm_t matches {"1b", "1c"} and tnm_n = 0)
                                or
                                molecular_subtype = #HER2_positive and
                                (tnm_t = "1b" and tnm_n = 0):                  #paditaxel_trastuzumab
                                ========================================================================
                            ,
        --------------------------------------------------------------------------------
        *:                  choice in
                                =====================
                                yyy:        aaa,
                                ---------------------
                                xxx:        bbb,
                                ---------------------
                                *:          ccc
                                =====================
        =================================================================================
    ;