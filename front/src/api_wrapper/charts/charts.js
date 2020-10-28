import config from '../../config.json';

export async function getDayNightChart(userId, days) {
  try {
    const data = await fetch(`${config.api_url}/chartmanager/daynightdata/${userId}/${days}`, {
      method: 'GET',
    });
    return (await data.json());
  } catch (e) {
    return { error: e };
  }
}