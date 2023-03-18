-- UNITDEF -- ARMFLEAF --
--------------------------------------------------------------------------------

local unitName = "ARMFLEAF"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 0.5,
  badTargetCategory  = "ANTIGATOR",
  bmcode             = "1",
  brakeRate          = 0.5,
  buildCostEnergy    = 322,
  buildCostMetal     = 14,
  builder            = false,
  buildPic           = "ARMFLEAF.DDS",
  buildTime          = 789,
  canAttack          = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "ARM KBOT MOBILE SURFACE WEAPON NOTAIR NOTSUB CTRL_K CTRL_G CTRL_W NOTSHIP LEVEL1 ALL",
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
  maxDamage          = 3000,
  maxSlope           = 255,
  maxVelocity        = 2.4000000953674,
  maxWaterDepth      = 16,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "KBOT1",
  name               = "Flea",
  noAutoFire         = false,
  noChaseCategory    = "VTOL",
  objectName         = "ARMFLEAF",
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
  unitname           = "ARMFLEAF",
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
      def                = "JANUS_ROCKET",
      onlyTargetCategory = "NOTAIR",
    },
    [2]  = {
      def                = "JANUS_ROCKET",
      onlyTargetCategory = "NOTAIR",
      slaveTo            = 1,
    },
  },
}


--------------------------------------------------------------------------------

local weaponDefs = {
  JANUS_ROCKET = {
    areaOfEffect = 330,
		canattackground = true,
		craterBoost = 0,
		craterMult = 0,
		edgeEffectiveness = 0,
		explosionGenerator = [[custom:FLASHSMALLBUILDINGEX]],
		fireStarter = 90,
		flightTime = 3,
		impulseBoost = 0,
		impulseFactor = 0,
		model = [[ADVSAM]],
		name = [[upg ADVSAM]],
		noSelfDamage = true,
		proximityPriority = -1.5,
		range = 2800,
		reloadtime = 9,
		smokeTrail = true,
		soundHit = [[impact]],
		soundStart = [[launch]],
		startVelocity = 800,
		texture2 = [[coresmoketrail]],
		tolerance = 10000,
		tracks = true,
		trajectoryHeight = 0.55,
		turnRate = 139000,
		turret = true,
		weaponAcceleration = 300,
		weaponTimer = 8,
		weaponType = [[MissileLauncher]],
		weaponVelocity = 1800,
		damage = {
			bombers = 1550,
			default = 5,
			fighters = 1550,
			flak_resistant = 1550,
			unclassed_air = 1550,
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
    object             = "ARMFLEAF_DEAD",
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
