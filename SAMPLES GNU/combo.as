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

const uint MAX_COMBO_KEYS = 5;
const uint BUTTON_STRIDE = 210;

const uint CMD_NONE = 0;
const uint CMD_UP = 1;
const uint CMD_DOWN = 2;
const uint CMD_LEFT = 3;
const uint CMD_RIGHT = 4;
const uint CMD_SWORD = 5;
const uint CMD_SPELL = 6;

class Combo
{
	Combo()
	{
		keys.resize(MAX_COMBO_KEYS);
		lastInput = 0;
		index = 0;
	}
	
	void updateInput(const uint player)
	{
		if (index >= MAX_COMBO_KEYS)
			index = MAX_COMBO_KEYS-1;
		
		if (getLeftButtonStatus(player) == KS_HIT)
		{
			keys[index] = CMD_LEFT;
			lastInput = GetTime();
			index++;
			return;
		}
		
		if (getRightButtonStatus(player) == KS_HIT)
		{
			keys[index] = CMD_RIGHT;
			lastInput = GetTime();
			index++;
			return;
		}
		
		if (getUpButtonStatus(player) == KS_HIT)
		{
			keys[index] = CMD_UP;
			lastInput = GetTime();
			index++;
			return;
		}
		
		if (getDownButtonStatus(player) == KS_HIT)
		{
			keys[index] = CMD_DOWN;
			lastInput = GetTime();
			index++;
			return;
		}

		if (getAttack01ButtonStatus(player) == KS_HIT)
		{
			keys[index] = CMD_SWORD;
			lastInput = GetTime();
			index++;
			return;
		}
	
		if (getAttack02ButtonStatus(player) == KS_HIT)
		{
			keys[index] = CMD_SPELL;
			lastInput = GetTime();
			index++;
			return;
		}
	
		if (GetTime()-lastInput > BUTTON_STRIDE || index == MAX_COMBO_KEYS)
		{
			zero();
		}
	}
	
	private void zero()
	{
		index = 0;
		for (uint t=0; t<MAX_COMBO_KEYS; t++)
		{
			keys[t] = CMD_NONE;
		}
	}

	bool checkSequence(const uint a, const uint b, const uint c)
	{
		if (keys[0] == a && keys[1] == b && keys[2] == c)
		{
			zero();
			return true;
		}
		return false;
	}
	
	bool checkSequence(const uint a, const uint b, const uint c, const uint d, const uint e)
	{
		if (keys[0] == a && keys[1] == b && keys[2] == c
			&& keys[3] == d && keys[4] == e)
		{
			zero();
			return true;
		}
		return false;
	}
	
	private uint[] keys;
	private uint lastInput;
	private uint index;
}