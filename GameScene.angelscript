#include "Button.angelscript"
#include "Character.angelscript"
//#include "Npc.angelscript"

class GameScene : Scene
{
	private Button@ m_exitButton;
	private Character@ m_character;
	//private Npc@ m_npc;
	bool hideCursor = true;
	bool showCursor = false;
	//private Grass@ m_grass;

	GameScene()
	{
		const string sceneName = "scenes/scenegrass.esc";
		//const string sceneName = "empty";
		super(sceneName);
	}
	

	void onCreated()
	{
		HideCursor(hideCursor);
		@m_exitButton = Button("sprites/return_button.png", vector2(0.0f, 0.0f), vector2(0.0f, 0.0f));
		
		const vector2 screenMiddle(GetScreenSize() * 0.5f);
		//+-AddEntity("frank.ent", vector3(screenMiddle, 1.0f));
		@m_character = Character("ness.ent", screenMiddle);
		//@m_npc = Npc("frank.ent");
		
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
