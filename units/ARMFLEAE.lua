-- UNITDEF -- ARMFLEAE --
--------------------------------------------------------------------------------

local unitName = "ARMFLEAE"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.5,
  badTargetCategory  = "ANTIGATOR",
  bmcode             = "1",
  brakeRate          = 0.5,
  buildCostEnergy    = 322,
  buildCostMetal     = 14,
  builder            = false,
  buildPic           = "ARMFLEAE.DDS",
  buildTime          = 789,
  canAttack          = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "KBOT MOBILE WEAPON NOTAIR NOTSUB NOTSHIP LEVEL1 ALL",
  corpse             = "DEAD",
  defaultmissiontype = "Standby",
  description        = "Fast Scout Kbot",
  energyMake         = 0.40000000596046,
  energyStorage      = 0,
  energyUse          = 0.4,
  explodeAs          = "BIG_UNITEX",
  firestandorders    = "1",
  footprintX         = 3,
  footprintZ         = 3,
  highTrajectory     = 2,
  idleAutoHeal       = 5,
  idleTime           = 1800,
  maneuverleashlength = "640",
  mass               = 1000,
  maxDamage          = 4500,
  maxSlope           = 255,
  maxVelocity        = 2.00,
  maxWaterDepth      = 16,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "KBOT1",
  name               = "Fleamor",
  noAutoFire         = false,
  noChaseCategory    = "VTOL",
  objectName         = "ARMFLEAE",
  seismicSignature   = 0,
  selfDestructAs     = "BIG_UNIT",
  side               = "ARM",
  sightDistance      = 550,
  smoothAnim         = true,
  standingfireorder  = "2",
  standingmoveorder  = "1",
  steeringmode       = "2",
  TEDClass           = "KBOT",
  turnRate           = 1672,
  unitname           = "ARMFLEAE",
  workerTime         = 0,
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
      badTargetCategory  = "VTOL",
      def                = "ARM_ARTILLERY",
      onlyTargetCategory = "NOTAIR",
    },
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  ARM_ARTILLERY = {
    accuracy           = 750,
    areaOfEffect       = 140,
    ballistic          = true,
    craterBoost        = 0,
    craterMult         = 0,
    edgeEffectiveness  = 0.5,
    explosionGenerator = "custom:FLASH4",
    gravityaffected    = "true",
    impulseBoost       = 0.123,
    impulseFactor      = 0.123,
    minbarrelangle     = "-10",
    name               = "PlasmaCannon",
    noSelfDamage       = true,
    range              = 1000,
    reloadtime         = 5.5,
    renderType         = 4,
    soundHit           = "xplomed4",
    soundStart         = "cannhvy2",
    startsmoke         = "1",
    turret             = true,
    weaponType         = "Cannon",
    weaponVelocity     = 345,
    burst              = 4,
  	burstrate          = 0.60,
  	sprayangle         = 250,
  	rgbcolor           = "1 0.8 0.5",
	  stages             = 20,
  	separation         = 0.45,
  	alphadecay         = 0.3,
  	sizedecay          = "-0.15",
  	nogap              = 1,
	  size               = 1,
	  color              = 3,
--	  cegtag             = "MITLERESPLASMA",
    damage = {
      default            = 350,
      gunships           = "15",
      hgunships          = "15",
      l1bombers          = "15",
      l1fighters         = "15",
      l1subs             = "5",
      l2bombers          = "15",
      l2fighters         = "15",
      l2subs             = "5",
      l3subs             = "5",
      vradar             = "15",
      vtol               = "15",
      vtrans             = "15",
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

local featureDefs = {
  DEAD = {
    blocking           = false,
    category           = "corpses",
    damage             = 30,
    description        = "Wreckage",
    energy             = 0,
    featureDead        = "HEAP",
    featurereclamate   = "SMUDGE01",
    footprintX         = 1,
    footprintZ         = 1,
    height             = "20",
    hitdensity         = "100",
    metal              = 9,
    object             = "ARMFLEAE_DEAD",
    reclaimable        = true,
    seqnamereclamate   = "TREE1RECLAMATE",
    world              = "All Worlds",
  },
  HEAP = {
    blocking           = false,
    category           = "heaps",
    damage             = 15,
    description        = "Wreckage",
    energy             = 0,
    featurereclamate   = "SMUDGE01",
    footprintX         = 1,
    footprintZ         = 1,
    height             = "4",
    hitdensity         = "100",
    metal              = 4,
    object             = "1X1A",
    reclaimable        = true,
    seqnamereclamate   = "TREE1RECLAMATE",
    world              = "All Worlds",
  },
}
unitDef.featureDefs = featureDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
