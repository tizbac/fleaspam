-- UNITDEF -- ARMFLEAC --
--------------------------------------------------------------------------------

local unitName = "ARMFLEAC"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.5,
  badTargetCategory  = "ANTIGATOR",
  bmcode             = "1",
  brakeRate          = 0.5,
  buildCostEnergy    = 322,
  buildCostMetal     = 14,
  builder            = false,
  buildPic           = "ARMFLEAC.DDS",
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
  idleAutoHeal       = 5,
  idleTime           = 1800,
  maneuverleashlength = "640",
  mass               = 1000,
  maxDamage          = 3200,
  maxSlope           = 255,
  maxVelocity        = 2.4000000953674,
  maxWaterDepth      = 16,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "KBOT1",
  name               = "Flealas mk2",
  noAutoFire         = false,
  noChaseCategory    = "VTOL",
  objectName         = "ARMFLEAC",
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
  unitname           = "ARMFLEAC",
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
      def                = "JANUS_ROCKET",
           },
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  JANUS_ROCKET = {
    areaOfEffect       = 8,
    beamlaser          = 1,
    beamTime           = 0.15,
    coreThickness      = 0.2,
    craterBoost        = 0,
    craterMult         = 0,
    energypershot      = 75,
    explosionGenerator = "custom:GreenLaser",
    fireStarter        = 90,
    impulseBoost       = 0.123,
    impulseFactor      = 0.123,
    laserFlareSize     = 10,
    lineOfSight        = true,
    name               = "HighEnergyLaser",
    noSelfDamage       = true,
    range              = 275,
    reloadtime         = 0.8,
    renderType         = 0,
    rgbColor           = "0 1 0",
    soundHit           = "lasrhit1",
    soundStart         = "lasrhvy3",
    targetMoveError    = 0.2,
    thickness          = 3,
    tolerance          = 10000,
    turret             = true,
    weaponType         = "BeamLaser",
    weaponVelocity     = 700,
    damage = {
      default            = 275,
      gunships           = "55",
      hgunships          = "55",
      l1bombers          = "55",
      l1fighters         = "55",
      l1subs             = "5",
      l2bombers          = "55",
      l2fighters         = "55",
      l2subs             = "5",
      l3subs             = "5",
      vradar             = "55",
      vtol               = "55",
      vtrans             = "55",
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
    object             = "ARMFLEAC_DEAD",
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
