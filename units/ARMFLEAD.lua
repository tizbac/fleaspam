-- UNITDEF -- ARMFLEAD --
--------------------------------------------------------------------------------

local unitName = "ARMFLEAD"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.5,
  badTargetCategory  = "ANTIGATOR",
  bmcode             = "1",
  brakeRate          = 0.5,
  buildCostEnergy    = 322,
  buildCostMetal     = 14,
  builder            = false,
  buildPic           = "ARMFLEAD.DDS",
  buildTime          = 789,
  canAttack          = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "KBOT MOBILE WEAPON NOTAIR NOTSUB NOTSHIP LEVEL1 ALL",
  corpse             = "DEAD",
  defaultmissiontype = "Standby",
  description        = "Heavy attack flea",
  energyMake         = 0.40000000596046,
  energyStorage      = 0,
  energyUse          = 0.4,
  explodeAs          = "BIG_UNITEX",
  firestandorders    = "1",
  footprintX         = 4,
  footprintZ         = 4,
  highTrajectory     = 2,
  idleAutoHeal       = 5,
  idleTime           = 1800,
  maneuverleashlength = "640",
  mass               = 1500,
  maxDamage          = 4500,
  maxSlope           = 255,
  maxVelocity        = 2.5,
  maxWaterDepth      = 16,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "KBOT1",
  name               = "Fleadog",
  noAutoFire         = false,
  noChaseCategory    = "VTOL",
  objectName         = "ARMFLEAD",
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
  unitname           = "ARMFLEAD",
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:MEDIUMFLARE",
    },
  },
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
      def                = "ARM_BULL",
    },
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  ARM_BULL = {
    areaOfEffect       = 140,
    ballistic          = true,
    craterBoost        = 0,
    craterMult         = 0,
    explosionGenerator = "custom:FLASH72",
    gravityaffected    = "true",
    impulseBoost       = 0.123,
    impulseFactor      = 0.123,
    name               = "PlasmaCannon",
    noSelfDamage       = true,
    range              = 460,
    reloadtime         = 1.12,
    renderType         = 4,
    soundHit           = "xplomed2",
    soundStart         = "cannon3",
    startsmoke         = "1",
    turret             = true,
    weaponType         = "Cannon",
    weaponVelocity     = 300,
    damage = {
      default            = 240,
      gunships           = "30",
      hgunships          = "30",
      l1bombers          = "30",
      l1fighters         = "30",
      l1subs             = "5",
      l2bombers          = "30",
      l2fighters         = "30",
      l2subs             = "5",
      l3subs             = "5",
      vradar             = "30",
      vtol               = "30",
      vtrans             = "30",
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
    object             = "ARMFLEAD_DEAD",
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
