-- UNITDEF -- ARMFLEAB --
--------------------------------------------------------------------------------

local unitName = "ARMFLEAA"

--------------------------------------------------------------------------------

local unitDef = {

name="Flea",
unitname="armfleaa",
buildcostenergy=322,
buildcostmetal=14,
buildtime=789,
category="ARM KBOT MOBILE SURFACE WEAPON NOTAIR NOTSUB CTRL_K CTRL_G CTRL_W NOTSHIP LEVEL1 ALL",
description="Flea",
footprintx=1,
footprintz=1,
maxdamage=250,
objectname="ARMFLEAA",
side="ARM",
soundcategory="ARMPW",
tedclass="KBOT",
brakerate=0.5,
movementclass="KBOT1",
acceleration=0.5,
canmove=1,
maxvelocity=4.4,
maxslope=255,
turnrate=1672,
builder=0,
workertime=0,
energyuse=0.4,
metalstorage=0,
canattack=1,
canstop=1,
idletime=1800,
idleautoheal=5,
sightdistance=550,

wpri_badtargetcategory="ANTIGATOR",
badtargetcategory="ANTIGATOR",
explodeas="TINY_BUILDINGEX",
selfdestructas="TINY_BUILDINGEX",
nochasecategory="VTOL",
maxwaterdepth=16,
energymake=3000,
energystorage=1000,
corpse="ARMFLEA_DEAD",
smoothanim=1,
buildpic="ARMFLEA.DDS",
mass=1000,
bmcode=1,
noautofire=0,
seismicsignature=0,
firestandorders=1,
standingfireorder=2,
defaultmissiontype="Standby",
canpatrol=1,
mobilestandorders=1,
standingmoveorder=1,
canguard=1,
steeringmode=2,
maneuverleashlength=640 ,

sounds = {
    canceldestruct     = "cancel2",
    underattack        = "warning1",
    cant = {
      "cantdo4",
    },
    count = {
      "count6",
      "count5",
      "count4",
      "count3",
      "count2",
      "count1",
    },
    ok = {
      "servtny2",
    },
    select = {
      "servtny2",
    },
  },
  weapons = {
    [1]  = {
      badTargetCategory  = "ANTIGATOR",
      def                = "FLEA_LASER",
    },
  },
}

local weaponDefs = {
    FLEA_LASER = {
        name="Laser";
        rendertype=0;
        lineofsight=1;
        turret=1;
        range=140;
        reloadtime=0.4;
        weaponvelocity=600;
        areaofeffect=8;
        burstrate=0.2;
        soundtrigger=1;
        energypershot=0;
        soundstart="lasrfir1";
        soundhit="lasrhit2";
        firestarter=50;
        beamtime=0.1;
        beamlaser=1;
        thickness=0.75;
        corethickness=0.1;
        laserflaresize=2;
        targetmoveerror=0.1;
        rgbColor="1 1 0";
        tolerance=10000;
        explosiongenerator="custom:FLASH1yellow2";
        impulsefactor=0.123;
        impulseboost=0.123;
        cratermult=0;
        craterboost=0;
        noselfdamage=1;
      damage = {
        default            = 24,
        gunships           = "32",
        hgunships          = "65",
        l1bombers          = "65",
        l1fighters         = "65",
        l1subs             = "65",
        l2bombers          = "65",
        l2fighters         = "65",
        l2subs             = "65",
        l3subs             = "65",
        vradar             = "65",
        vtol               = "1",
        vtrans             = "1",
      },
    },
  }
  unitDef.weaponDefs = weaponDefs
  


return lowerkeys({ [unitName] = unitDef })