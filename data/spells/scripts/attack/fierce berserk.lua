local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)

local area = createCombatArea(AREA_SQUARE1X1)
combat:setArea(area)

function onGetFormulaValues(player, skill, attack, factor)
	local skillTotal, levelTotal = skill * attack, player:getLevel() / 5
	return -(((skillTotal * 0.06) + 13) + (levelTotal)), -(((skillTotal * 0.11) + 27) + (levelTotal))
end

combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(creature, var)
	return combat:execute(creature, var)
end