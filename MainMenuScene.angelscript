#include "Button.angelscript"

class MainMenuScene : Scene
{
	private Button@ m_startGameButton;
	private Button@ m_quitGameButton;

	MainMenuScene()
	{
		const string sceneName = "empty";
		super(sceneName);
	}

	void onCreated()
	{
		const vector2 screenMiddle(GetScreenSize() * 0.5f);

		@m_startGameButton = Button("sprites/start_game.png", screenMiddle);
		@m_quitGameButton = Button("sprites/quit_game.png", screenMiddle, vector2(0.5f, -0.5f));

		AddEntity("grassbg.ent", vector3(screenMiddle, 0.0f));
	}

	void onUpdate()
	{
		m_startGameButton.putButton();
		m_quitGameButton.putButton();

		if (m_startGameButton.isPressed())
		{
			g_sceneManager.setCurrentScene(GameScene());
		}
		else
		if (m_quitGameButton.isPressed())
		{
			Exit();
		}
	}
}
