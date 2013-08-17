#include "FrameTimer.angelscript"

class Npc
{
	ETHEntity@ n_entity;
	
	private FrameTimer n_frameTimer;
	private uint n_directionLine = 0;
	
	Npc(const string &in entityName, const vector2 pos)
	{
		AddEntity(entityName, vector3(pos, 5.0f), n_entity);
	}
	
	void updateNPC()
	{
		vector2 direction(0, 0);
		bool npcMove = true;
		
		if (npcMove)
		{
			n_directionLine = 3;
			direction += vector2(-1, 0)
			npcMove= true;
		}
		
		if (direction.length() != 0.0f)
			n_frameTimer.update(0, 3, 150);
		else
			n_frameTimer.update(0, 0, 150);
			
			const float speed = 2.2f;
			const uint npcFrame = n_frameTimer.getCurrentFrame();
			n_entity.AddToPositionXY(normalize(direction) * speed);
			n_entity.SetFrame(npcFrame, n_directionLine);
		
	}
}