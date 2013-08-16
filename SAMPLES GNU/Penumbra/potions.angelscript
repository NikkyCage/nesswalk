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

void doPotion(ETHEntity @thisEntity)
{
	ETHEntityArray entityArray;
	GetEntitiesFromBucket(thisEntity.GetCurrentBucket(), entityArray);
	for (uint t=0; t<entityArray.size(); t++)	
	{
		if (getDist(entityArray[t].GetPositionXY(), thisEntity.GetPositionXY()) < 20.0f)
		{
			if (isAMainCharacter(entityArray[t]))
			{
				if (entityArray[t].GetIntData("hp") >= entityArray[t].GetIntData("maxHp"))
					return;
				addToHp(entityArray[t], thisEntity.GetIntData("hp"));
				DeleteEntity(thisEntity);
				AddEntity("potion_pick.ent", thisEntity.GetPosition()+vector3(0,0,16), 0.0f);
			}
		}
	}
}

void ETHCallback_potion(ETHEntity @thisEntity)
{
	doPotion(thisEntity);
}

void ETHCallback_potion_small(ETHEntity @thisEntity)
{
	doPotion(thisEntity);
}

void ETHCallback_potion_large(ETHEntity @thisEntity)
{
	doPotion(thisEntity);
}