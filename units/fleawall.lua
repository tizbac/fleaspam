local unitName = "FLEAWALL"

local unitDef = {
  buildCostEnergy    = 5000,
  buildCostMetal     = 1000,
  builder            = false,
  buildPic           = "fleawall.png",
  buildTime          = 789,
  canAttack          = false,
  canGuard           = false,
  canMove            = false,
  canPatrol          = false,
  canstop            = "1",
  category           = "LEVEL1 ALL",
  corpse             = "DEAD",
  defaultmissiontype = "Standby",
  description        = "Anti-Flea protection wall",
  energyMake         = 0.0,
  energyStorage      = 0,
  energyUse          = 5.0,
  explodeAs          = "BIG_UNITEX",
  firestandorders    = "1",
  footprintX         = 11,
  footprintZ         = 2,
  idleAutoHeal       = 5,
  idleTime           = 1800,
  mass               = 7000,
  maxDamage          = 20000,
  metalStorage       = 1000,
  name               = "Fleawall",
  noChaseCategory    = "VTOL",
  objectName         = "fleawall.s3o",
  seismicSignature   = 0,
  selfDestructAs     = "BIG_UNIT",
  side               = "ARM",
  sightDistance      = 550,
  unitname           = "FLEAWALL",
  workerTime         = 0,
  collisionVolumeType = "box",
  collisionVolumeOffsets = "0 0 0",
  collisionVolumeScales = "150 30 20",
  collisionVolumeTest = 1,
}
  
return lowerkeys({ [unitName] = unitDef })