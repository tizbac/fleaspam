-- UNITDEF -- ARMFLEAB --
--------------------------------------------------------------------------------

local unitName = "ARMFLEAB"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.5,
  badTargetCategory  = "ANTIGATOR",
  bmcode             = "1",
  brakeRate          = 0.5,
  buildCostEnergy    = 322,
  buildCostMetal     = 14,
  builder            = false,
  buildPic           = "ARMFLEAB.DDS",
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
  explodeAs          = "TINY_BUILDINGEX",
  firestandorders    = "1",
  footprintX         = 1,
  footprintZ         = 1,
  idleAutoHeal       = 5,
  idleTime           = 1800,
  maneuverleashlength = "640",
  mass               = 1000,
  maxDamage          = 650,
  maxSlope           = 255,
  maxVelocity        = 3.0,
  maxWaterDepth      = 16,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "KBOT1",
  name               = "Fleaser",
  noAutoFire         = false,
  noChaseCategory    = "VTOL",
  objectName         = "ARMFLEAB",
  seismicSignature   = 0,
  selfDestructAs     = "TINY_BUILDINGEX",
  side               = "ARM",
  sightDistance      = 550,
  smoothAnim         = true,
  standingfireorder  = "2",
  standingmoveorder  = "1",
  steeringmode       = "2",
  TEDClass           = "KBOT",
  turnRate           = 1672,
  unitname           = "ARMFLEAB",
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
      badTargetCategory  = "ANTIGATOR",
      def                = "FLEA_LASER",
    },
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  FLEA_LASER = {
areaOfEffect       = 12,
    beamlaser          = 1,
    beamTime           = 0.12,
    coreThickness      = 0.175,
    craterBoost        = 0,
    craterMult         = 0,
    energypershot      = 20,
    explosionGenerator = "custom:FLASH1red",
    fireStarter        = 30,
    impulseBoost       = 0.123,
    impulseFactor      = 0.123,
    laserFlareSize     = 10,
    lineOfSight        = true,
    name               = "LightLaser",
    noSelfDamage       = true,
    range              = 430,
    reloadtime         = 0.48,
    renderType         = 0,
    rgbColor           = "1 0 0",
    soundHit           = "lasrhit2",
    soundStart         = "lasrfir3",
    soundTrigger       = true,
    targetMoveError    = 0.1,
    thickness          = 2.5,
    tolerance          = 10000,
    turret             = true,
    weaponType         = "BeamLaser",
    weaponVelocity     = 2250,
    damage = {
      default            = 140,
      gunships           = "32",
      hgunships          = "32",
      l1bombers          = "32",
      l1fighters         = "32",
      l1subs             = "31",
      l2bombers          = "32",
      l2fighters         = "32",
      l2subs             = "31",
      l3subs             = "31",
      vradar             = "32",
      vtol               = "32",
      vtrans             = "32",
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
    object             = "ARMFLEAB_DEAD",
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
