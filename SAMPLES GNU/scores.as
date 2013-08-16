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

const uint MAX_SCORES = 5;

bool addNewRecordTime(const uint elapsed)
{
	bool r = false;
	enmlFile highScores;
	const string str = GetStringFromFile(GetAbsolutePath("hs.enml"));
	highScores.parseString(str);
	
	uint score = 0;
	uint[] list(MAX_SCORES+1);

	for (uint t=0; t<MAX_SCORES; t++)
	{
		highScores.getUint("hs", "hs" + t, score);
		list[t] = score;
	}

	list[MAX_SCORES] = elapsed;
	
	for (uint i=0; i<=MAX_SCORES; i++)
	{
		for (uint j=0; j<=MAX_SCORES; j++)
		{
			for (uint k=0; k<=MAX_SCORES; k++)
			{
				if (list[i] < list[j])
				{
					const uint temp = list[i];
					list[i] = list[j];
					list[j] = temp;
				}
			}
		}
	}
	
	highScores.clear();
	enmlEntity entity;
	for (uint t=0; t<MAX_SCORES; t++)
	{
		if (list[t] == elapsed)
			r = true;
		entity.add("hs" + t, ""+list[t]);
	}
	highScores.addEntity("hs", entity);
	highScores.writeToFile(GetAbsolutePath("hs.enml"));
	return r;
}

string getRecordTimeList()
{
	string r;
	enmlFile highScores;
	const string str = GetStringFromFile(GetAbsolutePath("hs.enml"));
	highScores.parseString(str);

	uint score = 0;

	for (uint t=0; t<MAX_SCORES; t++)
	{
		highScores.getUint("hs", "hs" + t, score);
		r += (uint(t+1) + "    " + getTimeString(score) + "\n");
	}
	return r;
}


uint getGetBestTime()
{
	string r;
	enmlFile highScores;
	const string str = GetStringFromFile(GetAbsolutePath("hs.enml"));
	highScores.parseString(str);

	uint score = 0;
	highScores.getUint("hs", "hs0", score);
	return score;
}
