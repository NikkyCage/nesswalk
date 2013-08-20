#include "Button.angelscript"
#include "Character.angelscript"
//#include "Npc.angelscript"

class GameScene : Scene
{
	private Button@ m_exitButton;
	private Character@ m_character;
	bool hideCursor = true;
	bool showCursor = false;
	ETHEntity@ m_entity;

	GameScene()
	{
		const string sceneName = "scenes/test.esc";
		//const string sceneName = "empty";
		super(sceneName);
	}
	

	void onCreated()
	{
		HideCursor(hideCursor);
		//const uint tilemapWidth = 64;
		//const uint tilemapHeight = 64;
		//const vector2 tileSize = vector2(32, 32);
		@m_exitButton = Button("sprites/return_button.png", vector2(0.0f, 0.0f), vector2(0.0f, 0.0f));
		
		
		const vector2 screenMiddle(GetScreenSize() * 0.5f);
		@m_character = Character("ness.ent", screenMiddle);
			
		
		
/*		for (uint y = 0; y < tilemapHeight; y++)
		{
			for (uint x = 0; x < tilemapWidth; x++)
			{
				AddEntity("tile.ent", vector3(float(x) * tileSize.x, float(y) * tileSize.y,-1));
			}
		}
*/	
	}

	void onUpdate()
	{
		m_character.update();

		m_exitButton.putButton();
		if (m_exitButton.isPressed())
		{
			HideCursor(showCursor);
			g_sceneManager.setCurrentScene(MainMenuScene());
		}
	}
}
