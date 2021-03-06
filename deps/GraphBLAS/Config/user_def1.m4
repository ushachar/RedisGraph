//------------------------------------------------------------------------------
// SuiteSparse/GraphBLAS/Config/user_def1.m4: define user-defined objects
//------------------------------------------------------------------------------

m4_define(`GxB_Type_define', `
    #define GB_DEF_$1_type $2
    struct GB_Type_opaque GB_opaque_$1 =
    {
        GB_MAGIC,           // object is defined
        sizeof ($2),        // size of the type
        GB_UCT_code,        // user-defined at compile-time
        "$2"
    } ;
    GrB_Type $1 = & GB_opaque_$1')

m4_define(`GxB_UnaryOp_define', `
    #define GB_DEF_$1_function $2
    #define GB_DEF_$1_ztype GB_DEF_$3_type
    #define GB_DEF_$1_xtype GB_DEF_$4_type
    extern void $2
    (
        GB_DEF_$1_ztype *z,
        const GB_DEF_$1_xtype *x
    ) ;
    struct GB_UnaryOp_opaque GB_opaque_$1 =
    {
        GB_MAGIC,           // object is defined
        & GB_opaque_$4,     // type of x
        & GB_opaque_$3,     // type of z
        $2,                 // pointer to the C function
        "$2",
        GB_USER_C_opcode    // user-defined at compile-time
    } ;
    GrB_UnaryOp $1 = & GB_opaque_$1')

m4_define(`GxB_BinaryOp_define', `
    #define GB_DEF_$1_function $2
    #define GB_DEF_$1_ztype GB_DEF_$3_type
    #define GB_DEF_$1_xtype GB_DEF_$4_type
    #define GB_DEF_$1_ytype GB_DEF_$5_type
    extern void $2
    (
        GB_DEF_$1_ztype *z,
        const GB_DEF_$1_xtype *x,
        const GB_DEF_$1_ytype *y
    ) ;
    struct GB_BinaryOp_opaque GB_opaque_$1 =
    {
        GB_MAGIC,           // object is defined
        & GB_opaque_$4,     // type of x
        & GB_opaque_$5,     // type of y
        & GB_opaque_$3,     // type of z
        $2,                 // pointer to the C function
        "$2",
        GB_USER_C_opcode    // user-defined at compile-time
    } ;
    GrB_BinaryOp $1 = & GB_opaque_$1')

m4_define(`GxB_Monoid_define', `
    #define GB_DEF_$1_add GB_DEF_$2_function
    #define GB_DEF_$1_zsize sizeof (GB_DEF_$2_ztype)
    GB_DEF_$2_ztype GB_DEF_$1_identity = $3 ;
    struct GB_Monoid_opaque GB_opaque_$1 =
    {
        GB_MAGIC,           // object is defined
        & GB_opaque_$2,     // binary operator
        & GB_DEF_$1_identity,   // identity value
        GB_DEF_$1_zsize,    // identity size
        GB_USER_COMPILED,   // user-defined at compile-time
        NULL                // no terminal value
    } ;
    GrB_Monoid $1 = & GB_opaque_$1')

m4_define(`GxB_Monoid_terminal_define', `
    #define GB_DEF_$1_add GB_DEF_$2_function
    #define GB_DEF_$1_zsize sizeof (GB_DEF_$2_ztype)
    #define GB_DEF_$1_is_user_terminal
    GB_DEF_$2_ztype GB_DEF_$1_identity = $3 ;
    GB_DEF_$2_ztype GB_DEF_$1_user_terminal = $4 ;
    struct GB_Monoid_opaque GB_opaque_$1 =
    {
        GB_MAGIC,                   // object is defined
        & GB_opaque_$2,             // binary operator
        & GB_DEF_$1_identity,       // identity value
        GB_DEF_$1_zsize,            // identity and terminal size
        GB_USER_COMPILED,           // user-defined at compile-time
        & GB_DEF_$1_user_terminal   // terminal value
    } ;
    GrB_Monoid $1 = & GB_opaque_$1')

m4_define(`GB_semirings', `if (0)
    {
        ;
    }')

m4_define(`GB_semiring', `m4_define(`GB_semirings', GB_semirings()
    else if (GB_s == $1)
    {
        if (GB_AxB_method == GxB_AxB_GUSTAVSON)
        {
            if (GB_flipxy)
            {
                GB_info = GB_AxB_user_gus_$1_flipxy
                    (*GB_Chandle, GB_M, GB_A, false, GB_B, false, GB_C_Sauna) ;
            }
            else
            {
                GB_info = GB_AxB_user_gus_$1
                    (*GB_Chandle, GB_M, GB_A, false, GB_B, false, GB_C_Sauna) ;
            }
        }
        else if (GB_AxB_method == GxB_AxB_DOT)
        {

            if (GB_Aslice == NULL)
            {
                if (GB_flipxy)
                {
                    GB_info = GB_AxB_user_dot3_$1_flipxy
                        (*GB_Chandle, GB_M, GB_A, false, GB_B, false,
                            GB_TaskList, GB_ntasks, GB_dot_nthreads) ;
                }
                else
                {
                    GB_info = GB_AxB_user_dot3_$1
                        (*GB_Chandle, GB_M, GB_A, false, GB_B, false,
                            GB_TaskList, GB_ntasks, GB_dot_nthreads) ;
                }
            }
            else
            {
                if (GB_flipxy)
                {
                    GB_info = GB_AxB_user_dot2_$1_flipxy
                        (*GB_Chandle, GB_M,
                        GB_Aslice, false, GB_B, false, GB_B_slice,
                        GB_C_counts, GB_dot_nthreads, GB_naslice, GB_nbslice) ;
                }
                else
                {
                    GB_info = GB_AxB_user_dot2_$1
                        (*GB_Chandle, GB_M,
                        GB_Aslice, false, GB_B, false, GB_B_slice,
                        GB_C_counts, GB_dot_nthreads, GB_naslice, GB_nbslice) ;
                }
            }
        }
        else // (GB_AxB_method == GxB_AxB_HEAP)
        {
            if (GB_flipxy)
            {
                GB_info = GB_AxB_user_heap_$1_flipxy
                    (GB_Chandle, GB_M, GB_A, false, GB_B, false,
                    GB_List, GB_pA_pair, GB_Heap, GB_bjnz_max) ;
            }
            else
            {
                GB_info = GB_AxB_user_heap_$1
                    (GB_Chandle, GB_M, GB_A, false, GB_B, false,
                    GB_List, GB_pA_pair, GB_Heap, GB_bjnz_max) ;
            }
        }
    } ) $2')

m4_define(`GxB_Semiring_define', `GB_semiring($1,`
    #undef GBCOMPACT
    #define GB_ADD(z,y)    GB_DEF_$2_add (&(z), &(z), &(y))
    #define GB_MULTIPLY_ADD(c,a,b)  \
    {                               \
        GB_ctype t ;                \
        GB_MULTIPLY(t,a,b) ;        \
        GB_ADD(c,t) ;               \
    }
    #define GB_identity    GB_DEF_$2_identity
    #define GB_dot_simd    ;
    #if defined ( GB_DEF_$2_is_user_terminal )
        #define GB_terminal if (memcmp (&cij, &GB_DEF_$2_user_terminal, GB_DEF_$2_zsize) == 0) break ;
    #elif defined ( GB_DEF_$2_terminal )
        #define GB_terminal if (cij == GB_DEF_$2_terminal) break ;
    #else
        #define GB_terminal ;
    #endif
    #define GB_ctype    GB_DEF_$3_ztype
    #define GB_geta(a,Ax,p) GB_atype a = Ax [p]
    #define GB_getb(b,Bx,p) GB_btype b = Bx [p]
    #define GB_AgusB    GB_AxB_user_gus_$1
    #define GB_Adot2B   GB_AxB_user_dot2_$1
    #define GB_Adot3B   GB_AxB_user_dot3_$1
    #define GB_AheapB   GB_AxB_user_heap_$1
    #define GB_MULTIPLY(z,x,y) GB_DEF_$3_function (&(z), &(x), &(y))
    #define GB_atype    GB_DEF_$3_xtype
    #define GB_btype    GB_DEF_$3_ytype
    #include "GB_AxB.h"
    #include "GB_AxB.c"
    #undef GB_atype
    #undef GB_btype
    #undef GB_MULTIPLY
    #undef GB_AgusB
    #undef GB_Adot2B
    #undef GB_Adot3B
    #undef GB_AheapB
    #define GB_AgusB    GB_AxB_user_gus_$1_flipxy
    #define GB_Adot2B   GB_AxB_user_dot2_$1_flipxy
    #define GB_Adot3B   GB_AxB_user_dot3_$1_flipxy
    #define GB_AheapB   GB_AxB_user_heap_$1_flipxy
    #define GB_MULTIPLY(z,x,y) GB_DEF_$3_function (&(z), &(y), &(x))
    #define GB_atype    GB_DEF_$3_ytype
    #define GB_btype    GB_DEF_$3_xtype
    #include "GB_AxB.h"
    #include "GB_AxB.c"
    #undef GB_atype
    #undef GB_btype
    #undef GB_MULTIPLY
    #undef GB_AgusB
    #undef GB_Adot2B
    #undef GB_Adot3B
    #undef GB_AheapB
    #undef GB_ADD
    #undef GB_identity
    #undef GB_dot_simd
    #undef GB_terminal
    #undef GB_ctype
    #undef GB_geta
    #undef GB_getb
    struct GB_Semiring_opaque GB_opaque_$1 =
    {
        GB_MAGIC,           // object is defined
        & GB_opaque_$2,     // add monoid
        & GB_opaque_$3,     // multiply operator
        GB_USER_COMPILED    // user-defined at compile-time
    } ;
    GrB_Semiring $1 = & GB_opaque_$1')')

m4_define(`GxB_SelectOp_define', `
    #define GB_DEF_$1_function $2
    extern bool $2
    (
        GrB_Index i,
        GrB_Index j,
        GrB_Index nrows,
        GrB_Index ncols,
        const m4_ifelse(`$3', `NULL', `void', `GB_DEF_$3_type') *x,
        const m4_ifelse(`$4', `NULL', `void', `GB_DEF_$4_type') *thunk
    ) ;
    struct GB_SelectOp_opaque GB_opaque_$1 =
    {
        GB_MAGIC,            // object is defined
        m4_ifelse(`$3', `NULL',
            `NULL,  // x not used',
            `& GB_opaque_$3, // type of x')
        m4_ifelse(`$4', `NULL',
            `NULL,  // thunk not used',
            `& GB_opaque_$4, // type of thunk')
        $2,                  // pointer to the C function
        "$2",
        GB_USER_SELECT_C_opcode // user-defined at compile-time
    } ;
    GxB_SelectOp $1 = & GB_opaque_$1')
