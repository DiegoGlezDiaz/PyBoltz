cimport numpy as np
import math
from libc.stdlib cimport malloc, free
from libc.string cimport memset
from Gasmix cimport Gasmix

cdef double drand48(double dummy)

cdef class PyBoltz:
    cdef public:
        double EFieldOverBField
        '''This is a constant that is equal to the electric field / magentic field * 1e-9.'''
        double AngularSpeedOfRotation
        '''This is the angular speed of rotation see cycltron frequency.'''
        double BFieldAngle
        '''This is the angle between the magnetic field and the electric field.'''
        double BFieldMag
        '''This is the magnitude of the magentic field.'''
        double FinalElectronEnergy
        '''This is the upper limit for the electron energy integration.'''
        double ElectronEnergyStep
        '''PyBoltz does the electron energy integration in 4000 steps this variable has the difference in energy between each step.'''
        double ThermalEnergy
        '''This indicates the amount of energy in the gas (it is equal to the Boltzman constant * absolute tempreture).'''
        double RhydbergConst
        '''This is Rydberg constant times hc in eV.'''
        double TemperatureCentigrade
        '''This is the tempreture in degrees Centigrade.'''
        double PressureTorr
        '''This is the pressure in Torr.'''
        double MaxCollisionTime
        '''Maximum collision time. Default is set to 100.'''
        double SmallNumber
        '''This constant is equal to 1e-20. Used to be a small constant.'''
        double InitialElectronEnergy
        '''The lower limit of the electron energy integration.'''
        double AngleFromZ
        '''Collision scattering angle from the Z plane.'''
        double AngleFromX
        '''Angle used to calculate initial direction cosines in the XY plane. Angle from the X axis.'''
        double EField
        '''Electric field [V/cm].'''
        double MaxNumberOfCollisions
        '''Number of the simulated collisions * N.'''
        double IonisationRate
        '''Ionisation rate.'''
        double VelocityX
        '''Drift velocity on the x axis.'''
        double VelocityY
        '''Drift velocity on the y axis.'''
        double VelocityZ
        '''Drift velocity on the z axis.'''
        double VelocityErrorX
        '''Percentage error on the x drift velocity.'''
        double VelocityErrorY
        '''Percentage error on the y drift velocity.'''
        double VelocityErrorZ
        '''Percentage error on the z drift velocity.'''
        double AttachmentRate
        '''Attachment Rate.'''
        double IonisationRateError
        '''Percentage Error for IonisationRate'''
        double AttachmentRateError
        '''Percentage Error for AttachmentRate'''
        double LongitudinalDiffusion
        '''Longitudinal diffusion.'''
        double TransverseDiffusion
        '''Transverse diffusion.'''
        double DiffusionX
        '''Diffusion on the x plane.'''
        double DiffusionY
        '''Diffusion on the y plane.'''
        double DiffusionZ
        '''Diffusion on the z plane.'''
        double DiffusionYZ
        '''Diffusion on the yz plane.'''
        double DiffusionXY
        '''Diffusion on the xy plane.'''
        double DiffusionXZ
        '''Diffusion on the xz plane.'''
        double ErrorDiffusionX
        '''Percentage error for DIFXX.'''
        double ErrorDiffusionY
        '''Percentage error for DIFYY.'''
        double ErrorDiffusionZ
        '''Percentage error for DIFZZ.'''
        double ErrorDiffusionYZ
        '''Percentage error for DIFYZ.'''
        double ErrorDiffusionXY
        '''Percentage error for DIFXY.'''
        double ErrorDiffusionXZ
        '''Percentage error for DIFXZ.'''
        double MaximumCollisionTime
        '''This variable is used to store the maximum collision time in the simulation.'''
        double MeanElectronEnergyError
        '''Percentage error for AVE.'''
        double MeanElectronEnergy
        '''Mean electron energy.'''
        double X
        '''Variable used to represent the x position in the simulation.'''
        double Y
        '''Variable used to represent the y position in the simulation.'''
        double Z
        '''Variable used to represent the z position in the simulation.'''
        double LongitudinalDiffusionError
        '''Percentage for DIFLN.'''
        double TransverseDiffusionError
        '''Percentage for DIFTR.'''
        double TemperatureKelvin
        '''Absolute tempreture in Kelvin.'''
        double ReducedIonization
        '''Variable used to represent the ionisation rate.'''
        double ReducedAttachment
        '''Variable used to represent the attachement rate.'''
        double CONST1
        '''Constant that is equal to (electron mass charge ratio) / 2 * 1e-9.'''
        double CONST2
        '''Constant that is equal to CONST1 * 1e-2.'''
        double CONST3
        '''Constant that is equal to sqrt(0.2 * (electron mass charge ratio)) * 1e-9.'''
        double MaxCollisionFreqTotal
        '''Sum of the maximum collision frequency of each gas.'''
        double EnableThermalMotion
        '''Variable used to indicate wethier to include thermal motion or not.'''
        double PresTempCor
        '''Variable used to calculate the correlation constant between the pressure and tempreture. PresTempCor=ABZERO*Pressure/(ATMOS*(ABZERO+TemperatureC)*100.0D0).'''
        double AN
        '''Variable that is equal to 100 * PresTempCor * ALOSCH. Which is the number of molecules/cm^3.'''
        double VAN
        '''Variable that is equal to 100 * PresTempCor * CONST4 * 1e15'''
        double TimeSum
        '''Variable used to calculate the sum of the collision times in the simulation.'''
        long long RandomSeed
        '''Random number generator seed. Not used at the moment.'''
        long long NumberOfGases
        '''Number of gases in the mixture.'''
        long long EnergySteps
        '''Steps for the electron energy integration.'''
        long long WhichAngularModel
        '''Variable used to indicate the type of the elastic angular distribtions.'''
        long long EnablePenning
        '''Variable used to indicate the inclusion of penning effects. '''
        long long AnisotropicDetected
        '''Anisotropic flag used if anisotropic scattering data is detected.'''
        long long Decor_Colls
        '''Number of collisions for decorrelation - (Decorrelation length).'''
        long long Decor_Step
        '''Decorrelation steps.'''
        long long Decor_LookBacks
        '''Number of decorrelation lookbacks.'''
        long long WhichRandom
        '''Choose random number (0==Magboltz), (1==Python), (2==Python+seed from clock)'''
        long long NcollSuppressionInElimits
        '''Suppresion factor in Elims calculation (default Magboltz-inherited) is 10'''
        long long NumSamples
        '''Number of electron samples'''
        long long FakeIonizations
        '''Fake ionisation counter.'''
        double NESST[9]
        double CollisionEnergies[4000]
        '''Number of collisions in the Ith energy step.'''
        double CollisionTimes[300]
        '''Number of collisions in the Ith time step.'''
        double CollisionsPerGasPerType[6][5]
        '''Number of collisions for Ith gas at the Jth type.'''
        double ICOLNN[6][10]
        '''Null scatter sum for the Ith gas and the Jth location.'''
        double ICOLN[6][290]
        double AMGAS[6]
        double VTMB[6]
        '''Maxwell Boltzman velocity factor for each gas component.'''
        double MaxCollisionFreqTotalG[6]
        '''Fraction of the maximum collision frequency of each gas over the sum of the maximum collision frequencies of all the gases.'''
        double GasIDs[6]
        '''Array used to store the number of the 6 gases in the mixture.'''
        double GasFractions[6]
        '''Array used to store the percentage of each gas in the mixture.'''
        double MoleculesPerCm3PerGas[6]
        '''Array used to calculate the number of molecules/cm^3 for each gas.'''
        double VMoleculesPerCm3PerGas[6]
        '''Array used to calculate the VAN for each gas.'''
        double CrossSectionSum[4000], ElasticCrossSection[4000], AttachmentSectionSum[4000]
        double E[4000]
        '''Energy ar each energy step.'''
        double SqrtEnergy[4000]
        '''The square root of each energy step.'''
        double TotalCrossSection[4000], RelativeIonMinusAttachCrossSection[4000], InelasticCrossSection[4000], FakeIonizationsT[8], FakeIonizationsD[9], LAST[6]
        double N_Inelastic[6]
        '''Number of momentum cross section data points for types other than attachment and ionisation.'''
        double NumMomCrossSectionPoints[6]
        '''Number of momentum cross section data points for each gas.'''
        double ISIZE[6]
        double MaxCollisionFreq[6]
        '''Maximum value of collision frequency for each gas.'''
        double NumMomCrossSectionPointsNull[6]
        '''Number of momentum cross section data points for null collisions.'''
        double AngularModel[6][290], NC0[6][290], EnergyLevels[6][290], InteractionType[6][290], RGas[6][290], ElectronNumChange[6][290],  IonizationCrossSection[6][4000], InelasticCrossSectionPerGas[6][250][4000], LIN[6][250], ALIN[6][250]
        double CollisionFrequency[6][4000][290]
        '''Collision frequency for each gas at every energy step for every data point.'''
        double TotalCollisionFrequency[6][4000]
        '''Total collision frequency for each gas at every energy step.'''
        double PenningFraction[6][3][290]
        '''PenningFraction of each gas'''
        double NullCollisionFreq[6][4000][10]
        '''Null collision frequency for each gas at every energy step for every data point.'''
        double TotalCollisionFrequencyNull[6][4000]
        '''Total null collision frequency for each gas at every energy step.'''
        double ScaleNull[6][10], ScatteringParameter[6][4000][290], AngleCut[6][4000][290]
        double TransverseDiffusion1
        '''Transverse diffusion in microns/cm^0.5.'''
        double TransverseDiffusion1Error
        '''Percentage error for DT1'''
        double LongitudinalDiffusion1
        '''Longitudinal diffusion in microns/cm^0.5'''
        double LongitudinalDiffusion1Error
        '''Percentage error for DL1'''
        double NumMomCrossSectionPointsNT,ISIZENT
        double PIR2
        int ConsoleOutputFlag
        '''Flag used to stop console printouts'''
        double MeanCollisionTime
        '''Mean collision time. Calculated using a moving average filter where it is equal to 0.9 * MeanCollisionTime + 0.1 * NewTime'''
        # Variables and arrays used when the thermal motion is not included.
        double CollisionFrequencyNT[4000][960]
        '''Collision frequency for each energy step, at each cross section point. This is used for when EnableThermalMotion = 0'''
        double EnergyLevelsNT[960]
        double TotalCollisionFrequencyNT[4000]
        '''Total collision frequency at each energy step. This is used for when EnableThermalMotion = 0'''
        double InteractionTypeNT[960],RGasNT[960],ElectronNumChangeNT[960],PenningFractionNT[3][960],MaxCollisionFreqNT[8]
        double NullCollisionFreqNT[4000][60],TotalCollisionFrequencyNullNT[4000],ScaleNullNT[60],ScatteringParameterNT[4000][960],AngleCutNT[4000][960],AngularModelNT[960],NC0NT[960],EC0NT[960]
        double CollisionsPerGasPerTypeNT[30],ICOLNNT[960]
        double ICOLNNNT[60]
        '''Null scatter sum for each gas at each sample. This is used for when EnableThermalMotion = 0'''
        double NumMomCrossSectionPointsNullNT
        '''Used to store the number of cross section points for null cross section points. This is used for when EnableThermalMotion = 0'''
        double RandomMaxBoltzArray[9]
        '''Stores randomly drawn max boltz numbers'''
        char BFieldMode
        '''Which integration mode to use'''
        Gasmix MixObject
