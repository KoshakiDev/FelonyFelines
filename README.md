# TOEDOE:
- Velocity used to apply direction FIXED [ Range weapons now apply knockback to player ]
- enable/disable fast run optimize
- Fix limited bullets
- Single player mode (if possible add AI to Second player)
- Improve map
- Add behaviors to enemies

## GENERAL ENEMY Behaviour:
- There is a slight chance that an enemy will cause an explosion caused by a weapon:
  - Any gun
  - Axe
- Enemies caught in explosion will receive damage and have a higher chance to explode too
- Players caught in explosion will also receive damage

### Gunner Behaviour:
- If the player has a gun, increase the engage range radius, 
- The closer the player is, the lower the spread angle, increase amount, lower shot delay
- If the player is attacking (pressing attack button), lower the shot delay for 2 seconds

### Ball Behaviour:
- If the player has a gun, reduce cooldown duration
- The closer the player is, the faster the ball will roll (add acceleration/decelleration)
