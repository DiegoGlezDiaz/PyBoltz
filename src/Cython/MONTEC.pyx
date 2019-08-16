from Magboltz cimport Magboltz
from libc.math cimport sin, cos, acos, asin, log, sqrt, pow
from libc.string cimport memset
from Magboltz cimport drand48
from SORT cimport SORT
from libc.stdlib cimport malloc, free
import cython

@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
cdef double random_uniform(double dummy):
    cdef double r = drand48(dummy)
    return r

@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
cdef void GERJAN(double RDUM, double API, double *RNMX):
    cdef double RAN1, RAN2, TWOPI
    cdef int J
    for J in range(0, 5, 2):
        RAN1 = random_uniform(RDUM)
        RAN2 = random_uniform(RDUM)
        TWOPI = 2.0 * API
        RNMX[J] = sqrt(-1 * log(RAN1)) * cos(RAN2 * TWOPI)
        RNMX[J + 1] = sqrt(-1 * log(RAN1)) * sin(RAN2 * TWOPI)

@cython.cdivision(True)
@cython.boundscheck(False)
@cython.wraparound(False)
cpdef MONTEC(Magboltz Object):
    cdef long long I, ID, XID, NCOL, IEXTRA, IMBPT, K, J, J2M, J1, J2, KGAS, IE, IT, KDUM, IPT, JDUM, NCOLDM
    cdef double ST1, RDUM, ST2, SUME2, SUMXX, SUMYY, SUMZZ, SUMXZ, SUMXY, ZOLD, STOLD, ST1OLD, ST2OLD, SZZOLD, SXXOLD, SYYOLD, SYZOLD, SXYOLD, SXZOLD, SME2OLD, TDASH
    cdef double ABSFAKEI, DCZ1, DCX1, DCY1, CX1, CY1, CZ1, BP, F1, F2, F4, DCX2, DCY2, DCZ2, CX2, CY2, CZ2, DZCOM, DYCOM, DXCOM, THETA0,
    cdef double  E1, CONST9, CONST10, AP, CONST6, R2, R1, VGX, VGY, VGZ, VEX, VEY, VEZ, EOK, R5, TEST1, TEST2, TEST3, CONST11
    cdef double T2, A, B, CONST7, R3, S1, EI, R9, EXTRA, RAN, R31, F3, EPSI, R4, PHI0, F8, F9, ARG1, D, Q, F6, U, CSQD, F5, VXLAB, VYLAB, VZLAB
    cdef double TWZST, TAVE, T2WZST, T2AVE, TXXST, TYYST, TZZST, TXYST, TXZST, TYZST, T2XXST, T2YYST, T2ZZST, T2XYST, T2XZST, T2YZST, ANCATT, ANCION, E, SUMYZ, SUMLS, SUMTS
    cdef double SLNOLD, STROLD, EBAROLD, EFZ100, EFX100, EBAR, WZR, WYR, WXR, XR, ZR, YR, TWYST, TWXST, T2WYST, T2WXST,TEMP[4000]
    cdef double *STO, *XST, *YST, *ZST, *WZST, *AVEST, *DFZZST, *DFYYST, *DFXXST, *DFYZST, *DFXYST, *DFXZST, *WYZST, *WXZST
    cdef double DIFXXR, DIFYYR, DIFZZR, DIFYZR, DIFXZR, DIFXYR, ZROLD, YROLD, XROLD, SZZR, SYYR, SXXR, SXYR, SXZR, RCS, RSN, RTHETA, EOVBR

    STO = <double *> malloc(2000000 * sizeof(double))
    memset(STO, 0, 2000000 * sizeof(double))
    XST = <double *> malloc(2000000 * sizeof(double))
    memset(XST, 0, 2000000 * sizeof(double))

    YST = <double *> malloc(2000000 * sizeof(double))
    memset(YST, 0, 2000000 * sizeof(double))

    ZST = <double *> malloc(2000000 * sizeof(double))
    memset(ZST, 0, 2000000 * sizeof(double))

    WZST = <double *> malloc(10 * sizeof(double))
    memset(WZST, 0, 10 * sizeof(double))

    WYST = <double *> malloc(10 * sizeof(double))
    memset(WYST, 0, 10 * sizeof(double))

    WXST = <double *> malloc(10 * sizeof(double))
    memset(WXST, 0, 10 * sizeof(double))

    AVEST = <double *> malloc(10 * sizeof(double))
    memset(AVEST, 0, 10 * sizeof(double))

    DFZZST = <double *> malloc(10 * sizeof(double))
    memset(DFZZST, 0, 10 * sizeof(double))

    DFYYST = <double *> malloc(10 * sizeof(double))
    memset(DFYYST, 0, 10 * sizeof(double))

    DFXXST = <double *> malloc(10 * sizeof(double))
    memset(DFXXST, 0, 10 * sizeof(double))

    DFYZST = <double *> malloc(10 * sizeof(double))
    memset(DFYZST, 0, 10 * sizeof(double))

    DFXYST = <double *> malloc(10 * sizeof(double))
    memset(DFXYST, 0, 10 * sizeof(double))

    DFXZST = <double *> malloc(10 * sizeof(double))
    memset(DFXZST, 0, 10 * sizeof(double))

    TEMP = <double *> malloc(4000 * sizeof(double))
    memset(TEMP, 0, 4000 * sizeof(double))
    for J in range(4000):
        TEMP[J] = Object.TCFNNT[J] + Object.TCFNT[J]

    Object.WX = 0.0
    Object.DWX = 0.0
    Object.X = 0.0
    Object.Y = 0.0
    Object.Z = 0.0
    DIFXXR = 0.0
    DIFYYR = 0.0
    DIFZZR = 0.0
    DIFYZR = 0.0
    Object.DIFTR = 0.0
    Object.DIFLN = 0.0
    Object.DFLER = 0.0
    Object.DFTER = 0.0
    DIFXZR = 0.0
    DIFXYR = 0.0
    Object.ST = 0.0
    ST1 = 0.0
    SUMXX = 0.0
    SUMYY = 0.0
    SUMZZ = 0.0
    SUMYZ = 0.0
    SUMXY = 0.0
    SUMXZ = 0.0
    ZROLD = 0.0
    YROLD = 0.0
    XROLD = 0.0
    SZZR = 0.0
    SYYR = 0.0
    SXXR = 0.0
    SXYR = 0.0
    SYZR = 0.0
    SXZR = 0.0
    STOLD = 0.0
    ST1OLD = 0.0
    ST2OLD = 0.0
    SZZOLD = 0.0
    SYYOLD = 0.0
    SXXOLD = 0.0
    SYZOLD = 0.0
    SXYOLD = 0.0
    SXZOLD = 0.0

    EBAROLD = 0.0
    Object.SMALL = 1e-20
    Object.TMAX1 = 0.0
    Object.API = acos(-1)
    RCS = cos((Object.BTHETA - 90) * Object.API / 180)
    RSN = sin((Object.BTHETA - 90) * Object.API / 180)
    RTHETA = Object.BTHETA * Object.API / 180
    EFZ100 = Object.EFIELD * 100 * sin(RTHETA)
    EFX100 = Object.EFIELD * 100 * cos(RTHETA)
    F1 = Object.EFIELD * Object.CONST2 * cos(RTHETA)
    F4 = 2 * Object.API
    CONST9 = Object.CONST3 * 0.01
    EOVBR = Object.EOVB * sin(RTHETA)
    E1 = Object.ESTART
    Object.ITMAX = 10
    ID = 0
    NCOL = 0
    INTEM = 8
    Object.NNULL = 0
    IEXTRA = 0

    ABSFAKEI = Object.FAKEI
    Object.IFAKE = 0

    #INITIAL DIRECTION COSINES
    DCZ1 = cos(Object.THETA)
    DCX1 = sin(Object.THETA) * cos(Object.PHI)
    DCY1 = sin(Object.THETA) * sin(Object.PHI)

    # INITIAL VELOCITY
    VTOT = CONST9 * sqrt(E1)
    CX1 = DCX1 * VTOT
    CY1 = DCY1 * VTOT
    CZ1 = DCZ1 * VTOT

    DELTAE = Object.EFINAL / float(INTEM)
    J2M = <long long>(Object.NMAX / Object.ITMAX)

    for J1 in range(int(Object.ITMAX)):
        for J2 in range(int(J2M)):
            while True:
                R1 = random_uniform(RDUM)
                I = int(E1 / DELTAE) + 1
                I = min(I, INTEM) - 1
                TLIM = Object.TCFMAXNT[I]
                T = -1 * log(R1) / TLIM + TDASH
                TDASH = T
                WBT = Object.WB * T
                COSWT = cos(WBT)
                SINWT = sin(WBT)
                DZ = (CZ1 * SINWT + (EOVBR - CY1) * (1 - COSWT)) / Object.WB
                DX = CX1 * T + F1 * T * T
                E = E1 + DZ * EFZ100 + DX * EFX100
                IE = int(E / Object.ESTEP)
                IE = min(IE, 3999)
                if TEMP[IE] > TLIM:
                    TDASH += log(R1) / TLIM
                    Object.TCFMAX[I] *= 1.05
                    continue

                R5 = random_uniform(RDUM)
                TEST1 = Object.TCFNT[IE] / TLIM

                # TEST FOR REAL OR NULL COLLISION
                if R5 > TEST1:
                    Object.NNULL += 1
                    TEST2 = TEMP[IE] / TLIM
                    if R5 < TEST2:
                        if Object.NPLASTNT == 0:
                            continue
                        R2 = random_uniform(RDUM)
                        I = 0
                        while Object.CFNNT[IE][I] < R2:
                            I += 1

                        Object.ICOLNNNT[I] += 1
                        continue
                    else:
                        TEST3 = (TEMP[IE] + ABSFAKEI) / TLIM
                        if R5 < TEST3:
                            # FAKE IONISATION INCREMENT COUNTER
                            Object.IFAKE += 1
                            continue
                        continue
                else:
                    break
            T2 = T ** 2
            if (T >= Object.TMAX1):
                Object.TMAX1 = T
            TDASH = 0.0

            CX2 = CX1 + 2 * F1 * T
            CY2 = (CY1 - EOVBR) * COSWT + CZ1 * SINWT + EOVBR
            CZ2 = CZ1 * COSWT - (CY1 - EOVBR) * SINWT
            VTOT = sqrt(CX2 ** 2 + CY2 ** 2 + CZ2 ** 2)
            DCX2 = CX2 / VTOT
            DCY2 = CY2 / VTOT
            DCZ2 = CZ2 / VTOT
            NCOL += 1

            Object.X += DX
            Object.Y += EOVBR * T + ((CY1 - EOVBR) * SINWT + CZ1 * (1 - COSWT)) / Object.WB
            Object.Z += DZ
            Object.ST += T

            IT = int(T)
            IT = min(IT, 299)
            Object.TIME[IT] += 1
            Object.SPEC[IE] += 1
            Object.WZ = Object.Z / Object.ST
            Object.WY = Object.Y / Object.ST
            Object.WX = Object.X / Object.ST
            if J1 >= 2:
                KDUM = 0
                for J in range(int(Object.NCORST)):
                    NCOLDM = NCOL + KDUM
                    if NCOLDM > Object.NCOLM:
                        NCOLDM = NCOLDM - Object.NCOLM
                    ST1 += T
                    SDIF = Object.ST - STO[NCOLDM-1]
                    KDUM += Object.NCORLN
                    SUMZZ += ((Object.Z - ZST[NCOLDM-1] - Object.WZ * SDIF) ** 2) * T / SDIF
                    SUMYY += ((Object.Y - YST[NCOLDM-1] - Object.WY * SDIF) ** 2) * T / SDIF
                    SUMXX += ((Object.X - XST[NCOLDM-1] - Object.WX * SDIF) ** 2) * T / SDIF
                    SUMYZ += (Object.Z - ZST[NCOLDM-1] - Object.WZ * SDIF) * (
                            Object.Y - YST[NCOLDM-1] - Object.WY * SDIF) * T / SDIF
                    SUMXY += (Object.X - XST[NCOLDM-1] - Object.WX * SDIF) * (
                            Object.Y - YST[NCOLDM-1] - Object.WY * SDIF) * T / SDIF
                    SUMXZ += (Object.X - XST[NCOLDM-1] - Object.WX * SDIF) * (
                            Object.Z - ZST[NCOLDM-1] - Object.WZ * SDIF) * T / SDIF
            XST[NCOL-1] = Object.X
            YST[NCOL-1] = Object.Y
            ZST[NCOL-1] = Object.Z
            STO[NCOL-1] = Object.ST
            if NCOL >= Object.NCOLM:
                ID += 1
                Object.XID = float(ID)
                NCOL = 0
            R2 = random_uniform(RDUM)

            I = SORT(I, R2, IE, Object)
            while Object.CFNT[IE][I] < R2:
                I += 1

            S1 = Object.RGASNT[I]
            EI = Object.EINNT[I]
            if Object.IPNNT[I] > 0:
                R9 = random_uniform(RDUM)
                EXTRA = R9 * (E - EI)
                EI = EXTRA + EI
                IEXTRA += <long long>(Object.NC0NT[I])
            IPT = <long long>(Object.IARRYNT[I])
            Object.ICOLLNT[int(IPT)] += 1
            Object.ICOLNNT[I] += 1
            if E < EI:
                EI = E - 0.0001

            if Object.IPEN != 0:
                if Object.PENFRANT[0][I] != 0:
                    RAN = random_uniform(RDUM)
                    if RAN <= Object.PENFRANT[0][I]:
                        IEXTRA += 1
            S2 = (S1 ** 2) / (S1 - 1.0)

            R3 = random_uniform(RDUM)
            if Object.INDEXNT[I] == 1:
                R31 = random_uniform(RDUM)
                F3 = 1.0 - R3 * Object.ANGCTNT[IE][I]
                if R31 > Object.PSCTNT[IE][I]:
                    F3 = -1 * F3
            elif Object.INDEXNT[I] == 2:
                EPSI = Object.PSCTNT[IE][I]
                F3 = 1 - (2 * R3 * (1 - EPSI) / (1 + EPSI * (1 - 2 * R3)))
            else:
                F3 = 1 - 2 * R3
            THETA0 = acos(F3)
            R4 = random_uniform(RDUM)
            PHI0 = F4 * R4
            F8 = sin(PHI0)
            F9 = cos(PHI0)
            ARG1 = 1 - S1 * EI / E
            ARG1 = max(ARG1, Object.SMALL)
            D = 1 - F3 * sqrt(ARG1)
            E1 = E * (1 - EI / (S1 * E) - 2 * D / S2)
            E1 = max(E1, Object.SMALL)
            Q = sqrt((E / E1) * ARG1) / S1
            Q = min(Q, 1)
            Object.THETA = asin(Q * sin(THETA0))
            F6 = cos(Object.THETA)
            U = (S1 - 1) * (S1 - 1) / ARG1
            CSQD = F3 * F3
            if F3 < 0 and CSQD > U:
                F6 = -1 * F6
            F5 = sin(Object.THETA)
            DCZ2 = min(DCZ2, 1)
            VTOT = CONST9 * sqrt(E1)
            ARGZ = sqrt(DCX2 * DCX2 + DCY2 * DCY2)
            if ARGZ == 0:
                DCZ1 = F6
                DCX1 = F9 * F5
                DCY1 = F8 * F5
            else:
                DCZ1 = DCZ2 * F6 + ARGZ * F5 * F8
                DCY1 = DCY2 * F6 + (F5 / ARGZ) * (DCX2 * F9 - DCY2 * DCZ2 * F8)
                DCX1 = DCX2 * F6 - (F5 / ARGZ) * (DCY2 * F9 + DCX2 * DCZ2 * F8)
            CX1 = DCX1 * VTOT
            CY1 = DCY1 * VTOT
            CZ1 = DCZ1 * VTOT
        Object.WZ *= 1e9
        Object.WY *= 1e9
        Object.WX *= 1e9

        WZR = Object.WZ * RCS - Object.WX * RSN
        WYR = Object.WY
        WXR = Object.WZ * RSN + Object.WX * RCS
        ZR = Object.Z * RCS - Object.X * RSN
        YR = Object.Y
        XR = Object.Z * RSN + Object.X * RCS
        EBAR = 0.0
        for IK in range(4000):
            EBAR += Object.E[IK] * Object.SPEC[IK] / Object.TCFNT[IK]
        Object.AVE = EBAR / Object.ST
        WZST[J1] = (ZR - ZROLD) / (Object.ST - STOLD) * 1e9
        WYST[J1] = (YR - YROLD) / (Object.ST - STOLD) * 1e9
        WXST[J1] = (XR - XROLD) / (Object.ST - STOLD) * 1e9
        AVEST[J1] = (EBAR - EBAROLD) / (Object.ST - STOLD)
        EBAROLD = EBAR

        print(J1)

        if J1 >= 2:
            Object.DIFXX = 5e15 * SUMXX / ST1
            Object.DIFYY = 5e15 * SUMYY / ST1
            Object.DIFZZ = 5e15 * SUMZZ / ST1
            Object.DIFXY = 5e15 * SUMXY / ST1
            Object.DIFYZ = 5e15 * SUMYZ / ST1
            Object.DIFXZ = 5e15 * SUMXZ / ST1

            DIFXXR = Object.DIFXX * RCS * RCS + Object.DIFZZ * RSN * RSN + 2 * RCS * RSN * Object.DIFXZ
            DIFYYR = Object.DIFYY
            DIFZZR = Object.DIFXX * RSN * RSN + Object.DIFZZ * RCS * RCS - 2 * RCS * RSN * Object.DIFXZ
            DIFXYR = RCS * Object.DIFXY + RSN * Object.DIFYZ
            DIFYZR = RSN * Object.DIFXY - RCS * Object.DIFYZ
            DIFXZR = (RCS * RCS - RSN * RSN) * Object.DIFXZ - RSN * RCS * (Object.DIFXX - Object.DIFZZ)

            SXXR = SUMXX * RCS * RCS + SUMZZ * RSN * RSN + 2 * RCS * RSN * SUMXZ
            SYYR = SUMYY
            SZZR = SUMXX * RSN * RSN + SUMZZ * RCS * RCS - 2 * RCS * RSN * SUMXZ
            SXYR = RCS * SUMXY + RSN * SUMYZ
            SYZR = RSN * SUMXY - RCS * SUMYZ
            SXZR = (RCS * RCS - RSN * RSN) * SUMXZ - RSN * RCS * (SUMXX - SUMZZ)
        DFZZST[J1] = 0.0
        DFXXST[J1] = 0.0
        DFYYST[J1] = 0.0
        DFYZST[J1] = 0.0
        DFXZST[J1] = 0.0
        DFXYST[J1] = 0.0
        if J1 > 1:
            DFZZST[J1] = 5e15 * (SUMZZ - SZZOLD) / (ST1 - ST1OLD)
            DFXXST[J1] = 5e15 * (SUMXX - SXXOLD) / (ST1 - ST1OLD)
            DFYYST[J1] = 5e15 * (SUMYY - SYYOLD) / (ST1 - ST1OLD)
            DFYZST[J1] = 5e15 * (SUMYZ - SYZOLD) / (ST1 - ST1OLD)
            DFXZST[J1] = 5e15 * (SUMXZ - SXZOLD) / (ST1 - ST1OLD)
            DFXYST[J1] = 5e15 * (SUMXY - SXYOLD) / (ST1 - ST1OLD)
        ZROLD = ZR
        YROLD = YR
        XROLD = XR
        STOLD = Object.ST
        ST1OLD = ST1
        SZZOLD = SZZR
        SYYOLD = SYYR
        SXXOLD = SXXR
        SXYOLD = SXYR
        SYZOLD = SYZR
        SXZOLD = SXZR
    TWZST = 0.0
    TWYST = 0.0
    TWXST = 0.0
    TAVE = 0.0
    T2WZST = 0.0
    T2WYST = 0.0
    T2WXST = 0.0
    T2AVE = 0.0
    TZZST = 0.0
    TYYST = 0.0
    TXXST = 0.0
    TXYST = 0.0
    TXZST = 0.0
    TYZST = 0.0
    T2ZZST = 0.0
    T2YYST = 0.0
    T2XXST = 0.0
    T2XYST = 0.0
    T2XZST = 0.0
    T2YZST = 0.0

    for K in range(10):
        TWZST = TWZST + WZST[K]
        TWYST = TWYST + WYST[K]
        TWXST = TWXST + WXST[K]
        TAVE = TAVE + AVEST[K]
        T2WZST = T2WZST + WZST[K] * WZST[K]
        T2WYST = T2WYST + WYST[K] * WYST[K]
        T2WXST = T2WXST + WXST[K] * WXST[K]
        T2AVE = T2AVE + AVEST[K] * AVEST[K]
        if K >= 2:
            TZZST = TZZST + DFZZST[K]
            TYYST = TYYST + DFYYST[K]
            TXXST = TXXST + DFXXST[K]
            TYZST = TYZST + DFYZST[K]
            TXYST = TXYST + DFXYST[K]
            TXZST = TXZST + DFXZST[K]

            T2ZZST += DFZZST[K] ** 2
            T2XXST += DFXXST[K] ** 2
            T2YYST += DFYYST[K] ** 2
            T2YZST += DFYZST[K] ** 2
            T2XYST += DFXYST[K] ** 2
            T2XZST += DFXZST[K] ** 2
    Object.DWZ = 100 * sqrt((T2WZST - TWZST * TWZST / 10.0) / 9.0) / WZR
    Object.DWY = 100 * sqrt((T2WYST - TWYST * TWYST / 10.0) / 9.0) / abs(WYR)
    Object.DWX = 100 * sqrt((T2WXST - TWXST * TWXST / 10.0) / 9.0) / abs(WXR)
    Object.DEN = 100 * sqrt((T2AVE - TAVE * TAVE / 10.0) / 9.0) / Object.AVE
    Object.DZZER = 100 * sqrt((T2ZZST - TZZST * TZZST / 8.0) / 7.0) / DIFZZR
    Object.DYYER = 100 * sqrt((T2YYST - TYYST * TYYST / 8.0) / 7.0) / DIFYYR
    Object.DXXER = 100 * sqrt((T2XXST - TXXST * TXXST / 8.0) / 7.0) / DIFXXR
    Object.DXYER = 100 * sqrt((T2XYST - TXYST * TXYST / 8.0) / 7.0) / abs(DIFXYR)
    Object.DXZER = 100 * sqrt((T2XZST - TXZST * TXZST / 8.0) / 7.0) / abs(DIFXZR)
    Object.DYZER = 100 * sqrt((T2YZST - TYZST * TYZST / 8.0) / 7.0) / abs(DIFYZR)

    Object.DWZ = Object.DWZ / sqrt(10)
    Object.DWX = Object.DWX / sqrt(10)
    Object.DWY = Object.DWY / sqrt(10)
    Object.DEN = Object.DEN / sqrt(10)
    Object.DXXER = Object.DXXER / sqrt(8)
    Object.DYYER = Object.DYYER / sqrt(8)
    Object.DZZER = Object.DZZER / sqrt(8)
    Object.DYZER = Object.DYZER / sqrt(8)
    Object.DXYER = Object.DXYER / sqrt(8)
    Object.DXZER = Object.DXZER / sqrt(8)

    Object.WZ = WZR
    Object.WX = WXR
    Object.WY = WYR
    Object.DIFXX = DIFXXR
    Object.DIFYY = DIFYYR
    Object.DIFZZ = DIFZZR
    Object.DIFYZ = DIFYZR
    Object.DIFXY = DIFXYR
    Object.DIFXZ = DIFXZR

    Object.WZ *= 1e5
    Object.WY *= 1e5
    Object.WX *= 1e5


    ANCATT = 0.0
    ANCION = 0.0
    for I in range(Object.NGAS):
        ANCATT += Object.ICOLLNT[5 * (I + 1) - 3]
        ANCION += Object.ICOLLNT[5 * (I + 1) - 4]
    ANCION += IEXTRA
    Object.ATTER = 0.0
    if ANCATT != 0:
        Object.ATTER = 100 * sqrt(ANCATT) / ANCATT
    Object.ATT = ANCATT / (Object.ST * Object.WZ) * 1e12
    Object.ALPER = 0.0
    if ANCION != 0:
        Object.ALPER = 100 * sqrt(ANCION) / ANCION
    Object.ALPHA = ANCION / (Object.ST * Object.WZ) * 1e12

    return
