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

export async function getTimePerDay(userId, days) {
  try {
    const data = await fetch(`${config.api_url}/chartmanager/timeperdays/${userId}/${days}`, {
      method: 'GET',
    });
    return (await data.json());
  } catch (e) {
    return { error: e };
  }
}

export async function getWorkingTimeAndClocked(userId, days) {
  try {
    const data = await fetch(`${config.api_url}/chartmanager/timeperdays/${userId}/${days}/scheduled`, {
      method: 'GET',
    });
    return (await data.json());
  } catch (e) {
    return { error: e };
  }
}