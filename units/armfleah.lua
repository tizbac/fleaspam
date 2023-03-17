-- UNITDEF -- armfleah --
--------------------------------------------------------------------------------

local unitName = "armfleah"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.0296,
  badTargetCategory  = "ALL",
  bmcode             = "1",
  brakeRate          = 0.0165,
  buildCostEnergy    = 11254,
  buildCostMetal     = 523,
  builder            = false,
  buildPic           = "armfleah.pcx",
  buildTime          = 18523,
  canAttack          = true,
  cantbetransported  = true, 
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "KBOT MOBILE WEAPON NOTAIR NOTSUB NOTSHIP LEVEL1 ALL",
  corpse             = "DEAD",
  defaultmissiontype = "Standby",
  description        = "Adv Missile flea",
  energyMake         = 0.6,
  energyStorage      = 0,
  energyUse          = 0.6,
  explodeAs          = "TANK_BLAST",
  firestandorders    = "1",
  footprintX         = 3,
  footprintZ         = 3,
  idleAutoHeal       = 5,
  idleTime           = 1800,
  icontype           = "tankl3",
  leaveTracks        = true,
  maneuverleashlength = "640",
  maxDamage          = 3065,
  maxSlope           = 16,
  maxVelocity        = 3.25,
  maxWaterDepth      = 12,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "kbot1",
  name               = "armfleah",
  noAutoFire         = false,
  noChaseCategory    = "VTOL",
  objectName         = "armfleah",
  seismicSignature   = 0,
  selfDestructAs     = "CRAWL_BLAST",
  side               = "Core",
  sightDistance      = 520,
  smoothAnim         = true,
  standingfireorder  = "2",
  standingmoveorder  = "1",
  steeringmode       = "1",
  TEDClass           = "TANK",
  turnRate           = 497,
  unitname           = "armfleah",
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:rocketflare",
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
      "varmmove",
    },
    select = {
      "varmsel",
    },
  },
  weapons = {
    [1]  = {
      def                = "ARMTRUCK_MISSILE",
    },
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  ARMTRUCK_MISSILE = {
    areaOfEffect       = 75,
    burst              = 6,
    burstrate          = 0.25,
    craterBoost        = 0,
    craterMult         = 0,
    explosionGenerator = "custom:FLASH2",
    fireStarter        = 70,
    guidance           = true,
    impulseBoost       = 0.123,
    impulseFactor      = 0.123,
    lineOfSight        = true,
    metalpershot       = 0,
    model              = "missile",
    name               = "Missiles",
    noSelfDamage       = true,
    range              = 790,
    reloadtime         = 3.34,
    renderType         = 1,
    selfprop           = true,
    smokedelay         = "0.1",
    smokeTrail         = true,
    soundHit           = "xplomed2",
    soundStart         = "rockhvy2",
    soundTrigger       = true,
    startsmoke         = "1",
    startVelocity      = 450,
    toAirWeapon        = false,
    tolerance          = 8000,
    tracks             = true,
    turnRate           = 40000,
    turret             = true,
    weaponAcceleration = 108,
    weaponTimer        = 5,
    weaponType         = "MissileLauncher",
    weaponVelocity     = 540,
    damage = {
      default            = 90,
      gunships           = "310",
      hgunships          = "310",
      l1bombers          = "462",
      l1fighters         = "462",
      l1subs             = "5",
      l2bombers          = "462",
      l2fighters         = "462",
      l2subs             = "5",
      l3subs             = "5",
      vradar             = "462",
      vtol               = "462",
      vtrans             = "462",
    },
  },
}
unitDef.weaponDefs = weaponDefs


--------------------------------------------------------------------------------

local featureDefs = {
  DEAD = {
    blocking           = true,
    category           = "corpses",
    damage             = 639,
    description        = "Wreckage",
    energy             = 0,
    featureDead        = "HEAP",
    featurereclamate   = "SMUDGE01",
    footprintX         = 3,
    footprintZ         = 3,
    height             = "20",
    hitdensity         = "100",
    metal              = 123,
    object             = "armfleah_DEAD",
    reclaimable        = true,
    seqnamereclamate   = "TREE1RECLAMATE",
    world              = "All Worlds",
  },
  HEAP = {
    blocking           = false,
    category           = "heaps",
    damage             = 320,
    description        = "Wreckage",
    energy             = 0,
    featurereclamate   = "SMUDGE01",
    footprintX         = 3,
    footprintZ         = 3,
    height             = "4",
    hitdensity         = "100",
    metal              = 49,
    object             = "3X3D",
    reclaimable        = true,
    seqnamereclamate   = "TREE1RECLAMATE",
    world              = "All Worlds",
  },
}
unitDef.featureDefs = featureDefs


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
