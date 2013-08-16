/*
PORTUGU�S
---------

Este arquivo � parte do Penumbra.

Penumbra � software livre; voc� pode redistribu�-lo e/ou
modific�-lo sob os termos da Licen�a P�blica Menos Geral (LGPL)
GNU, conforme publicada pela Free Software Foundation; tanto a
vers�o 3 da Licen�a como (a seu crit�rio) qualquer vers�o mais
nova.

Penumbra � distribu�do na expectativa de ser �til, mas
SEM QUALQUER GARANTIA; sem mesmo a garantia impl�cita de
COMERCIALIZA��O ou de ADEQUA��O A QUALQUER PROP�SITO EM
PARTICULAR. Consulte a Licen�a P�blica Geral Menor (LGPL) GNU
para obter mais detalhes.

Voc� deve ter recebido uma c�pia da Licen�a P�blica Menos Geral
GNU junto com este programa; se n�o, veja em
<http://www.gnu.org/licenses/>.

ENGLISH
-------

This file is part of Penumbra.

Penumbra is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

Penumbra is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with Ethanon Engine. If not, see
<http://www.gnu.org/licenses/>.
*/

class CameraManager
{
	CameraManager()
	{
		mainCharPos0 = vector2(0,0);
		mainCharPos1 = vector2(0,0);
		screenLimit = vector2(0.4f, 0.3f);
		cameraSpeed = 150.0f;
		earthquake = 0.0f;
		lastTremble = 0;
		trembleInterval = 70;
		eqForth = true;
		backValue = 0;
		inBoundsLastTime = 0;
		accelerationTime = 20000;
	}
	
	void setCameraSpeed(const float speed)
	{
		cameraSpeed = speed;
	}
	
	void setMainCharPos(const vector2 v, const uint player)
	{
		if (player == 0)
			mainCharPos0 = v;
		else if (player == 1)
			mainCharPos1 = v;
	}

	vector2 getMainCharPos(const uint player) const
	{
		if (player == 0)
			return mainCharPos0;
		else if (player == 1)
			return mainCharPos1;
		return vector2(0,0);
	}

	private void doEarthquake()
	{
		if (earthquake != 0 && (GetTime()-lastTremble) >= trembleInterval)
		{
			if (eqForth)
			{
				AddToCameraPos(vector2(0,earthquake));
				backValue = earthquake;
				eqForth = !eqForth;
			}
			else
			{
				AddToCameraPos(vector2(0,-backValue));
				earthquake *= 0.5f;
				eqForth = !eqForth;
			}
			lastTremble = GetTime();
		}
		if (abs(earthquake) < 1.0f)
		{
			earthquake = 0.0f;
		}
	}
	
	void startEarthquake(const float force)
	{
		earthquake = abs(force);
	}

	void adjustCameraPos(const bool pvpMode)
	{
		doEarthquake();
		float speedBias = 0;

		vector2 mainCharPos = mainCharPos0;
		
		if (mainCharPos1 != vector2(0,0))
		{
			mainCharPos = (mainCharPos0+mainCharPos1)/2;
		}

		vector2 currentCamPos = GetCameraPos();
		const vector2 screenSize = GetScreenSize();
		const vector2 screenMainCharPos = mainCharPos-currentCamPos;
		const vector2 camMax = screenSize+currentCamPos;
		
		if (screenMainCharPos.x > (1-screenLimit.x)*screenSize.x)
			currentCamPos = vector2(mainCharPos.x-((1-screenLimit.x)*screenSize.x), currentCamPos.y);
		if (screenMainCharPos.x < (screenLimit.x)*screenSize.x)
			currentCamPos = vector2(mainCharPos.x-((screenLimit.x)*screenSize.x), currentCamPos.y);

		if (screenMainCharPos.y > (1-screenLimit.y)*screenSize.y)
			currentCamPos = vector2(currentCamPos.x, mainCharPos.y-((1-screenLimit.y)*screenSize.y));
		if (screenMainCharPos.y < (screenLimit.y)*screenSize.y)
			currentCamPos = vector2(currentCamPos.x, mainCharPos.y-((screenLimit.y)*screenSize.y));

		SetCameraPos(currentCamPos);
		SetPositionRoundUp(true);
		roundUpCameraPos();
	}
	
	private void roundUpCameraPos()
	{
		SetCameraPos(vector2(floor(GetCameraPos().x), floor(GetCameraPos().y)));
	}

	private uint accelerationTime;
	private uint inBoundsLastTime;
	private vector2 mainCharPos0;
	private vector2 mainCharPos1;
	private vector2 screenLimit;
	private float cameraSpeed;
	private float earthquake;
	private uint lastTremble;
	private uint trembleInterval;
	private bool eqForth;
	private float backValue;
}