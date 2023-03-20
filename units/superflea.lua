local unitName = "superflea"


local unitDef = {
    name="Super Flea";
	unitname="superflea";
	buildcostenergy=32200000;
	buildcostmetal=1400000000;
	buildtime=7890000000;
	category="ARM KBOT SURFACE MOBILE WEAPON NOTAIR NOTSUB CTRL_K CTRL_G CTRL_W NOTSHIP LEVEL2 ALL";
	description="Fast Scout Kbot";
	footprintx=8;
	footprintz=8;
	maxdamage=20000000;
	objectname="SUPERFLEA";
	side="ARM";
	soundcategory="ARMPW";
	tedclass="KBOT";
	brakerate=0.5;
	movementclass="SUPERFLEA";
	acceleration=0.5;
	canmove=1;
	maxvelocity=3.4;
	maxslope=255;
	turnrate=1672;
	builder=0;
	workertime=0;
	energymake=0.4;
	energystorage=0;
	energyuse=0.4;
	metalstorage=0;
	canattack=1;
	canstop=1;
	idletime=1800;
	idleautoheal=500;
	sightdistance=2000;
    weapons = {
        [1]  = {
            def                = "SUPERFLEA_LASER",
        },
        [2]  = {
            def                = "KROGCRUSH",
        },
        [3]  = {
            def                = "SUPERFLEA_LASER2",
        },
    },
	wpri_badtargetcategory="ANTIGATOR";
	badtargetcategory="ANTIGATOR";
	explodeas="TINY_BUILDINGEX";
	selfdestructas="TINY_BUILDINGEX";
	nochasecategory="VTOL";
	corpse="ARMFLEA_DEAD";
	smoothanim=1;
	buildpic="ARMFLEA.DDS";
	mass=200000;
	bmcode=1;
	noautofire=0;
	seismicsignature=0;
	firestandorders=1;
	maxwaterdepth=400;
	immunetoparalyzer=1;
	standingfireorder=2;
	defaultmissiontype="Standby";
	canpatrol=1;
	mobilestandorders=1;
	standingmoveorder=1;
	canguard=1;
	capturespeed=9000000;
	amphibious=1;
	steeringmode=2;
	maneuverleashlength=640;
}


local weaponDefs = { 
SUPERFLEA_LASER2 =
    {
        name="SuperFlealaser2";
        cratermult=0.25;
        craterboost=0.25;
        noselfdamage=1;
        beamweapon=1;
        duration                = 0.25;
        energypershot           = 0;
        ballistic=0;
        explosiongenerator="custom:FLASH1yellow2";
        fireStarter             = 30;
        areaofeffect=1000;
        impulseBoost            = 0;
        impulseFactor           = 0.4;
        interceptedByShieldType = 1;
        lineOfSight             = 1;
        lodDistance             = 10000;
        noSelfDamage            = 1;
        range                   = 500;
        reloadtime              = 5.0;
        rgbColor                = "0 0 1";
        soundHit                = "xplonuk1";
        soundStart              = "hlas";
        soundTrigger            = 1;
        sweepfire               = 0;
        targetMoveError         = 0.1;
        beamtime=5;
        beamlaser=1;
        
        thickness               = 3;
        tolerance               = 10000;
        turret                  = 1;
        weaponVelocity          = 400;
    damage = {

		default=30000;
		KROGOTH=20000;
		COMMANDERS=50000;
		ORCONE=20000;
		SEADRAGON=28000;
		BLACKHYDRA=28000;
		MECHS=40000;
		VULCBUZZ=3000;
		L1SUBS=5000;
		L2SUBS=5000;
		L3SUBS=500;
		FLAKBOATS=2800;
		JAMMERBOATS=2800;
		OTHERBOATS=2800;
    }
},

SUPERFLEA_LASER = {
    name="SuperFlealaser";
	cratermult=0.25;
	craterboost=0.25;
	noselfdamage=1;
	beamweapon=1;
	duration                = 0.25;
      energypershot           = 0;
      ballistic=1;
      explosiongenerator="custom:FLASHBIGBUILDING";
      fireStarter             = 30;
      areaofeffect=1000;
      impulseBoost            = 0;
      impulseFactor           = 0.4;
      interceptedByShieldType = 1;
      lineOfSight             = 1;
      lodDistance             = 10000;
      noSelfDamage            = 1;
      range                   = 5000;
      reloadtime              = 0.5;
      renderType              = 4;
      rgbColor                = "2 0 2";
      soundHit                = "xplonuk1";
      soundStart              = "hlas";
      soundTrigger            = 1;
      sweepfire               = 0;
      targetMoveError         = 0.1;
      
      thickness               = 8;
      tolerance               = 10000;
      turret                  = 1;
      weaponVelocity          = 2000;
	damage = 
	{
		default=300;
		KROGOTH=200;
		COMMANDERS=50000;
		ORCONE=2000;
		SEADRAGON=2800;
		BLACKHYDRA=2800;
		MECHS=400;
		VULCBUZZ=3000;
		L1SUBS=50;
		L2SUBS=50;
		L3SUBS=50;
		FLAKBOATS=280;
		JAMMERBOATS=280;
		OTHERBOATS=280;
	}
}
}

unitDef.weaponDefs = weaponDefs

return lowerkeys({ [unitName] = unitDef })