#include "FrameTimer.angelscript"

class Character
{
	ETHEntity@ m_entity;

	private FrameTimer m_frameTimer;
	private uint m_directionLine = 0;
	

	Character(const string &in entityName, const vector2 pos)
	{
		AddEntity(entityName, vector3(pos, 0.0f), m_entity);
	}

	void update()
	{
		ETHInput@ input = GetInputHandle();
		vector2 direction(0, 0);
		bool hasMoved = false;

		// find current move direction based on keyboard keys
		if (input.KeyDown(K_LEFT))
		{
			m_directionLine = 3;
			direction += vector2(-1, 0);
			hasMoved = true;
		}
		if (input.KeyDown(K_RIGHT))
		{
			m_directionLine = 5;
			direction += vector2(1, 0);
			hasMoved = true;
		}
		if (input.KeyDown(K_UP))
		{
			if (input.KeyDown(K_LEFT))
			{
				m_directionLine = 4;
				direction += vector2(-1, -1);
				//hasMoved = true;
			}
			else
			if (input.KeyDown(K_RIGHT))
			{
				m_directionLine = 6;
				direction += vector2(1, -1);
				//hasMoved = true;
			}
			else
			m_directionLine = 7;
			direction += vector2(0,-1);
			hasMoved = true;
		}
		if (input.KeyDown(K_DOWN))
		{
			if (input.KeyDown(K_LEFT))
			{
				m_directionLine = 0;
				direction += vector2(-1, 1);
				//hasMoved = true;
			}
			else
			if (input.KeyDown(K_RIGHT))
			{
				m_directionLine = 2;
				direction += vector2(1, 1);
				//hasMoved = true;
			}
			else
			m_directionLine = 1;
			direction += vector2(0, 1);
			hasMoved = true;
		}
		if(hasMoved)
		{
			SetCameraPos(m_entity.GetPositionXY()-(GetScreenSize()/2));
		}

		// if there's movement, update animation
		if (direction.length() != 0.0f)
			m_frameTimer.update(0, 3, 150);
		else
			m_frameTimer.update(0, 0, 150);

		// update entity
		const float walk = 2.5f;
		const float run = 5.0f;
		const uint currentFrame = m_frameTimer.getCurrentFrame();
		m_entity.AddToPositionXY(normalize(direction) * walk);
		m_entity.SetFrame(currentFrame, m_directionLine);
		
		if (input.KeyDown(K_SHIFT))
		{
			m_entity.AddToPositionXY(normalize(direction) * run);
			m_entity.SetFrame(currentFrame, m_directionLine);
		}
	}
	

}
