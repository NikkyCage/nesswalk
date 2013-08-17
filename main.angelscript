#include "eth_util.angelscript"
#include "SceneManager.angelscript"
#include "MainMenuScene.angelscript"
#include "GameScene.angelscript"
#include "Collide.angelscript"

dictionary g_frameTimers;
//enmlFile g_gameData;
//ETHEntityArray g_spawn;
//ETHEntityArray g_sounds;
//MessageManager g_messages;
//CameraManager g_camera;
//Timer g_timer;

void main()
{
	g_sceneManager.setCurrentScene(MainMenuScene());
}
