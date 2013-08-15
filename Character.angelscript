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
		//vector2 

		// find current move direction based on keyboard keys
		if (input.KeyDown(K_LEFT))
		{
			m_directionLine = 3;
			direction += vector2(-1, 0);
			//SetCameraPos += vector2(20.0f, 20.0f);
			//AddToCameraPos(direction += direction);
		}
		if (input.KeyDown(K_RIGHT))
		{
			m_directionLine = 5;
			direction += vector2(1, 0);
			//AddToCameraPos(direction += direction);
		}
		if (input.KeyDown(K_UP))
		{
			if (input.KeyDown(K_LEFT))
			{
				m_directionLine = 4;
				direction += vector2(-1, -1);
				//AddToCameraPos(direction);
			}
			else
			if (input.KeyDown(K_RIGHT))
			{
				m_directionLine = 6;
				direction += vector2(1, -1);
				//AddToCameraPos(direction += direction);
			}
			else
			m_directionLine = 7;
			direction += vector2(0,-1);
			//AddToCameraPos(direction += direction);
		}
		if (input.KeyDown(K_DOWN))
		{
			if (input.KeyDown(K_LEFT))
			{
				m_directionLine = 0;
				direction += vector2(-1, 1);
				//AddToCameraPos(direction += direction);
			}
			else
			if (input.KeyDown(K_RIGHT))
			{
				m_directionLine = 2;
				direction += vector2(1, 1);
				//AddToCameraPos(direction += direction);
			}
			else
			m_directionLine = 1;
			direction += vector2(0, 1);
			//AddToCameraPos(direction += direction);
		}

		// if there's movement, update animation
		if (direction.length() != 0.0f)
			m_frameTimer.update(0, 3, 150);
		else
			m_frameTimer.update(0, 0, 150);

		// update entity
		const float speed = 2.0f;
		const uint currentFrame = m_frameTimer.getCurrentFrame();
		m_entity.AddToPositionXY(normalize(direction) * speed);
		m_entity.SetFrame(currentFrame, m_directionLine);
	}
}
