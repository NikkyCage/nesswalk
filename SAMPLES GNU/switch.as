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

class Switch
{
	Switch(const string b0, const string b1)
	{
		current = 0;
		button.resize(2);
		button[0] = b0;
		button[1] = b1;
	}

	Switch(const string b0, const string img0, const string b1, const string img1)
	{
		current = 0;
		button.resize(2);
		button[0] = b0;
		button[1] = b1;

		image.resize(2);
		image[0] = img0;
		image[1] = img1;
	}

	void put(const vector2 pos, const string font, const float size, const float width)
	{
		ETHInput @input = GetInputHandle();
		const vector2 cursor = input.GetCursorPos();
		vector2 drawCursor(pos);

		for (uint t=0; t<2; t++)
		{
			if (image.length() > 0)
				LoadSprite(image[t]);

			string str = "[" + ((current == t) ? "�" : " ") + "] ";
			if (image.length() == 0)
				str += button[t];

			const vector2 switchPos(drawCursor);
			const vector2 switchSize((image.length()==0) ? vector2(width, size) : GetSpriteSize(image[t]));

			uint8 alpha = 100;
			if (cursor.x > switchPos.x && cursor.y > switchPos.y
				&& cursor.x < switchPos.x+switchSize.x && cursor.y < switchPos.y+switchSize.y)
			{
				alpha = 200;
				if (getConfirmButtonStatus(0) == KS_HIT)
				{
					current = t;
				}
			}

			const uint8 currentAlpha = (current == t) ? 255 : alpha;
			shadowText(drawCursor, str, font, size, currentAlpha, 203, 203, 228);
			if (image.length() > 0)
			{
				DrawSprite(image[t], drawCursor+vector2(30,0), ARGB(currentAlpha, 255, 255, 255));
			}
			drawCursor.y += switchSize.y;
		}
	}
	
	uint getCurrent() const
	{
		return current;
	}

	void setCurrent(const uint newCurrent)
	{
		current = newCurrent;
	}
	
	private uint current;
	private string[] button;
	private string[] image;
}
