import config from '../../config.json';
import { getConnexionType } from '../../helpers/getConnexionType';
import { setMobileLocalStorage } from '../../helpers/localStorage';

export async function getDayNightChart(userId, days) {
  try {
    const data = await fetch(
      `${config.api_url}/chartmanager/daynightdata/${userId}/${days}`,
      {
        method: 'GET',
      },
    );
    const res = await data.json();
    setMobileLocalStorage('donutChart', res);
    return res;
  } catch (e) {
    if (getConnexionType() === 'none') {
      return JSON.parse(window.localStorage.getItem('donutChart'));
    }
    return { error: e };
  }
}

export async function getTimePerDay(userId, days) {
  try {
    const data = await fetch(
      `${config.api_url}/chartmanager/timeperdays/${userId}/${days}`,
      {
        method: 'GET',
      },
    );
    const res = await data.json();
    setMobileLocalStorage('barChart', res);
    return res;
  } catch (e) {
    if (getConnexionType() === 'none') {
      return JSON.parse(window.localStorage.getItem('barChart'));
    }
    return { error: e };
  }
}

export async function getWorkingTimeAndClocked(userId, days) {
  try {
    const data = await fetch(
      `${config.api_url}/chartmanager/timeperdays/${userId}/${days}/scheduled`,
      {
        method: 'GET',
      },
    );
    const res = await data.json();
    setMobileLocalStorage('lineChart', res);
    return res;
  } catch (e) {
    if (getConnexionType() === 'none') {
      return JSON.parse(window.localStorage.getItem('lineChart'));
    }
    return { error: e };
  }
}
