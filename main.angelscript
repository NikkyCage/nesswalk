#include "eth_util.angelscript"
#include "FrameTimer.angelscript"

void main()
{
	LoadScene("empty", "createNess");
}

void createNess()
{
	const vector2 screenMiddle = GetScreenSize() * .5f;
	AddEntity("ness.ent", vector3(screenMiddle, 0));
}

void ETHConstructorCallback_ness(ETHEntity@ thisEntity)
{
	FrameTimer frameTimer;
	thisEntity.SetObject("frameTimer", @frameTimer);
	thisEntity.SetUInt("directionLine", 0);
}

void ETHCallback_ness(ETHEntity@ thisEntity)
{
	FrameTimer@ frameTimer;
	thisEntity.GetObject("frameTimer", @frameTimer);
	
	ETHInput@ input = GetInputHandle();
	vector2 direction(0, 0);
	
	//defining movement keys and sprite directions
	if (input.KeyDown(K_LEFT))
	{
		thisEntity.SetUInt("directionLine", 3);
		direction += vector2(-1, 0);
		SetCameraPos += vector2(-1, 0);
	}
	if (input.KeyDown(K_RIGHT))
	{
		thisEntity.SetUInt("directionLine", 5);
		direction += vector2(1, 0);
	}
	if (input.KeyDown(K_UP))
	{
		if (input.KeyDown(K_LEFT))
		{
			thisEntity.SetUInt("directionLine", 4);
			direction += vector2(-1, -1);
		}
		else
		if (input.KeyDown(K_RIGHT))
		{
			thisEntity.SetUInt("directionLine", 6);
			direction += vector2(1, -1);
		}
		else
		thisEntity.SetUInt("directionLine", 7);
		direction += vector2(0, -1);
	}
	if (input.KeyDown(K_DOWN))
	{
		if (input.KeyDown(K_LEFT))
		{
			thisEntity.SetUInt("directionLine", 0);//walk down-left anim
			direction += vector2(-1, 1);
		}
		else
		if (input.KeyDown(K_RIGHT))
		{
			thisEntity.SetUInt("directionLine", 2);//walk down-right anim
			direction += vector2 (1, 1);
		}
		else
			thisEntity.SetUInt("directionLine", 1);//walk down anim
			direction += vector2(0, 1);
	}
	if (direction.length() != 0.0f)
		frameTimer.update(0, 3, 150);
	else
		frameTimer.update(0, 0, 150);
	// update entity
	const float speed = UnitsPerSecond(120.0f); // pixels per second
	const uint currentFrame = frameTimer.getCurrentFrame();
	thisEntity.AddToPositionXY(normalize(direction) * speed);

	// finds the current entity frame based on column x row
	thisEntity.SetFrame(currentFrame, thisEntity.GetUInt("directionLine"));
}