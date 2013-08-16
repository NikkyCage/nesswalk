const float PI = 3.141592654f;
const float PI2 = 3.141592654f*2;
const float PIb = 1.570796327f;

const string endl = "\n";
const string APPLICATION_TITLE = "Penumbra e o Castelo das Sombras - Ethanon Engine";

const float GRAVITY = 1200.0f;

const uint STANDING = 0;
const uint CHASING = 1;
const uint COOLDOWN = 2;

const uint DEAD_FADE_OUT_TIME = 3000;
const uint LIVE_FADE_IN_TIME = 3000;

const uint PVP_MODE = 1;
const uint CAMPAIGN = 2;

const float DEFAULT_CHARSPRITE_CUTX = 4.0f;
const float DEFAULT_CHARSPRITE_CUTY = 4.0f;

const float SIZE_TOLERANCE = 76;

const uint ATTACK_MODE_PHYSICAL = 0;
const uint ATTACK_MODE_FIRE = 1;

const uint MAX_PLAYERS = 2;
const int MAX_PVP_POINTS = 3;

string actionToString(const uint action)
{
	switch (action)
	{
	case STANDING:
		return "STANDING";
	case CHASING:
		return "CHASING";
	case COOLDOWN:
		return "COOLDOWN";
	}
	return "";
}

const string MAIN_CHARACTER_ENTITY0 = "bruxo.ent";
const string MAIN_CHARACTER_ENTITY1 = "princess.ent";

bool isAMainCharacter(ETHEntity @thisEntity)
{
	if (thisEntity.GetEntityName() == MAIN_CHARACTER_ENTITY0)
		return true;
	if (thisEntity.GetEntityName() == MAIN_CHARACTER_ENTITY1)
		return true;
	return false;
}